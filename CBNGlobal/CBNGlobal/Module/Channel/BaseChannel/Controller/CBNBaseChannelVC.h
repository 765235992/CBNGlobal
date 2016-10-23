//
//  CBNBaseChannelVC.h
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseViewController.h"
#import "CBNNewsItemModel.h"
@interface CBNBaseChannelVC : CBNBaseViewController

- (void)pushToTextNewsDetailWithNewsItemModel:(CBNNewsItemModel *)newsItemModel;

@end
