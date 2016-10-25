//
//  NSString+CBNString.h
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (CBNString)
+ (CGFloat)getTextHeightWithFont:(UIFont *)font;

+ (CGSize)getSizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
+ (NSString *)getHtmlStringWithPString:(NSString *)pString;

@end
