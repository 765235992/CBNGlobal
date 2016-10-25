//
//  CBNPublicChannelVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNPublicChannelVC.h"
#import "CBNChannelNewsTextCell.h"

@interface CBNPublicChannelVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation CBNPublicChannelVC
- (void)dealloc
{
    CBNLog(@"公共频道释放");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.aTableView];
    
    
}



#define 添加刷新效果和加载更多效果
- (void)setUpTableView
{
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshPublicChannelNewsDataFromSever)];
    
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
    
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMorePublicChannelNewsDataFromSever)];
    
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
- (void)refreshPublicChannelNewsDataFromSever
{
    _currentPage = 1;

    __weak typeof(self) weakSelf = self;

    [CBNChannelListRequest loadNewsItemsWithChannelID:[_channelModel.ChannelID integerValue] page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
        [[CBNNewSqliteManager sharedManager] cleanTableWithTableName:_channelModel.EnglishName];
        [[CBNNewSqliteManager sharedManager] insertObjects:channelNewsItemsArray intoTable:_channelModel.EnglishName];
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
- (void)loadMorePublicChannelNewsDataFromSever
{
    
    __weak typeof(self) weakSelf = self;
    
    [CBNChannelListRequest loadNewsItemsWithChannelID:[_channelModel.ChannelID integerValue] page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
        [weakSelf.sourceArray addObjectsFromArray:[CBNNewSqliteManager  dictionaryChangeToModelWithDictionaryArray:channelNewsItemsArray]];
        
        [weakSelf loadMoreFinished];
        if (channelNewsItemsArray.count == 0) {
            
            [_aTableView.mj_footer endRefreshingWithNoMoreData];
            
        }

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
    return  news_Cell_Height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self pushToTextNewsDetailWithNewsItemModel:[_sourceArray objectAtIndex:indexPath.row]];
    
}

#pragma mark reset
- (void)setChannelModel:(CBNChannelModel *)channelModel
{
    _channelModel = channelModel;
    
    [self setUpTableView];
    
    [self.sourceArray removeAllObjects];
    
    [_sourceArray addObjectsFromArray:[CBNNewSqliteManager  dictionaryChangeToModelWithDictionaryArray:[[CBNNewSqliteManager sharedManager]selectObjectsfromTable:_channelModel.EnglishName]]];
    
    [_aTableView reloadData];
    
    [_aTableView.mj_header beginRefreshing];
}


#pragma mark create_Objects
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

- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        self.sourceArray = [[NSMutableArray alloc] init];

    }
    
    return _sourceArray;
}
@end
