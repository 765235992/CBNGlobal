//
//  CBNHomePageVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/15.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNHomePageVC.h"
#import "CBNFileManager.h"
#import "CBNChannelNewsTextCell.h"
#import "CBNHomePageHeaderView.h"
#import "CBNLiveVC.h"
#import "CBNTextDetailVC.h"
#import "CBNChannelListRequest.h"

@interface CBNHomePageVC ()<UITableViewDataSource,UITableViewDelegate,CBNHomePageHeaderViewDelegate>

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) CBNHomePageHeaderView *tableViewHeaderView;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *liveModelArray;

@property (nonatomic, assign) NSInteger sliderID;

@property (nonatomic, assign) NSInteger mainChannelID;

@end

@implementation CBNHomePageVC
- (void)dealloc
{
    CBNLog(@"主频道释放");

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sourceArray = [[NSMutableArray alloc] init];
    
    self.sliderID = 29;
    
    self.liveChannelID = 206;
    
    self.mainChannelID = 213;
    
    [self.sourceArray addObjectsFromArray:[[CBNNewsItemDao sharedManager]queryNewsItemsDataWithTableName:@"Main"]];
    
    [self.view addSubview:self.aTableView];
    
    [self setUpTableView];
    
}
- (void)setLiveChannelID:(NSInteger)liveChannelID
{
    _liveChannelID = liveChannelID;
    
    __weak typeof(self) weakSelf = self;

    [CBNChannelListRequest loadNewsItemsWithChannelID:_liveChannelID page:1 pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
        
        [[CBNNewsItemDao sharedManager] deleteDataFromTableName:@"Live"];
        
        [[CBNNewsItemDao sharedManager] insertChannelNewsItemsWithTableName:@"Live" andChannelNewsItemArray:channelNewsItemsArray];
        
        [weakSelf.liveModelArray removeAllObjects];
        
        [weakSelf.liveModelArray addObjectsFromArray:channelNewsItemsArray];
        
        weakSelf.tableViewHeaderView.liveModelArray = weakSelf.liveModelArray;
        
    } failed:^(NSError *error) {
        
    }];

}
- (void)setSliderID:(NSInteger)sliderID
{
    _sliderID = sliderID;
    
    __weak typeof(self) weakSelf = self;
    
    
    [CBNChannelListRequest loadNewsItemsWithChannelID:_sliderID page:1 pageSize:10 Secuessed:^(NSArray *channelNewsItemsArray) {
        
        [[CBNNewsItemDao sharedManager] deleteDataFromTableName:@"Slider"];
        NSArray *arr = [NSArray arrayWithObjects:[channelNewsItemsArray firstObject], nil];
        [[CBNNewsItemDao sharedManager] insertChannelNewsItemsWithTableName:@"Slider" andChannelNewsItemArray:arr];
        weakSelf.tableViewHeaderView.remondNewsModel = [channelNewsItemsArray firstObject];
        
        
    } failed:^(NSError *error) {
        
    }];
    
}



- (NSMutableArray *)liveModelArray
{
    
    if (!_liveModelArray) {
        
        self.liveModelArray = [[NSMutableArray alloc] init];
        
    }
    
    return _liveModelArray;
}


#define 添加刷新效果和加载更多效果
- (void)setUpTableView
{
    
    
    _aTableView.tableHeaderView = self.tableViewHeaderView;
    self.tableViewHeaderView.remondNewsModel = [[[CBNNewsItemDao sharedManager]queryNewsItemsDataWithTableName:@"Slider"] firstObject];
    [self.liveModelArray addObjectsFromArray: [[CBNNewsItemDao sharedManager]queryNewsItemsDataWithTableName:@"Live"]];
    _tableViewHeaderView.liveModelArray = _liveModelArray;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHomePageDataFromSever)];
    
    // 设置文字
    [header setTitle:@"Pull down to refresh…" forState:MJRefreshStateIdle];
    
    [header setTitle:@"Begin to refresh" forState:MJRefreshStatePulling];
    
    [header setTitle:@"Refreshing......" forState:MJRefreshStateRefreshing];
    // 设置字体
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

    _currentPage = 1;
    
    self.sliderID = 29;
    
    self.liveChannelID = 206;

    [CBNChannelListRequest loadNewsItemsWithRootID:_mainChannelID page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
        
        [[CBNNewsItemDao sharedManager] deleteDataFromTableName:@"Main"];
        
        [[CBNNewsItemDao sharedManager] insertChannelNewsItemsWithTableName:@"Main" andChannelNewsItemArray:channelNewsItemsArray];
        
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
    [CBNChannelListRequest loadNewsItemsWithRootID:_mainChannelID page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
//        [weakSelf.sourceArray removeAllObjects];
        
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
        
        self.aTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        
        _aTableView.backgroundColor = [UIColor whiteColor];
        
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _aTableView.delegate = self;
        
        _aTableView.dataSource = self;
    }
    
    return _aTableView;
}
- (CBNHomePageHeaderView *)tableViewHeaderView
{
    if (!_tableViewHeaderView) {
        
        self.tableViewHeaderView = [[CBNHomePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Width)];
        _aTableView.backgroundColor = [UIColor whiteColor];
        
        _tableViewHeaderView.delegate = self;
    }
    
    return _tableViewHeaderView;
}
- (void)homePageHeaderLiveShuffingView:(CBNHomePageHeaderView *)homePageView didSelectedAtIndex:(NSInteger)index
{
    CBNLiveVC *liveVC = [[CBNLiveVC alloc] init];
    
    NSLog(@"%@",_liveModelArray);
    liveVC.liveModelArray = _liveModelArray;
    liveVC.liveChannelID = _liveChannelID;
    
    [self.navigationController pushViewController:liveVC animated:YES];

}
- (void)homePageHeaderLiveShuffingView:(CBNHomePageHeaderView *)homePageView recommendedNews:(id)news
{
    
    [self pushToTextNewsDetailWithNewsItemModel:homePageView.remondNewsModel];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentefier = @"CBNChannelNewsTextCell";
    
    
    CBNChannelNewsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:indentefier];
    
    if (cell == nil) {
        
        cell = [[CBNChannelNewsTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentefier];
        
    }
    cell.itemModel = [_sourceArray objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return news_Cell_Height;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self pushToTextNewsDetailWithNewsItemModel:[_sourceArray objectAtIndex:indexPath.row]];
}

@end
