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

@interface CBNHomePageVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) CBNHomePageHeaderView *tableViewHeaderView;


@end

@implementation CBNHomePageVC
- (void)dealloc
{
    NSLog(@"aaaaaaaaa");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sourceArray = [[NSMutableArray alloc] init];
    for (NSString * familyName in [UIFont familyNames]) {
        
        
        
        
        for (NSString * fontName in [UIFont fontNamesForFamilyName:familyName]) {
            
            NSLog(@"%@",familyName);
            [_sourceArray addObject:fontName];
        }
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setUpTableView];
    
}



#define 添加刷新效果和加载更多效果
- (void)setUpTableView
{
    
    [self.view addSubview:self.aTableView];
    
    _aTableView.tableHeaderView = self.tableViewHeaderView;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHomePageDataFromSever)];
    
    // 设置文字
    [header setTitle:@"下拉开始刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"正在刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"正在加载中......" forState:MJRefreshStateRefreshing];
    
    // 设置字体
//    header.stateLabel.font =  [UIFont refreshAndLoadingFont];
//    
//    header.lastUpdatedTimeLabel.font = [UIFont refreshAndLoadingFont];
   

    // 设置颜色
    header.stateLabel.dk_textColorPicker = DKColorPickerWithKey(refresh_And_Loading_Color);
    
    header.lastUpdatedTimeLabel.dk_textColorPicker = DKColorPickerWithKey(refresh_And_Loading_Color);
    
    // 设置刷新控件
    self.aTableView.mj_header = header;
    
    [_aTableView.mj_header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreHomePageDataFromSever)];
    
    [footer setTitle:@" " forState:MJRefreshStateIdle];
    
    [footer setTitle:@"正在加载更多数据……" forState:MJRefreshStateRefreshing];
    
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aaa)];
        [_tableViewHeaderView addGestureRecognizer:tap];
        
    }
    
    return _tableViewHeaderView;
}
- (void)aaa
{
    CBNLiveVC *liveVC = [[CBNLiveVC alloc] init];
    
    [self.navigationController pushViewController:liveVC animated:YES];
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
    
    cell.fontName = [_sourceArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return news_Cell_Height;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CBNTextDetailVC *textDetailVC = [[CBNTextDetailVC alloc] init];
    
    [self.navigationController pushViewController:textDetailVC animated:YES];
    
}

@end
