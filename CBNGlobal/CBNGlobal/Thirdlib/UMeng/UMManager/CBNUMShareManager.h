//
//  CBNUMShareManager.h
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/7/4.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CBNUMShareManager : NSObject;

+ (CBNUMShareManager *)sharedInstance;


/*
 参数描述
 sharePlate 分享平台不能为空
 title 分享标题不能为空，微信朋友圈分享出去的没有标题
 content 分享描述可以为空
 image 分享image可以为空 可以传入UIImage或者NSData类型
 url 分享url可以为空
 */
- (void)shareToThePlate:(CBNShareType)sharePlate title:(NSString *)title content:(NSString *)content image:(id)image andUrl:(id)url;



@end
