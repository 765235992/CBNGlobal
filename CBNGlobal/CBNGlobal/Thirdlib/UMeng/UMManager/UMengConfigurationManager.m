//
//  UMengConfigurationManager.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/7/4.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "UMengConfigurationManager.h"
#import <UMSocialCore/UMSocialCore.h>
#define UmengAppkey @"54d2e806fd98c5e87f0002ed"
@implementation UMengConfigurationManager
/*
 第一步：对UM进行相关配置
 */
+ (void)configurationUMWithOptions:(NSDictionary *)launchOptions
{
    //设置友盟社会化组件appkey
    //打开日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"57b432afe0f55a9832001a0a"];
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    
    //设置领英的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];
    
    //设置Twitter的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
}
@end
