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

    [CBNChannelListRequest loadNewsItemsWithChannelID:[_channelModel.ChannelID integerValue] page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
        [weakSelf.sourceArray removeAllObjects];
        [[CBNDao sharedManager] deleteDataFromTableName:_channelModel.EnglishName];

        [weakSelf.sourceArray addObjectsFromArray:channelNewsItemsArray];
        [[CBNNewsItemDao sharedManager] insertChannelNewsItemsWithTableName:_channelModel.EnglishName andChannelNewsItemArray:channelNewsItemsArray];;

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
    
    [CBNChannelListRequest loadNewsItemsWithChannelID:[_channelModel.ChannelID integerValue] page:_currentPage pageSize:20 Secuessed:^(NSArray *channelNewsItemsArray) {
        
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


- (void)setChannelModel:(CBNChannelMoel *)channelModel
{
    _channelModel = channelModel;
    [self setUpTableView];

    NSArray *arr =  [[CBNNewsItemDao sharedManager]  queryNewsItemsDataWithTableName:_channelModel.EnglishName];
    [self.sourceArray addObjectsFromArray:arr];
    [_aTableView reloadData];
    
    [_aTableView.mj_header beginRefreshing];
}
- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        self.sourceArray = [[NSMutableArray alloc] init];

    }
    
    return _sourceArray;
}
@end
