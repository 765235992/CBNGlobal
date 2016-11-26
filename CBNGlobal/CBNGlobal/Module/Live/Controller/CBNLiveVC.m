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
#import "CBNNetPromptView.h"

@interface CBNLiveVC ()<UITableViewDataSource,UITableViewDelegate,CBNLiveNewsCellDelegate>

@property (nonatomic, assign) BOOL isHaveNoNetwork;

@property (nonatomic, strong) CBNNetPromptView *netPromptView;

@property (nonatomic, strong) CBNLiveHeaderView *aTableViewHeaderView;

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSString *curentDate;

@property (nonatomic, strong) NSMutableArray *orginalArray;
@end

@implementation CBNLiveVC
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"networkState" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.isHaveNoNetwork = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:@"networkState" object:nil];

    [self setBackBarButtonItem];
    [self setNavigationTitle:@"Live" withTextColor:[UIColor whiteColor]];
    [self cleanRightBar];
    [self setUpTableView];
    [self.view addSubview:self.netPromptView];
    
    
}
- (void)netWorkChangedWithNetWorkState:(BOOL)currentNetworkState
{
    if ( currentNetworkState == YES && self.isHaveNoNetwork == YES) {
        
    }else{
        [self.view bringSubviewToFront:self.netPromptView];
        
        if (currentNetworkState == YES && self.isHaveNoNetwork == NO) {
            
            self.isHaveNoNetwork = YES;
            [_netPromptView networkStateIsNormal];
            
//            [self networkNormal];
            
            
        }else if (self.isHaveNoNetwork == YES && currentNetworkState == NO){
            self.isHaveNoNetwork = NO;
            [_netPromptView networkStatusIsAbnormal];
            
        }
        
    }

}

- (void)networkChanged:(NSNotification *)notification{
    
    NSDictionary *dic = notification.userInfo;
    
    BOOL currentNetworkState = [[dic objectForKey:@"isHavenetwork"] boolValue];
    [self netWorkChangedWithNetWorkState:currentNetworkState];

//    if (isHaveNetwork == NO && self.isHaveNoNetwork == NO) {
//        self.isHaveNoNetwork = YES;
//        [_netPromptView networkStatusIsAbnormal];
//
//        
//    }
//    if (self.isHaveNoNetwork == YES && isHaveNetwork == YES) {
//        self.isHaveNoNetwork = NO;
//        [_netPromptView networkStateIsNormal];
//    }
    
    
    
    
//    _leftChannelVC.currentNetWorkState = isHaveNetwork;
//    
//    if (isHaveNetwork == YES) {
//        
//        [self requestChannelItem];
//        
//    }
}


- (void)setLiveModelArray:(NSMutableArray *)liveModelArray
{
    _liveModelArray = liveModelArray;
    _currentPage = 1;
    _currentPage++;
    [self.orginalArray addObjectsFromArray:_liveModelArray];
    [self groupingLiveModelWithArray:_orginalArray];
    [self.aTableView reloadData];

}

- (CBNNetPromptView *)netPromptView
{
    if (!_netPromptView) {
        
        self.netPromptView = [[CBNNetPromptView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, 35)];
        
        _netPromptView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _netPromptView;
}

- (void)groupingLiveModelWithArray:(NSArray *)liveArray
{
    
    if (liveArray.count <=0) {
        //没有新数据直接返回
        return;
        
    }
    
    
    
    NSMutableArray *groupArray = [[NSMutableArray alloc]init];

    NSMutableArray *currentArray = [NSMutableArray array];
    
    [currentArray addObject:liveArray[0]];
    
    [groupArray addObject:currentArray];

    
    
    // 如果不止一个,才要动态添加
    if(liveArray.count > 1){
        for (int i = 1; i < liveArray.count; i++) {
            // 先取出组数组中  上一个数组的第一个元素的createTime
            NSMutableArray *preModelArr = [groupArray objectAtIndex:groupArray.count-1];
            
            
            CBNLiveModel *liveModel=[preModelArr objectAtIndex:0];
            
            // 取出当前,根据createTime比较,如果相同则添加到同一个元素;如果不相同,说明不是同一个组的
            CBNLiveModel *liveModelTemp=[liveArray objectAtIndex:i];

            if ([self timeCompareWith:[NSDate getNormalDateFromUTCDateString:liveModel.newsModel.CreateDate] secondTime:[NSDate getNormalDateFromUTCDateString:liveModelTemp.newsModel.CreateDate]]) {
                [currentArray addObject:liveModelTemp];
            }else{
                // 如果不相同,说明 有新的一组,那么创建一个元素数组,并添加到组数组groupArr
                currentArray = [NSMutableArray array];
                [currentArray addObject:liveModelTemp];
                [groupArray addObject:currentArray];
            }
        }
    }
    
    
    NSLog(@"%@",groupArray);
    
    self.sourceArray = groupArray;
    

    
}

- (BOOL)timeCompareWith:(NSString *)firstTime secondTime:(NSString *)senondTime
{
    if ([firstTime isEqualToString:senondTime]) {
        return YES;
    }else{
        
        return NO;
    }
}

#define 添加刷新效果和加载更多效果
- (void)setUpTableView
{
    
    [self.view addSubview:self.aTableView];
    
//    _aTableView.tableHeaderView = self.aTableViewHeaderView;
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

        [weakSelf.orginalArray removeAllObjects];
        
        [weakSelf.orginalArray addObjectsFromArray:[CBNNewSqliteManager  liveDictionaryChanegeToLiveModekWithDictionaryArray:channelNewsItemsArray]];
        

        [self groupingLiveModelWithArray:weakSelf.orginalArray];
        
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

//        [self groupingLiveModelWithArray:[CBNNewSqliteManager  liveDictionaryChanegeToLiveModekWithDictionaryArray:channelNewsItemsArray]];
        
        [weakSelf.orginalArray addObjectsFromArray:[CBNNewSqliteManager  liveDictionaryChanegeToLiveModekWithDictionaryArray:channelNewsItemsArray]];
        
        
        [self groupingLiveModelWithArray:weakSelf.orginalArray];

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *temp = [_sourceArray objectAtIndex:section];
    
    return temp.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentefier = @"CBNLiveNewsCell";
    
    
    CBNLiveNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:indentefier];
    
    if (cell == nil) {
        
        cell = [[CBNLiveNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentefier];
        
        cell.delegate = self;
        
        
    }
    
    NSMutableArray *group = [_sourceArray objectAtIndex:indexPath.section];
    
    cell.index = indexPath.row;
    
    CBNLiveModel *tempModel = (CBNLiveModel *)[group objectAtIndex:indexPath.row];
    
    cell.liveModel = tempModel;
    
    tempModel = cell.liveModel;
    
    
    [group replaceObjectAtIndex:indexPath.row withObject:tempModel];
    [_sourceArray replaceObjectAtIndex:indexPath.section withObject:group];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSArray *group = [self.sourceArray objectAtIndex:indexPath.section];

    CBNLiveModel *tempModel = (CBNLiveModel *)[group objectAtIndex:indexPath.row];
    
    
    return tempModel.height;
    
//    CBNLiveNewsCell *cell = (CBNLiveNewsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
//
//    return cell.frame.size.height;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *group = [_sourceArray objectAtIndex:indexPath.section];
    
    CBNLiveModel *tempModel = (CBNLiveModel *)[group objectAtIndex:indexPath.row];

    CBNTextDetailVC *liveDetailVC = [[CBNTextDetailVC alloc] init];
    liveDetailVC.channelName = @"Live";
    liveDetailVC.newsID = tempModel.newsModel.NewsID;
    
    [self.navigationController pushViewController:liveDetailVC animated:YES];

    
}
#pragma mark CBNLiveNewsCellDelegate

- (void)liveNewsCell:(CBNLiveNewsCell *)liveCell detailButtonClickedWithLiveModel:(CBNLiveModel *)liveMoel
{

    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSArray *group = [_sourceArray objectAtIndex:section];
    
    CBNLiveModel *tempModel = (CBNLiveModel *)[group objectAtIndex:0];
    
    
    
    CBNLiveHeaderView *header =  [[CBNLiveHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, [NSString getTextHeightWithFont:[UIFont newsTitleFont]]+3*news_Cell_Up_Or_Down_Margin)];
    
    
    header.time = [NSDate getNormalDateFromUTCDateString:tempModel.newsModel.CreateDate];
    
    header.backgroundColor = [UIColor whiteColor];

    
    return header;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  [NSString getTextHeightWithFont:[UIFont newsTitleFont]]+3*news_Cell_Up_Or_Down_Margin;
}
- (CBNLiveHeaderView *)aTableViewHeaderView
{
    if (!_aTableViewHeaderView) {
        
        self.aTableViewHeaderView = [[CBNLiveHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, [NSString getTextHeightWithFont:[UIFont newsTitleFont]]+3*news_Cell_Up_Or_Down_Margin)];
        
        _aTableViewHeaderView.backgroundColor = [UIColor redColor];
    }
    
    return _aTableViewHeaderView;
}

- (NSMutableArray *)orginalArray
{
    if (!_orginalArray) {
        
        self.orginalArray = [[NSMutableArray alloc] init];
        
    }
    
    return _orginalArray;
}

@end
