//
//  CBNBaseChannelVC.h
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseViewController.h"
#import "CBNNewsModel.h"
#import "CBNSearchVC.h"
@interface CBNBaseChannelVC : CBNBaseViewController
@property (nonatomic, assign) BOOL isHaveNetwork;

- (void)pushToTextNewsDetailWithNewsItemModel:(CBNNewsModel *)newsItemModel withChannelName:(NSString *)channelName;

- (void)setNavigationTitle:(NSString *)titleString;
- (void)searchButton:(UIButton *)sender;

- (MJRefreshNormalHeader *)refreshHeader;
- (void)refreshData;
- (MJRefreshAutoNormalFooter *)noData;

- (MJRefreshAutoNormalFooter *)refreshFooter;
- (void)loadMoreData;
- (void)netWorkChangedWithNetWorkState:(BOOL)currentNetworkState;
- (void)networkNormal;
@end
