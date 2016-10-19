//
//  CBNBaseViewController.m
//  CBNGlobal
//
//  Created by Jone on 16/10/15.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseViewController.h"

@interface CBNBaseViewController ()

@end

@implementation CBNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors([UIColor whiteColor],RGBColor(3, 3, 3, 0.6),[UIColor orangeColor]);
    [self.navigationController.navigationBar setBackgroundImage:[UIColorFromRGB(0x333333) colorImage] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIColorFromRGB(0xE7E7E7) colorImage]];

    // Do any additional setup after loading the view.
}

- (void)setBackBarButtonItem
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton dk_setImage:DKImagePickerWithImages([UIImage imageNamed:@"CBN_Navigation_Back_Icon_Day.png"],[UIImage imageNamed:@"CBN_Navigation_Back_Icon_Day.png"],[UIImage imageNamed:@"CBN_Navigation_Back_Icon_Day.png"]) forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0, 0, 44, 44);
//    [backButton setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIBarButtonItem *leftSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    leftSpacer.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[leftSpacer,backBar];

}
- (void)backButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)setShareBarButtonItem
{
    
}

- (void)setNavigationTitle:(NSString *)titleString
{
    
}


@end
