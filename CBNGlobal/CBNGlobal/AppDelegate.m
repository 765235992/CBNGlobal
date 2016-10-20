//
//  AppDelegate.m
//  CBNGlobal
//
//  Created by Jone on 16/10/14.
//  Copyright © 2016年 Jone. All rights reserved.
//

#import "AppDelegate.h"
#import "CBNHomePageVC.h"
#import "CBNLeftChannelVC.h"
#import "CBNDrawerVisualStateManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMengConfigurationManager.h"
#import <JYLiveShuffingSDK/JYLiveShuffingSDK.h>
#import <JYGuideSDK/JYGuideSDK.h>
#import "CBNChannelNavigationController.h"

@interface AppDelegate ()
@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
//    [UMengConfigurationManager configurationUMWithOptions:launchOptions];
    
    CBNHomePageVC *homePageVC = [[CBNHomePageVC alloc] init];
    
    CBNChannelNavigationController *homePageNavigatonController = [[CBNChannelNavigationController alloc] initWithRootViewController:homePageVC];
    
    CBNLeftChannelVC *leftChannelVC = [[CBNLeftChannelVC alloc] init];
    /*
     *  添加到抽屉上去
     */
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:homePageNavigatonController leftDrawerViewController:leftChannelVC];
    [self.drawerController setShowsShadow:YES];
    
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    
    //抽屉打开的大小
    [self.drawerController setMaximumLeftDrawerWidth:user_Draw_open_With];
    
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[CBNDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    [self.window setRootViewController:self.drawerController];
    [self.window makeKeyAndVisible];

    JYGuideView *view = [[JYGuideView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height)];
    
    NSArray *arr = @[[[UIColor randomColor] colorImage],[[UIColor randomColor] colorImage],[[UIColor randomColor] colorImage],[[UIColor randomColor] colorImage]];
    [view showWithGuideImageArrays:arr];

    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
