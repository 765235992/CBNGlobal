//
//  CBNSearchVC.h
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseInfoViewController.h"

@interface CBNSearchVC : CBNBaseInfoViewController
@property (nonatomic, strong) NSString *channelName;
- (void)netWorkChangedWithNetWorkState:(BOOL)currentNetworkState;

@end
