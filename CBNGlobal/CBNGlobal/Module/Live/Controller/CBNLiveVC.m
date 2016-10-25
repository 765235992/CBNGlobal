//
//  CBNLiveVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLiveVC.h"
#import "CBNLiveNewsCell.h"
#import "CBNLiveHeaderView.h"
#import "CBNLiveItemModel.h"
#import "CBNTextDetailVC.h"
#import "CBNChannelListRequest.h"
#import "CBNLiveItemModel.h"
@interface CBNLiveVC ()<UITableViewDataSource,UITableViewDelegate,CBNLiveNewsCellDelegate>

@property (nonatomic, strong) CBNLiveHeaderView *aTableViewHeaderView;

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation CBNLiveVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setBackBarButtonItem];
    [self setNavigationTitle:@"Live"];
    [self setShareBarButtonItem];
    [self setUpTableView];
    
}
- (void)setLiveModelArray:(NSMutableArray *)liveModelArray
{
    _liveModelArray = liveModelArray;
    _currentPage = 1;
    _currentPage++;
    CBNLiveItemModel *model = [liveModelArray firstObject];
    
    NSString *timeStr = [NSDate getNormalDateFromUTCDateString:model.LastDate];
    self.aTableViewHeaderView.time = timeStr;
    [self.sourceArray removeAllObjects];
    
    [_sourceArray addObjectsFromArray:liveModelArray];
    [self.aTableView reloadData];
}


#define 添加刷新效果和加载更多效果
- (void)setUpTableView
{
    
    [self.view addSubview:self.aTableView];
    
    _aTableView.tableHeaderView = self.aTableViewHeaderView;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHomePageDataFromSever)];
    
    // 设置文字
    [header setTitle:@"Pull down to refresh…" forState:MJRefreshStateIdle];
    
    [header setTitle:@"Begin to refresh" forState:MJRefreshStatePulling];
    
    [header setTitle:@"Refreshing......" forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font =  [UIFont refreshAndLoadingFont];
    
    header.lastUpdatedTimeLabel.font = [UIFont refreshAndLoadingFont];
    
    // 设置颜色
    header.stateLabel.dk_textColorPicker = DKColorPickerWithKey(refresh_And_Loading_Color);
    
    header.lastUpdatedTimeLabel.dk_textColorPicker = DKColorPickerWithKey(refresh_And_Loading_Color);
    
    // 设置刷新控件
    self.aTableView.mj_header = header;
    
//    [_aTableView.mj_header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreHomePageDataFromSever)];
    
    [footer setTitle:@"Pull up to load more…" forState:MJRefreshStateIdle];
    
    [footer setTitle:@"Loading more news…" forState:MJRefreshStateRefreshing];
    
    [footer setTitle:@"No more news" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont refreshAndLoadingFont];
    //
    //    // 设置颜色
    footer.stateLabel.dk_textColorPicker = DKColorPickerWithKey(refresh_And_Loading_Color);
    
    // 设置footer
    self.aTableView.mj_footer = footer;
    
    
}
#define 数据加载和刷新
- (void)refreshHomePageDataFromSever
{
    _currentPage = 1;
    
    __weak typeof(self) weakSelf = self;
    
    [CBNChannelListRequest loadNewsItemsWithChannelID:_liveChannelID page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
        [weakSelf.sourceArray removeAllObjects];
        
        [weakSelf.sourceArray addObjectsFromArray:channelNewsItemsArray];
        
        [weakSelf refreshFinished];
        _currentPage++;
        
    } failed:^(NSError *error) {
        [weakSelf refreshFinished];
        
    }];
    
    
}
- (void)refreshFinished
{
    
    [_aTableView reloadData];
    
    [_aTableView.mj_header endRefreshing];
    
}
- (void)loadMoreHomePageDataFromSever
{
    
    __weak typeof(self) weakSelf = self;
    
    [CBNChannelListRequest loadNewsItemsWithChannelID:_liveChannelID page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {

        
        [weakSelf.sourceArray addObjectsFromArray:channelNewsItemsArray];
        
        [weakSelf loadMoreFinished];
        
        _currentPage++;
        
    } failed:^(NSError *error) {
        
        [weakSelf loadMoreFinished];
        
    }];
    
}
- (void)loadMoreFinished
{
    [_aTableView reloadData];
    [_aTableView.mj_footer endRefreshing];
}




/**
 *  @创建视图
 */
- (UITableView *)aTableView
{
    if (!_aTableView) {
        
        self.aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height-64)];
        
        _aTableView.backgroundColor = [UIColor whiteColor];
        
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _aTableView.delegate = self;
        
        _aTableView.dataSource = self;
    }
    
    return _aTableView;
}
- (CBNLiveHeaderView *)aTableViewHeaderView
{
    if (!_aTableViewHeaderView) {
        
        self.aTableViewHeaderView = [[CBNLiveHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, [NSString getTextHeightWithFont:[UIFont newsTitleFont]]+3*news_Cell_Up_Or_Down_Margin)];
        
        _aTableViewHeaderView.backgroundColor = [UIColor clearColor];
    }
    
    return _aTableViewHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentefier = @"CBNLiveNewsCell";
    
    
    CBNLiveNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:indentefier];
    
    if (cell == nil) {
        
        cell = [[CBNLiveNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentefier];
        
        cell.delegate = self;
        
        
    }
    CBNLiveItemModel *tempModel = (CBNLiveItemModel *)[_sourceArray objectAtIndex:indexPath.row];
    
    cell.newsItemModel = tempModel;
    
    tempModel = cell.newsItemModel;
    
    [_sourceArray replaceObjectAtIndex:indexPath.row withObject:tempModel];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBNLiveItemModel *tempModel = (CBNLiveItemModel *)[_sourceArray objectAtIndex:indexPath.row];

    return tempModel.height;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:CBNChannelChanged object:channelInfo];
    
}
- (void)liveNewsCell:(CBNLiveNewsCell *)liveCell detailButtonClickedWithLiveModel:(CBNNewsItemModel *)liveMoel
{

    CBNTextDetailVC *liveDetailVC = [[CBNTextDetailVC alloc] init];
    
    liveDetailVC.newsID = [liveMoel.NewsID integerValue];
    
    [self.navigationController pushViewController:liveDetailVC animated:YES];
    
}

- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        
        self.sourceArray = [[NSMutableArray alloc] init];
    }
    
    return _sourceArray;
}
@end
