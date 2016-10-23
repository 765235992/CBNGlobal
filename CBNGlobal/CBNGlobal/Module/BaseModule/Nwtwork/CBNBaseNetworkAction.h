//
//  CBNBaseNetworkAction.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNBaseNetworkAction : NSObject
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id result))sucess failed:(void (^)(NSError *error))failed;

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id result))sucess failed:(void (^)(NSError *error))failed;

@end
