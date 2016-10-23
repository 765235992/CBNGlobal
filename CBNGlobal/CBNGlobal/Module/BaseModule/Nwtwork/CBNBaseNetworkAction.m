//
//  CBNBaseNetworkAction.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseNetworkAction.h"

@implementation CBNBaseNetworkAction
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id result))sucess failed:(void (^)(NSError *error))failed
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@ task --%@",responseObject,task);
        if (sucess)
        {
            sucess(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failed)
        {
            failed(error);
        }
        
    }];
    
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id result))sucess failed:(void (^)(NSError *error))failed
{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        if (sucess)
        {
            sucess(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");

        if(failed)
        {
            failed(error);
        }

    }];
    
    
}

@end
