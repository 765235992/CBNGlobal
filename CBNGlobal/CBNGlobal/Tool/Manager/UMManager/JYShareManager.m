//
//  JYShareManager.m
//  TestUM
//
//  Created by Jone on 2016/11/4.
//  Copyright © 2016年 Burning_Legion. All rights reserved.
//

#import "JYShareManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "CBNShareLoadingView.h"
#import "UMMobClick/MobClick.h"



@implementation JYShareManager{
    UIViewController *_viewController;
    SLComposeViewController *slComposerSheet;
    CBNShareLoadingView *loadingView;
}

static JYShareManager *shareManager;

+ (JYShareManager *)shareManager
{
    @synchronized(self)
    {
        if (shareManager == nil) {
            shareManager = [[self alloc] init];
        }
        return shareManager;
    }
}

- (void)shareConfig
{
    [[UMSocialManager defaultManager] openLog:YES];

    //设置友盟社会化组件appkey
//    [[UMSocialManager defaultManager] setUmSocialAppkey:@"581c3375ae1bf80832000c0e"];
//
//    
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"811qx7h3151vsv"  appSecret:@"F509NxrWFQEtZfyQ" redirectURL:@"https://api.linkedin.com/v1/people"];
//    
//    
//    
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"107704292745179"  appSecret:@"38053202e1a5fe26c80c753071f0b573" redirectURL:nil];
//    
//    
//    
//    
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"581c3375ae1bf80832000c0e"];
    UMConfigInstance.appKey = @"581c3375ae1bf80832000c0e";

    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    [MobClick setLogEnabled:YES];

    //设置Twitter的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
    
    //设置Facebook的appKey和UrlString
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373"  appSecret:nil redirectURL:@"http://www.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];

}


- (void)shareNewsWithNewsID:(NSString *)newsID  newsTitle:(NSString *)newsTitle newsContent:(NSString *)newsContent newsImageURL:(NSString *)imageURL newsType:(JYShareType)shareType platformType:(JYSharePlatformType)platformType andViewController:(UIViewController *)viewController
{
    
    
    
    _viewController = viewController;
    if (loadingView!=nil) {
        [loadingView removeFromSuperview];

    }
    loadingView = [[CBNShareLoadingView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    
    if (platformType == JYSharePlatformType_Email) {
        
        [self emailShareWithNewsID:newsID newsTitle:newsTitle newsContent:newsContent newsImageURL:imageURL];
        
        return;
    }
    
    UMSocialPlatformType platformtype;
    
    switch (platformType) {
        case JYSharePlatformType_Linkedin:
            platformtype = UMSocialPlatformType_Linkedin;
            
            break;
        case JYSharePlatformType_Email:
            platformtype = UMSocialPlatformType_Email;

            break;
        case JYSharePlatformType_Twitter:
            platformtype = UMSocialPlatformType_Twitter;

            break;
        case JYSharePlatformType_Facebook:
            platformtype = UMSocialPlatformType_Facebook;

            break;

        default:
            break;
    }
    
    [self shareWebPageToPlatformType:platformtype newsID:newsID newsTitle:newsTitle newsContent:newsContent newsImageURL:imageURL];
    
}

- (void)emailShareWithNewsID:(NSString *)newsID  newsTitle:(NSString *)newsTitle newsContent:(NSString *)newsContent newsImageURL:(NSString *)imageURL
{
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    
    if (mailCompose == nil) {
        return;
    }
        // 设置邮件代理
        [mailCompose setMailComposeDelegate:self];
        // 设置邮件主题
    [mailCompose setSubject:[NSString stringWithFormat:@"YiCaiGlobal: %@",newsTitle]];
        // 设置收件人
//        [mailCompose setToRecipients:@[@"765235992@qq.com"]];
        // 设置抄送人
//        [mailCompose setCcRecipients:@[@"huaxianwei@yicai.com"]];
        // 设置密抄送
        /**
         *  设置邮件的正文内容
         */
        NSString *emailContent = newsContent;
        // 是否为HTML格式
    
        [mailCompose setMessageBody:emailContent isHTML:NO];
        // 如使用HTML格式，则为以下代码
        [mailCompose setMessageBody:[NSString stringWithFormat:@"<html><body><p>I saw this on YiCaiGlobal App and thought you should see it:</p><h3><a href=\"%@\">%@</a></h3></body></html>" ,[self shareWebURLWithNewsID:newsID],newsTitle] isHTML:YES];
    
        /**
         *  添加附件
         */
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        [mailCompose addAttachmentData:imageData mimeType:@"" fileName:@"defaultImage.jpg"];
        // 弹出邮件发送视图
        [_viewController presentViewController:mailCompose animated:YES completion:nil];
    

}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [_viewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType newsID:(NSString *)newsID  newsTitle:(NSString *)newsTitle newsContent:(NSString *)newsContent newsImageURL:(NSString *)imageURL
{
    
    /*获取授权*/
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:_viewController completion:^(id result, NSError *error) {
        NSLog(@"授权失败");
        if (error) {

            return ;
        }
        [_viewController.view addSubview:loadingView];
        
        loadingView.center = CGPointMake(_viewController.view.frame.size.width/2, _viewController.view.frame.size.height/2);
        [loadingView start];
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        messageObject.text = newsTitle;
        
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:newsTitle descr:nil thumImage:[NSURL URLWithString:imageURL]];
        
        //设置网页地址
        shareObject.webpageUrl = [self shareWebURLWithNewsID:newsID];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:_viewController completion:^(id data, NSError *error) {
            if (error) {
                [loadingView failed];

                NSLog(@"分享失败  %@",error);

            }else{
                [loadingView secuessed];

                NSLog(@"分享成功");
                
            }
        }];

    }];
    


}


- (NSString *)shareWebURLWithNewsID:(NSString *)newsID
{
    
    return [NSString stringWithFormat:@"http://m.yicaiglobal.com.cn/news/%@.html",newsID];
}

- (void)stopShare
{
    
    if (loadingView!=nil) {
        [loadingView removeFromSuperview];
        loadingView = nil;
        
    }
}

@end
