//
//  CBNNetworkState.h
//  CBNGlobal
//
//  Created by Jone on 2016/11/11.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNNetworkState : NSObject
+ (CBNNetworkState *)shareManager;

- (void)ListeningNetworking;


@end
