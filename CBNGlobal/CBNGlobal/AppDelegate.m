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
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "CBNNetworkState.h"

#import "JYGuideSDK.h"
#import "JYShareManager.h"
#import "CBNChannelNavigationController.h"
#import "CBNChannelRequrst.h"

#import "YYOpenSDK.h"
@interface AppDelegate ()<YYOpenViewDelegate>
{
    CBNHomePageVC *_homePage;
}
@property (nonatomic,strong) MMDrawerController * drawerController;

@property (nonatomic, strong) CBNLeftChannelVC *leftChannelVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIButton buttonWithType:UIButtonTypeCustom];
    
    [[JYShareManager shareManager] shareConfig];
    
    [[CBNNetworkState shareManager] ListeningNetworking];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.window setRootViewController:[self setDrawerVC]];
    
    [self.window makeKeyAndVisible];
    
    [self requestChannelItem];
    
    [self setGuideView];
    
    [self addOpenView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:@"networkState" object:nil];


    
    return YES;
}

- (void)addOpenView
{
    
    YYOpenView *openView = [[YYOpenView alloc] initWithADURL:nil andDefaultImage:[UIImage imageNamed:@"Portrait-736h@3x.png"]];
    openView.frame = CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height);
    openView.backgroundColor = [UIColor blackColor];
    openView.contentMode = UIViewContentModeScaleToFill;
    openView.delegate = self;
    
    [self.window addSubview:openView];
    
    [openView show];
    
}

- (void)adImageViewClicked
{


}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    if (!result) {
        
    }
    return result;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
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
- (void)applicationDidBecomeActive:(UIApplication *)application {
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

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (MMDrawerController *)setDrawerVC{
    
    CBNHomePageVC *ahomePage = [[CBNHomePageVC alloc] init];
    CBNChannelNavigationController *homePageNavigatonController = [[CBNChannelNavigationController alloc] initWithRootViewController:ahomePage];

    _leftChannelVC = [[CBNLeftChannelVC alloc] init];
    /*
     *  添加到抽屉上去
     */
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:homePageNavigatonController leftDrawerViewController:_leftChannelVC];
    
    
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
    
    return self.drawerController;
    
}



- (void)setGuideView{
    JYGuideView *view = [[JYGuideView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height)];
    
    NSArray *arr = @[[UIImage imageNamed:@"guide_1@3x.png"],[UIImage imageNamed:@"guide_2@3x.png"]];
    
    [view showWithGuideImageArrays:arr];

}
- (void)networkChanged:(NSNotification *)notification{
    
    NSDictionary *dic = notification.userInfo;
    
    BOOL isHaveNetwork = [[dic objectForKey:@"isHavenetwork"] boolValue];
    
    
    
    
    
    _leftChannelVC.currentNetWorkState = isHaveNetwork;
    
    if (isHaveNetwork == YES) {
        
        [self requestChannelItem];
        
    }
}

- (void)requestChannelItem
{
    
    __weak typeof(self) weakSelf = self;
        
    [CBNChannelRequrst postChannelsSecuessed:^(NSArray *channelArray) {

        
        [[CBNChannelSqliteManager sharedManager] cleanTableWithTableName:@"ChannelList"];
        
        [[CBNChannelSqliteManager sharedManager] insertObjects:channelArray intoTable:@"ChannelList"];
        
        weakSelf.leftChannelVC.channelArray = [[CBNChannelSqliteManager sharedManager] dictionaryChangeToModelWithDictionaryArray:channelArray];
        
        
    } failed:^(NSError *error) {
        
    }];
}

@end
