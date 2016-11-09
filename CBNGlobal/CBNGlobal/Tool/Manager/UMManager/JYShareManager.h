//
//  JYShareManager.h
//  TestUM
//
//  Created by Jone on 2016/11/4.
//  Copyright © 2016年 Burning_Legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


typedef enum : NSUInteger {
    JYSharePlatformType_Facebook  = 0,
    JYSharePlatformType_Twitter,

    JYSharePlatformType_Linkedin,
    JYSharePlatformType_Email,

} JYSharePlatformType;

typedef enum : NSUInteger {
    JYShareType_Text,
    JYShareType_Image,
    JYShareType_TextAndImage,
    JYShareType_Web,
    JYShareType_Music,
    JYShareType_Video,
} JYShareType;

@interface JYShareManager : NSObject<MFMailComposeViewControllerDelegate>

+ (JYShareManager *)shareManager;

- (void)shareConfig;

- (void)shareNewsWithNewsID:(NSString *)newsID  newsTitle:(NSString *)newsTitle newsContent:(NSString *)newsContent newsImageURL:(NSString *)imageURL newsType:(JYShareType)shareType platformType:(JYSharePlatformType)platformType andViewController:(UIViewController *)viewController;
- (void)stopShare;
@end
