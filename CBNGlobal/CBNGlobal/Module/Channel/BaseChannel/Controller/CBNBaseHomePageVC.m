//
//  CBNBaseHomePageVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseHomePageVC.h"
#import "CBNBarBurronItem.h"
#import "CBNLeftChannelVC.h"
#import "CBNPublicChannelVC.h"
#define draw_Back_Alpha  0.8



NSString * const CBNChannelChangedAdd = @"CBNChannelChanged";

@interface CBNBaseHomePageVC ()

@end

@implementation CBNBaseHomePageVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(channelChanged:) name:CBNChannelChangedAdd object:nil];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self setNavigationHeader];
}

- (void)setNavigationHeader
{
    CBNBarBurronItem *leftBar = [[CBNBarBurronItem alloc] initWithTarget:self action:@selector(leftBar:) andFrame:CGRectMake(0, 0, 44, 44) andImage:[UIColorFromRGB(0xBC8F8F) colorImage]];
    
    
    self.navigationItem.leftBarButtonItem = leftBar;
    
    //    self.navigationItem.rightBarButtonItem= rightBar;
    
}
/*
 *  抽屉打开
 */
-(void)leftBar:(id)sender
{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
/**
 *  频道切换通知
 */

- (void)channelChanged:(NSNotification *)notofication
{
    NSLog(@"%@",[notofication debugDescription]);
    
    [self pushToPublicChannelVCWithChannelIno:notofication.userInfo];
    
}

- (void)pushToPublicChannelVCWithChannelIno:(NSDictionary *)channelInfo
{
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
    
    CBNPublicChannelVC *publicChannelVC = [[CBNPublicChannelVC alloc] init];
    
    [self.navigationController pushViewController:publicChannelVC animated:YES];
}


@end
