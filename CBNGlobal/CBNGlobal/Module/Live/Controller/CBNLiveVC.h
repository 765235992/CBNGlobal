//
//  CBNLiveVC.h
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseInfoViewController.h"

@interface CBNLiveVC : CBNBaseInfoViewController
@property (nonatomic, strong) NSMutableArray *liveModelArray;
@property (nonatomic, assign) NSInteger liveChannelID;
- (void)netWorkChangedWithNetWorkState:(BOOL)currentNetworkState;

@end
