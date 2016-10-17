//
//  UIDevice+CBNDevice.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "UIDevice+CBNDevice.h"
#import <sys/utsname.h>

@implementation UIDevice (CBNDevice)
+ (CGFloat)getProportionOfTheScreen
{
    
    CGFloat screen_With = [[UIScreen mainScreen] bounds].size.width;
    return screen_With/320;
    
}

+ (NSInteger)getFontSizeWithBaseFontSize:(CGFloat)baseFontSize
{
//    CBNLog(@"字体大小 -- %f",(baseFontSize * [UIDevice getProportionOfTheScreen]));
    return (NSInteger)(baseFontSize * [UIDevice getProportionOfTheScreen]);
}

@end
