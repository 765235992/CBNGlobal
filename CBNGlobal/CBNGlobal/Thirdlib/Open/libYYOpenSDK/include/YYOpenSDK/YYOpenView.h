//
//  YYOpenView.h
//  YYOpenSDK
//
//  Created by Jone on 2016/11/21.
//  Copyright © 2016年 Burning_Legion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYOpenViewDelegate <NSObject>

- (void)adImageViewClicked;

@end

@interface YYOpenView : UIImageView


@property (nonatomic, assign) id <YYOpenViewDelegate> delegate;


- (instancetype)initWithADURL:(UIImage *)adImage andDefaultImage:(UIImage *)defaultImage;


- (void)show;


@end
