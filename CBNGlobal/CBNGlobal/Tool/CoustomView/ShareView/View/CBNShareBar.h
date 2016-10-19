//
//  CBNShareBar.h
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBNShareBar;
@protocol CBNShareBarDelegate <NSObject>


- (void)shareBar:(CBNShareBar *)shareBar shareType:(CBNShareType)shareType;


@end

@interface CBNShareBar : UIView


@property (nonatomic, assign) id <CBNShareBarDelegate> delegate;

@end
