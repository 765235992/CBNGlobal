//
//  CBNNetworkState.m
//  CBNGlobal
//
//  Created by Jone on 2016/11/11.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNNetworkState.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface CBNNetworkState ()
@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

@end

@implementation CBNNetworkState

static CBNNetworkState *shareManager;

+ (CBNNetworkState *)shareManager
{
    @synchronized(self)
    {
        if (shareManager == nil) {
            
            shareManager = [[self alloc] init];
        }
        return shareManager;
    }
}

- (void)ListeningNetworking
{
    // 开启网络指示器
    self.manager = [AFNetworkReachabilityManager manager];
    
    __weak typeof(self) weakSelf = self;
    

    
    [self.manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusNotReachable: {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"networkState" object:nil userInfo:@{@"isHavenetwork":[NSNumber numberWithBool:NO]}];
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                //                [weakSelf loadMessage:@"Wifi已开启"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"networkState" object:nil userInfo:@{@"isHavenetwork":[NSNumber numberWithBool:YES]}];
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {

                [[NSNotificationCenter defaultCenter] postNotificationName:@"networkState" object:nil userInfo:@{@"isHavenetwork":[NSNumber numberWithBool:YES]}];
                break;
            }
                
            case AFNetworkReachabilityStatusUnknown: {

                [[NSNotificationCenter defaultCenter] postNotificationName:@"networkState" object:nil userInfo:@{@"isHavenetwork":[NSNumber numberWithBool:NO]}];
                break;
            }
                
            default:
                break;
        }
    }];
    [self.manager startMonitoring];
}

@end
