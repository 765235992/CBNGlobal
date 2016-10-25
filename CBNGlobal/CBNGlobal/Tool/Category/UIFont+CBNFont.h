//
//  UIFont+CBNFont.h
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (CBNFont)
+ (UIFont *)newsDetaileTitleFont;
+ (UIFont *)newsTitleFont;
+ (UIFont *)newsContentFont;
+ (UIFont *)tagFont;
+ (UIFont *)relatedNewsFont;
+ (UIFont *)refreshAndLoadingFont;
+ (UIFont *)fontWithSmallSzie:(CGFloat)samllSize middleSize:(CGFloat)middelSize bigSize:(CGFloat)bigSize AndFontName:(NSString *)fontName;

@end
