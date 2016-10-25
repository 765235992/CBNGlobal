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
/*
 *  获取一个字体的高度
 */
+ (CGFloat)getTextHeightWithFont:(UIFont *)font;
/*
 *  获取一定字体的宽度和高度
 */
+ (CGSize)getSizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
/*
 *  给字符串添加htmlCss标签
 */
+ (NSString *)getHtmlStringWithPString:(NSString *)pString;
/*
 *  MD5加密
 */
+ (NSString *)getTheMD5EncryptedStringWithString:(NSString *)aString;

@end
