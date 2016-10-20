//
//  CBNBaseChannelVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseChannelVC.h"
#import "CBNBarBurronItem.h"
#import "CBNLeftChannelVC.h"

#define draw_Back_Alpha  0.8

@interface CBNBaseChannelVC ()

@end

@implementation CBNBaseChannelVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors([UIColor whiteColor],RGBColor(3, 3, 3, 0.6),[UIColor orangeColor]);
    [self.navigationController.navigationBar setBackgroundImage:[UIColorFromRGB(0x333333) colorImage] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIColorFromRGB(0xE7E7E7) colorImage]];
    [self setNavigationView];
    [self setNavigationHeader];
    [self setSearchBar];
    
    
}


- (void)setNavigationView
{
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    logoImageView.backgroundColor = [UIColor redColor];
    
    self.navigationItem.titleView =  logoImageView;
    
}

- (void)setNavigationHeader
{
    UIButton *drawButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [drawButton dk_setImage:DKImagePickerWithImages([UIImage imageNamed:@"CBN_Channel_Left_Bar_Image_Day@2x.png"],[UIImage imageNamed:@"CBN_Channel_Left_Bar_Image_Day@2x.png"],[UIImage imageNamed:@"CBN_Channel_Left_Bar_Image_Day@2x.png"]) forState:UIControlStateNormal];
    
    drawButton.frame = CGRectMake(0, 0, 44, 44);
    //    [backButton setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    drawButton.backgroundColor = [UIColor clearColor];
    [drawButton addTarget:self action:@selector(leftBar:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *drawBar = [[UIBarButtonItem alloc] initWithCustomView:drawButton];
    
    UIBarButtonItem *leftSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    leftSpacer.width = -15;
    
    self.navigationItem.leftBarButtonItems = @[leftSpacer,drawBar];
    
    
    
}
/*
 *  抽屉打开
 */
-(void)leftBar:(id)sender
{
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)setSearchBar
{
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [searchButton dk_setImage:DKImagePickerWithImages([UIImage imageNamed:@"CBN_Channel_Left_Bar_Image_Day@2x.png"],[UIImage imageNamed:@"CBN_Channel_Left_Bar_Image_Day@2x.png"],[UIImage imageNamed:@"CBN_Channel_Left_Bar_Image_Day@2x.png"]) forState:UIControlStateNormal];
    
    searchButton.frame = CGRectMake(0, 0, 44, 44);
    //    [backButton setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    searchButton.backgroundColor = [UIColor clearColor];
    [searchButton addTarget:self action:@selector(searchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *searchBar = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    UIBarButtonItem *rightSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    rightSpacer.width = -15;
    
    self.navigationItem.rightBarButtonItems = @[rightSpacer,searchBar];

}

- (void)searchButton:(UIButton *)sender
{
    
}
@end
