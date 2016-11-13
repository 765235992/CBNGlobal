//
//  CBNBaseInfoViewController.m
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseInfoViewController.h"
#import "CBNNavigationShareView.h"
#import "CBNTextDetailVC.h"
@interface CBNBaseInfoViewController ()
@end

@implementation CBNBaseInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithColors([UIColor whiteColor],RGBColor(3, 3, 3, 0.6),[UIColor orangeColor]);
    [self.navigationController.navigationBar setBackgroundImage:[UIColorFromRGB(0x333333) colorImage] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIColorFromRGB(0x333333) colorImage]];
    
    // Do any additional setup after loading the view.
}
- (void)setNoBarItems
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 0, 0);
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    self.navigationItem.leftBarButtonItems = @[leftBar];

    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    navigationLabel.text = @"1";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.textColor = [UIColor clearColor];
    navigationLabel.font = [UIFont newsTitleFont];
    navigationLabel.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.titleView = navigationLabel;}
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
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [shareButton dk_setImage:DKImagePickerWithImages([UIImage imageNamed:@"share-white.png"],[UIImage imageNamed:@"share-white.png"],[UIImage imageNamed:@"share-white.png"]) forState:UIControlStateNormal];
    
    shareButton.frame = CGRectMake(0, 0, 44, 44);
    
    [shareButton setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    
    shareButton.backgroundColor = [UIColor clearColor];
    shareButton.hidden = NO;
    shareButton.selected = YES;
    
    [shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton = shareButton;

    UIBarButtonItem *shareBar = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    UIBarButtonItem *rightSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    rightSpacer.width = -15;
    
    self.navigationItem.rightBarButtonItems = @[rightSpacer,shareBar];

}
- (void)shareButton:(UIButton *)sender
{
//    if (_shareView == nil) {
//        
        [self.view addSubview:self.shareView];
//    }else{
//        if (_shareButton.selected == YES) {
            _shareView.hidden = NO;
//        }else{
//            _shareView.hidden = YES;
//        }
//    }
    
    _shareButton.selected = !_shareButton.selected;

}

- (CBNNavigationShareView *)shareView
{
    if (!_shareView) {
        
        self.shareView = [[CBNNavigationShareView alloc] initWithFrame:CGRectMake(CBN_Screen_Width-search_Bar_Height*1.5-4, 0, search_Bar_Height*1.5, 100)];
        _shareView.delegate = self;
        
    }
    
    return _shareView;
}

- (void)sharePlateFromTag:(NSInteger)tag
{
}
- (void)setNavigationTitle:(NSString *)titleString
{
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    navigationLabel.text = titleString;
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    navigationLabel.textColor = [UIColor whiteColor];
    navigationLabel.font = [UIFont newsTitleFont];
    navigationLabel.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.titleView = navigationLabel;

}
- (void)pushToTextNewsDetailWitNewsID:(NSInteger)newsID
{
    CBNTextDetailVC *textDetailVC = [[CBNTextDetailVC alloc] init];
    textDetailVC.newsID = newsID;
    
    [self.navigationController pushViewController:textDetailVC animated:YES];
}

@end
