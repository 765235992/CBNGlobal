//
//  CBNBaseInfoViewController.h
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBNBaseInfoViewController : UIViewController
- (void)setNoBarItems;

- (void)setBackBarButtonItem;

- (void)setShareBarButtonItem;

- (void)setNavigationTitle:(NSString *)titleString;

- (void)pushToTextNewsDetailWitNewsID:(NSInteger)newsID;

@end
