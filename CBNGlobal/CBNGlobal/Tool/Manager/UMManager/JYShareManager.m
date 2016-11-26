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
- (void)dealloc
{
    
}
- (void)shareConfig
{
    
    
    UMConfigInstance.appKey = @"58327b68f29d9808920018e2";
    
    UMConfigInstance.channelId = @"App Store";
    
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    [MobClick setLogEnabled:YES];

    
    
    [[UMSocialManager defaultManager] openLog:YES];

    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58327b68f29d9808920018e2"];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"1314536311921866"  appSecret:nil redirectURL:@"http://www.umeng.com/social"];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"77aq4wlhrao62a"  appSecret:@"ckJ2kcod9vw2IOh0" redirectURL:@"https://api.linkedin.com/v1/people"];
    
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];

//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"zUxfYOXHn47rbNGRkG7cNVwVm"  appSecret:@"mXcwdwNbDhwO9YchjCwI7uhrcSevNcIGttw2q8hVPEV0lsBa1v" redirectURL:nil];

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
    [_viewController.view addSubview:loadingView];
    
    loadingView.center = CGPointMake(_viewController.view.frame.size.width/2, _viewController.view.frame.size.height/2);
    [loadingView start];
    if (mailCompose == nil) {
        [loadingView failed];
        return;
    }
        // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
        // 设置邮件主题
    [mailCompose setSubject:[NSString stringWithFormat:@"YicaiGlobal: %@",newsTitle]];
    /**
     *  设置邮件的正文内容
     */
    NSString *emailContent = newsContent;
    // 是否为HTML格式
    
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 如使用HTML格式，则为以下代码
    [mailCompose setMessageBody:[NSString stringWithFormat:@"<html><body><p>I saw this on YicaiGlobal App and thought you should see it:</p><h3><a href=\"%@\">%@</a></h3></body></html>" ,[self shareWebURLWithNewsID:newsID],newsTitle] isHTML:YES];
    
    
    /**
     *  添加附件
     */
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    if (imageData != NULL) {
        
        [mailCompose addAttachmentData:imageData mimeType:@"" fileName:@"defaultImage.jpg"];
        
    }
    // 弹出邮件发送视图
    [_viewController presentViewController:mailCompose animated:YES completion:nil];
    

}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    [_viewController dismissViewControllerAnimated:YES completion:^{
        if (result == MFMailComposeResultSent) {
            [loadingView secuessed];
        }else{
            [loadingView failed];
            
        }

    }];

}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType newsID:(NSString *)newsID  newsTitle:(NSString *)newsTitle newsContent:(NSString *)newsContent newsImageURL:(NSString *)imageURL
{
    if (platformType == UMSocialPlatformType_Twitter) {
        
        [self TwitterWithNewsID:newsID newsTitle:newsTitle newsContent:newsContent newsImageURL:imageURL];
        
        return;
    }
    
    [_viewController.view addSubview:loadingView];
    
    loadingView.center = CGPointMake(_viewController.view.frame.size.width/2, _viewController.view.frame.size.height/2);
    [loadingView start];
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:_viewController completion:^(id result, NSError *error) {
                //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:newsTitle descr:newsContent thumImage:[NSURL URLWithString:imageURL]];
        
        if (platformType == UMSocialPlatformType_Twitter) {
            
            messageObject.text = [NSString stringWithFormat:@"%@  %@",newsTitle,[self shareWebURLWithNewsID:newsID]];
            
        }else{
            messageObject.text = newsTitle;
            
            //设置网页地址
            shareObject.webpageUrl = [self shareWebURLWithNewsID:newsID];
        }
        
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


    
//    if (platformType == UMSocialPlatformType_Facebook) {
//       // [self faceBookWithNewsID:newsID newsTitle:newsTitle newsContent:newsContent newsImageURL:imageURL];
//        //return;
//    }else if (platformType == UMSocialPlatformType_Twitter){
////        [self TwitterWithNewsID:newsID newsTitle:newsTitle newsContent:newsContent newsImageURL:imageURL];
////        return;
//    }
////
//    NSLog(@"_viewController -- %@",_viewController);
//    /*获取授权*/


}

- (void)linkedInWithNewsID:(NSString *)newsID  newsTitle:(NSString *)newsTitle newsContent:(NSString *)newsContent newsImageURL:(NSString *)imageURL
{
    
}

- (void)TwitterWithNewsID:(NSString *)newsID  newsTitle:(NSString *)newsTitle newsContent:(NSString *)newsContent newsImageURL:(NSString *)imageURL
{
    
    [_viewController.view addSubview:loadingView];
    loadingView.center = CGPointMake(_viewController.view.frame.size.width/2, _viewController.view.frame.size.height/2);
    [loadingView start];

    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        NSLog(@"不可用");
        UIAlertView *alter =[ [UIAlertView alloc] initWithTitle:@"Oops" message:@"setup your TwitterID please, go to configuration - Twitter - add account. You can share after your account is added" delegate:nil cancelButtonTitle:@"cancle" otherButtonTitles:nil, nil];
        
        [alter show];
        [loadingView failed];

        return;
    }
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    UIImage *cachedImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL];

    if (cachedImage != nil) {
        [composeVC addImage:cachedImage];

    }else{
        [composeVC addImage:[UIImage imageWithContentsOfFile:@"AppIcon"]];

    }

    // 添加要分享的文字
    [composeVC setInitialText:newsTitle];
    // 添加要分享的url
    [composeVC addURL:[NSURL URLWithString:[self shareWebURLWithNewsID:newsID]]];
    // 弹出分享控制器
    [_viewController presentViewController:composeVC animated:YES completion:nil];
    // 监听用户点击事件
    composeVC.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultDone) {
            NSLog(@"sendOver");
            [loadingView secuessed];

        }
        else if (result == SLComposeViewControllerResultCancelled)
        {
            [loadingView failed];

            NSLog(@"cancle");
        }
    };
    
}

- (void)faceBookWithNewsID:(NSString *)newsID  newsTitle:(NSString *)newsTitle newsContent:(NSString *)newsContent newsImageURL:(NSString *)imageURL
{
    [_viewController.view addSubview:loadingView];
    loadingView.center = CGPointMake(_viewController.view.frame.size.width/2, _viewController.view.frame.size.height/2);
    [loadingView start];

    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        NSLog(@"不可用");
        UIAlertView *alter =[ [UIAlertView alloc] initWithTitle:@"Oops" message:@"setup your FacebookID please, go to configuration - Facebook - add account. You can share after your account is added" delegate:nil cancelButtonTitle:@"cancle" otherButtonTitles:nil, nil];
        
        [alter show];
        [loadingView failed];


        return;
    }

    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

    NSLog(@"composeVC -- %@",composeVC);

    if (composeVC == NULL) {
        [loadingView failed];

        return;
    }
    // 添加要分享的文字
    [composeVC setInitialText:newsTitle];

    // 添加要分享的图片
    
    NSLog(@"%@",imageURL);
    [composeVC addImage:[UIImage imageWithContentsOfFile:imageURL]];
        
//    }
    
    // 添加要分享的url
    [composeVC addURL:[NSURL URLWithString:[self shareWebURLWithNewsID:newsID]]];
    NSLog(@"%@--%@",composeVC,_viewController);
    
    // 弹出分享控制器
    [_viewController presentViewController:composeVC animated:YES completion:nil];
    // 监听用户点击事件
    composeVC.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultDone) {
            [loadingView secuessed];

        }
        else if (result == SLComposeViewControllerResultCancelled)
        {
            [loadingView failed];
        }
    };

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
