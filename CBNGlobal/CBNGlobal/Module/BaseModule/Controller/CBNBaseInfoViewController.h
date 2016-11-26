//
//  CBNBaseInfoViewController.h
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CBNNavigationShareView.h"
@interface CBNBaseInfoViewController : UIViewController<CBNNavigationShareViewDelegate>
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) CBNNavigationShareView *shareView;

- (void)setNavigationView;

- (void)cleanRightBar;

- (void)setNoBarItems;

- (void)setBackBarButtonItem;
- (void)setBackBarButtonItemWithTitle:(NSString *)title;

- (void)setShareBarButtonItem;

- (void)sharePlateFromTag:(NSInteger)tag;
- (void)setNavigationTitle:(NSString *)titleString withTextColor:(UIColor *)color;


- (void)pushToTextNewsDetailWitNewsID:(NSInteger)newsID withChannelName:(NSString *)channelName;
@end
