//
//  CBNBaseChannelVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseChannelVC.h"
#import "CBNBarBurronItem.h"
#import "CBNLeftChannelVC.h"
#import "CBNBaseInfoViewController.h"
#import "CBNTextDetailVC.h"
#import "CBNSearchVC.h"

#define draw_Back_Alpha  0.8

@interface CBNBaseChannelVC ()

@end

@implementation CBNBaseChannelVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}
- (void)setNavigationTitle:(NSString *)titleString
{
    
    //    [self setNavigationView];
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    navigationLabel.text = titleString;
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.textColor = [UIColor whiteColor];
    navigationLabel.font = [UIFont newsTitleFont];
    navigationLabel.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.titleView = navigationLabel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors([UIColor whiteColor],RGBColor(3, 3, 3, 0.6),[UIColor orangeColor]);
    [self.navigationController.navigationBar setBackgroundImage:[UIColorFromRGB(0x333333) colorImage] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIColorFromRGB(0x333333) colorImage]];
    [self setNavigationView];
    [self setNavigationHeader];
    [self setSearchBar];
    
    
}


- (void)setNavigationView
{
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 92, 34)];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    logoImageView.image = [UIImage imageNamed:@"navigation-logo.png"];
    
    self.navigationItem.titleView =  logoImageView;
    
}

- (void)setNavigationHeader
{
    UIButton *drawButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [drawButton dk_setImage:DKImagePickerWithImages([UIImage imageNamed:@"channel-white.png"],[UIImage imageNamed:@"channel-white.png"],[UIImage imageNamed:@"channel-white.png"]) forState:UIControlStateNormal];
    
    drawButton.frame = CGRectMake(0, 0, 44, 44);
    [drawButton setImageEdgeInsets:UIEdgeInsetsMake(8, 11, 8, 11)];
    drawButton.backgroundColor = [UIColor clearColor];
    [drawButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *drawBar = [[UIBarButtonItem alloc] initWithCustomView:drawButton];
    
    UIBarButtonItem *leftSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    leftSpacer.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[leftSpacer,drawBar];
    
    
    
}
/*
 *  抽屉打开
 */
-(void)leftBar:(id)sender
{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (void)setSearchBar
{
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 44, 44);

    [searchButton setImage:[UIImage imageNamed:@"search-white-magnifier.png"] forState:UIControlStateNormal];
    
    [searchButton setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    searchButton.backgroundColor = [UIColor clearColor];
    [searchButton addTarget:self action:@selector(searchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchBar = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    UIBarButtonItem *rightSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    rightSpacer.width = -15;
    
    self.navigationItem.rightBarButtonItems = @[rightSpacer,searchBar];

}

- (void)searchButton:(UIButton *)sender
{
}


- (MJRefreshNormalHeader *)refreshHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
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
    
    // 设置刷新控件
    return  header;
}
- (void)refreshData
{
    
}
- (MJRefreshAutoNormalFooter *)refreshFooter
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [footer setTitle:@"Drag to load more…" forState:MJRefreshStateIdle];
    
    [footer setTitle:@"Loading more news…" forState:MJRefreshStateRefreshing];
    
    [footer setTitle:@"No more news" forState:MJRefreshStateNoMoreData];
   
    // 设置字体
    footer.stateLabel.font = [UIFont refreshAndLoadingFont];
    //
    //    // 设置颜色
    footer.stateLabel.dk_textColorPicker = DKColorPickerWithKey(refresh_And_Loading_Color);

    return footer;
    
}
- (void)loadMoreData
{
    
}








- (void)pushToTextNewsDetailWithNewsItemModel:(CBNNewsModel *)newsItemModel withChannelName:(NSString *)channelName
{
    CBNTextDetailVC *textDetailVC = [[CBNTextDetailVC alloc] init];
    
//    [textDetailVC setNavigationTitle:channelName];
    
    if (newsItemModel.IsEntity) {

        textDetailVC.newsID = newsItemModel.NewsID;

    }else{
        textDetailVC.newsID = newsItemModel.EntityNews;

    }
    textDetailVC.channelName = channelName;
    
    [self.navigationController pushViewController:textDetailVC animated:YES];
    
}
@end
