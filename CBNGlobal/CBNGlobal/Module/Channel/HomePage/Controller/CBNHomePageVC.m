//
//  CBNHomePageVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/15.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNHomePageVC.h"
#import "CBNChannelNewsTextCell.h"
#import "CBNHomePageHeaderView.h"
#import "CBNLiveVC.h"
#import "CBNTextDetailVC.h"
#import "CBNChannelListRequest.h"
#import "CBNChannelNoImageCell.h"

@interface CBNHomePageVC ()<UITableViewDataSource,UITableViewDelegate,CBNHomePageHeaderViewDelegate>

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) CBNHomePageHeaderView *tableViewHeaderView;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *liveModelArray;

@property (nonatomic, assign) NSInteger sliderID;
@property (nonatomic, assign) NSInteger liveChannelID;
@property (nonatomic, assign) NSInteger mainChannelID;
@property (nonatomic, assign) BOOL refreshSecuessed;
@end

@implementation CBNHomePageVC
- (void)dealloc
{
    CBNLog(@"主频道释放");

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"liveBeginRefresh" object:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(defaule_Background_Color);

    self.sliderID = 29;
    
    self.liveChannelID = 206;
    
    self.mainChannelID = 213;
    self.refreshSecuessed = NO;
    
   [self.sourceArray addObjectsFromArray:[CBNNewSqliteManager  dictionaryChangeToModelWithDictionaryArray:[[CBNNewSqliteManager sharedManager]selectObjectsfromTable:@"Main"]] ];
    
    
    [self.view addSubview:self.aTableView];
    
    [self setUpTableView];
    
}
- (void)setLiveChannelID:(NSInteger)liveChannelID
{
    _liveChannelID = liveChannelID;
    
    __weak typeof(self) weakSelf = self;

    [CBNChannelListRequest loadNewsItemsWithChannelID:_liveChannelID page:1 pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
        
        [[CBNNewSqliteManager sharedManager] cleanTableWithTableName:@"Live"];
        
        [[CBNNewSqliteManager sharedManager]insertObjects:channelNewsItemsArray intoTable:@"Live"];
        
        [weakSelf.liveModelArray removeAllObjects];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [weakSelf.liveModelArray addObjectsFromArray:[CBNNewSqliteManager liveDictionaryChanegeToLiveModekWithDictionaryArray:channelNewsItemsArray]];

            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.tableViewHeaderView.liveModelArray = weakSelf.liveModelArray;
                weakSelf.aTableView.tableHeaderView = weakSelf.tableViewHeaderView;

                
            });
            
        });

        
    } failed:^(NSError *error) {
        
    }];

}
- (void)setSliderID:(NSInteger)sliderID
{
    _sliderID = sliderID;
    
    __weak typeof(self) weakSelf = self;
    
    [CBNChannelListRequest loadNewsItemsWithChannelID:_sliderID page:1 pageSize:1 Secuessed:^(NSArray *channelNewsItemsArray) {
        
        [[CBNNewSqliteManager sharedManager] cleanTableWithTableName:@"Slider"];

        
        NSArray *arr = [NSArray arrayWithObjects:[channelNewsItemsArray firstObject], nil];
        [[CBNNewSqliteManager sharedManager] insertObjects:arr intoTable:@"Slider"];

        
        weakSelf.tableViewHeaderView.remondNewsModel = [[CBNNewSqliteManager  dictionaryChangeToModelWithDictionaryArray:channelNewsItemsArray] firstObject];
        weakSelf.aTableView.tableHeaderView = weakSelf.tableViewHeaderView;
        
        
    } failed:^(NSError *error) {
        
    }];
    
}





#define 添加刷新效果和加载更多效果
- (void)setUpTableView
{
    
    _aTableView.tableHeaderView = self.tableViewHeaderView;

    
    self.tableViewHeaderView.remondNewsModel = [[CBNNewSqliteManager  dictionaryChangeToModelWithDictionaryArray:[[CBNNewSqliteManager sharedManager]selectObjectsfromTable:@"Slider"]] firstObject];
    
    
    NSArray *liveArr = [[CBNNewSqliteManager sharedManager] selectObjectsfromTable:@"Live"];
    
    [self.liveModelArray addObjectsFromArray:[CBNNewSqliteManager liveDictionaryChanegeToLiveModekWithDictionaryArray:liveArr]];
    
    _tableViewHeaderView.liveModelArray = _liveModelArray;
    
    _aTableView.tableHeaderView = self.tableViewHeaderView;

    self.aTableView.mj_header = [self refreshHeader];

    [self.aTableView.mj_header beginRefreshing];
    
    
}
#define 数据加载和刷新
- (void)refreshData
{
    
    __weak typeof(self) weakSelf = self;

    _currentPage = 1;
    
    self.sliderID = 29;
    
    self.liveChannelID = 206;

    
    [CBNChannelListRequest loadNewsItemsWithRootID:_mainChannelID page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
        
        if (weakSelf.refreshSecuessed == NO) {
            
            weakSelf.aTableView.mj_footer = [self refreshFooter];

        }

        weakSelf.refreshSecuessed = YES;
        

        [[CBNNewSqliteManager sharedManager] cleanTableWithTableName:@"Main"];

        
        [[CBNNewSqliteManager sharedManager] insertObjects:channelNewsItemsArray intoTable:@"Main"];
        
        [weakSelf.sourceArray removeAllObjects];
        
        [weakSelf.sourceArray addObjectsFromArray:[CBNNewSqliteManager  dictionaryChangeToModelWithDictionaryArray:channelNewsItemsArray]];
        
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
- (void)loadMoreData
{
    
    if (_currentPage == 1) {
        
        [_aTableView.mj_footer endRefreshing];

        [self refreshData];
        
        return;
    }
    __weak typeof(self) weakSelf = self;
    [CBNChannelListRequest loadNewsItemsWithRootID:_mainChannelID page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {

        [weakSelf.sourceArray addObjectsFromArray:[CBNNewSqliteManager  dictionaryChangeToModelWithDictionaryArray:channelNewsItemsArray]];
        
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


#pragma mark CBNHomePageHeaderViewDelegate
- (void)homePageHeaderLiveShuffingView:(CBNHomePageHeaderView *)homePageView didSelectedAtIndex:(NSInteger)index
{
    CBNLiveVC *liveVC = [[CBNLiveVC alloc] init];
    
    liveVC.liveModelArray = _liveModelArray;
    
    liveVC.liveChannelID = _liveChannelID;
    
    [self.navigationController pushViewController:liveVC animated:YES];

}
- (void)homePageHeaderLiveShuffingView:(CBNHomePageHeaderView *)homePageView recommendedNews:(id)news
{
    
    [self pushToTextNewsDetailWithNewsItemModel:homePageView.remondNewsModel];

}

#pragma mark UITableViewDataSource_And_UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CBNNewsModel *tempModel =  [_sourceArray objectAtIndex:indexPath.row];
    
    if (tempModel.NewsThumbs.length < 5) {
        static NSString *indentefier = @"CBNChannelNoImageCell";

        CBNChannelNoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:indentefier];
        
        if (cell == nil) {
            
            cell = [[CBNChannelNoImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentefier];
            
        }
        
        cell.itemModel = [_sourceArray objectAtIndex:indexPath.row];
        
        return cell;
    }else{
        static NSString *indentefier = @"CBNChannelNewsTextCell";

        CBNChannelNewsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:indentefier];
        
        if (cell == nil) {
            
            cell = [[CBNChannelNewsTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentefier];
            
        }
        
        cell.itemModel = [_sourceArray objectAtIndex:indexPath.row];
        
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CBNNewsModel *tempModel =  [_sourceArray objectAtIndex:indexPath.row];
    if (tempModel.NewsThumbs.length < 5) {
        CBNChannelNoImageCell *cell = (CBNChannelNoImageCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
        
    }
    return news_Cell_Height;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self pushToTextNewsDetailWithNewsItemModel:[_sourceArray objectAtIndex:indexPath.row]];
}


#pragma mark create_Objects
- (UITableView *)aTableView
{
    if (!_aTableView) {
        
        self.aTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        
        _aTableView.dk_backgroundColorPicker = DKColorPickerWithKey(defaule_Background_Color);
        
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
        _aTableView.backgroundColor = [UIColor clearColor];
        
        _tableViewHeaderView.delegate = self;
    }
    
    return _tableViewHeaderView;
}

- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        
        self.sourceArray = [[NSMutableArray alloc] init];
        
    }
    
    return _sourceArray;
}

- (NSMutableArray *)liveModelArray
{
    
    if (!_liveModelArray) {
        
        self.liveModelArray = [[NSMutableArray alloc] init];
        
    }
    
    return _liveModelArray;
}

@end
