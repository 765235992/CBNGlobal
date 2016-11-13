//
//  NSMutableAttributedString+CBNAttributeString.m
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "NSMutableAttributedString+CBNAttributeString.h"

@implementation NSMutableAttributedString (CBNAttributeString)
+ (NSMutableAttributedString *)setLiveContentAttributeStringWithFont:(UIFont *)font string:(NSString *)aString
{
    NSMutableDictionary *attributeDic = [[NSMutableDictionary alloc] init];
    
    /**
     *  设置字体颜色
     */
//    [attributeDic setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    /**
     *  设置字体样式
     */
    [attributeDic setObject:font forKey:NSFontAttributeName];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    paraStyle.lineSpacing = 3.0f;
    
    [attributeDic setObject:paraStyle forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:aString];
    
    [attributedString addAttributes:attributeDic range:NSMakeRange(0, aString.length)];
    
    return attributedString;
}
@end
