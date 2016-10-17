//
//  UIColor+CBNColor.h
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CBNColor)
/**
 *  纯色图片
 */
- (UIImage *)colorImage;
/**
 *  随机颜色
 */
+ (UIColor *)randomColor;

@end
