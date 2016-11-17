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
#import "CBNTextDetailVC.h"
#import "CBNChannelListRequest.h"
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
    [self cleanRightBar];
    [self setUpTableView];
    
}
- (void)setLiveModelArray:(NSMutableArray *)liveModelArray
{
    _liveModelArray = liveModelArray;
    _currentPage = 1;
    _currentPage++;
    CBNLiveModel *model = [liveModelArray firstObject];
    
    NSString *timeStr = [NSDate getNormalDateFromUTCDateString:model.newsModel.LastDate];
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
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshLiveDataFromSever)];
    
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont refreshAndLoadingFont];
    header.lastUpdatedTimeLabel.font = [UIFont refreshAndLoadingFont];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor grayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor grayColor];

//    CBNRefreshHeader *header = [CBNRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshLiveDataFromSever)];
    
    // 设置刷新控件
    self.aTableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreLiveDataFromSever)];
    
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
- (void)refreshLiveDataFromSever
{
    _currentPage = 1;
    
    __weak typeof(self) weakSelf = self;
    
    [CBNChannelListRequest loadNewsItemsWithChannelID:_liveChannelID page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
        NSLog(@"%@",channelNewsItemsArray);
        [weakSelf.sourceArray removeAllObjects];
        
        [weakSelf.sourceArray addObjectsFromArray:[CBNNewSqliteManager  liveDictionaryChanegeToLiveModekWithDictionaryArray:channelNewsItemsArray]];

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
- (void)loadMoreLiveDataFromSever
{
    
    __weak typeof(self) weakSelf = self;
    
    [CBNChannelListRequest loadNewsItemsWithChannelID:_liveChannelID page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {

        [weakSelf.sourceArray addObjectsFromArray:[CBNNewSqliteManager  liveDictionaryChanegeToLiveModekWithDictionaryArray:channelNewsItemsArray]];
        
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




#pragma mark UITableViewDataSource_And_UITableViewDelegate

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
    CBNLiveModel *tempModel = (CBNLiveModel *)[_sourceArray objectAtIndex:indexPath.row];
    
    cell.liveModel = tempModel;
    
    tempModel = cell.liveModel;
    
    [_sourceArray replaceObjectAtIndex:indexPath.row withObject:tempModel];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBNLiveModel *tempModel = (CBNLiveModel *)[_sourceArray objectAtIndex:indexPath.row];

    return tempModel.height;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
}
#pragma mark CBNLiveNewsCellDelegate

- (void)liveNewsCell:(CBNLiveNewsCell *)liveCell detailButtonClickedWithLiveModel:(CBNLiveModel *)liveMoel
{

    CBNTextDetailVC *liveDetailVC = [[CBNTextDetailVC alloc] init];
    
    liveDetailVC.newsID = liveMoel.newsModel.NewsID;
    
    [self.navigationController pushViewController:liveDetailVC animated:YES];
    
}
#pragma mark create_Objects

- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        
        self.sourceArray = [[NSMutableArray alloc] init];
    }
    
    return _sourceArray;
}
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

@end
