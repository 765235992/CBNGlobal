//
//  UMengConfigurationManager.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/7/4.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMengConfigurationManager : NSObject
/*
 第一步：对UM进行相关配置
 */
+ (void)configurationUMWithOptions:(NSDictionary *)launchOptions;
@end
