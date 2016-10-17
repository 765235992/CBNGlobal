//
//  NSString+CBNString.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "NSString+CBNString.h"

@implementation NSString (CBNString)
+ (CGSize)getSizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGFloat)getTextHeightWithFont:(UIFont *)font
{
    CGSize size = [self getSizeWithText:@"L" font:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    return size.height;
    
}

@end
