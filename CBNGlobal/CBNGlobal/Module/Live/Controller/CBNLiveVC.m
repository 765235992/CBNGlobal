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
#import "CBNLiveModel.h"
#import "CBNLiveDetailVC.h"

@interface CBNLiveVC ()<UITableViewDataSource,UITableViewDelegate,CBNLiveNewsCellDelegate>

@property (nonatomic, strong) CBNLiveHeaderView *aTableViewHeaderView;

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation CBNLiveVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setBackBarButtonItem];
    [self setNavigationTitle:@"Live"];
    [self setShareBarButtonItem];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"live" ofType:@"json"];
    NSData *data=[NSData dataWithContentsOfFile:jsonPath];
    NSError *error;
    NSDictionary *jsonDic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

    for (NSDictionary *tempDic in [jsonDic objectForKey:@"Lives"]) {
        CBNLiveModel *tempModel = [[CBNLiveModel alloc] initWithLiveDictionary:tempDic];
        
        NSLog(@"--- %@",tempModel.liveTitleString);

        [self.sourceArray addObject:tempModel];
        
    }
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setUpTableView];
    
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
    
    [_aTableView.mj_header beginRefreshing];
    
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
    
    __weak typeof(self) weakSelf = self;
    
    //    [[CBNHomePageNewsRequest sharedInstance] refreshHomePageNewsFromSeverWith:0 success:^(NSMutableArray *homePageModelrray, NSMutableArray *sliderArray) {
    //
    //        [self.sourceArray removeAllObjects];
    //
    //        NSMutableArray *arr = [[NSMutableArray alloc] init];
    //
    //        for (CBNNewsItemModel *tempModel in sliderArray) {
    //            CBNShufflingModel *shufflingModel = [[CBNShufflingModel alloc] init];
    //
    //
    //            shufflingModel.newsTitleStr = tempModel.chapt_title;
    //            shufflingModel.newsThumbStr = tempModel.cover_img_big;
    //            shufflingModel.index = [tempModel.type integerValue];
    //
    //            [arr addObject:shufflingModel];
    //
    //        }
    //        weakSelf.headerView.sliderView.shufflingView.sourceModelArray = arr;
    //
    //        [_sourceArray addObjectsFromArray:homePageModelrray];
    //
    //        [weakSelf refreshFinished];
    //
    //    } failed:^(NSString *errorStr) {
    //
    [weakSelf refreshFinished];
    //
    //    }];
    
    
}
- (void)refreshFinished
{
    
    [_aTableView reloadData];
    
    [_aTableView.mj_header endRefreshing];
    
}
- (void)loadMoreHomePageDataFromSever
{
    
    __weak typeof(self) weakSelf = self;
    
    //    [[CBNHomePageNewsRequest sharedInstance] loadMoreHomePageNewsFromSeverWith:0 success:^(NSMutableArray *homePageModelrray) {
    //        [_sourceArray addObjectsFromArray:homePageModelrray];
    //        [weakSelf loadMoreFinished];
    //
    //    } failed:^(NSString *errorStr) {
    [weakSelf loadMoreFinished];
    //
    //    }];
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
    CBNLiveModel *tempModel = [_sourceArray objectAtIndex:indexPath.row];
    
    cell.liveModel = tempModel;
    
    tempModel = cell.liveModel;
    
    [_sourceArray replaceObjectAtIndex:indexPath.row withObject:tempModel];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBNLiveModel *tempModel = [_sourceArray objectAtIndex:indexPath.row];

    return tempModel.liveCellHeight;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:CBNChannelChanged object:channelInfo];
    
}
- (void)liveNewsCell:(CBNLiveNewsCell *)liveCell detailButtonClickedWithLiveModel:(CBNLiveModel *)liveMoel
{
    CBNLiveDetailVC *liveDetailVC = [[CBNLiveDetailVC alloc] init];
    
    liveDetailVC.liveModel = liveMoel;
    
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
