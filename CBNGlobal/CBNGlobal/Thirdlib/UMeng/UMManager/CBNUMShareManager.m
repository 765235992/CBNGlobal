//
//  CBNUMShareManager.m
//  CBNWeeklyMagazine
//
//  Created by Jim on 16/7/4.
//  Copyright © 2016年 上海第一财经报业有限公司. All rights reserved.
//

#import "CBNUMShareManager.h"
#import <UMSocialCore/UMSocialCore.h>


@implementation CBNUMShareManager
+ (CBNUMShareManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    
    static CBNUMShareManager *_sharedInstance;
    
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[CBNUMShareManager alloc] init];
        
    });
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

/*
 参数描述
 sharePlate 分享平台不能为空
 title 分享标题不能为空，微信朋友圈分享出去的没有标题
 content 分享描述可以为空
 image 分享image可以为空 可以传入UIImage或者NSData类型
 url 分享url可以为空
 */
- (void)shareToThePlate:(CBNShareType)sharePlate title:(NSString *)title content:(NSString *)content image:(id)image andUrl:(id)url
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"icon"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://mobile.umeng.com/social";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    UMSocialPlatformType platformType;
    
    switch (sharePlate) {
        case 0:
            platformType = UMSocialPlatformType_Facebook;
            break;
        case 1:
            platformType = UMSocialPlatformType_Twitter;

            break;
        case 2:
            platformType = UMSocialPlatformType_Linkedin;

            break;
        case 3:
            platformType = UMSocialPlatformType_Email;

            break;

            
        default:
            break;
    }
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        CBNLog(@"%@",error);
        
    }];

}
@end
