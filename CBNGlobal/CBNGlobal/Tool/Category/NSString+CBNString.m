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
+ (NSString *)getHtmlStringWithPString:(NSString *)pString
{
    NSString *strUrl = [pString stringByReplacingOccurrencesOfString:@"background-color:rgb(245, 245, 245);" withString:@"background-colorlll"];
    
    NSString *styleHeader = @"<style type=\"text/css\">";
    NSString *blockquote = @"blockquote{border-left:5px solid #DDD;margin:15px 30px 0 3px; padding-left:20px}";
    NSString *backgroundColor = @"background-color:AA;";
    NSString *textColor = @"color:#212121;";
    NSString *textAlignment = @"text-align:justify;";
    NSString *textFoneSize = @"font-size:17px;";
    NSString *textFontName = @"font-family:\"AppleSDGothicNeo-Light\";";
    NSString *textLineSpace = @"line-height:1.7;";
    NSString *word = @"word-wrap:break-word;word-break: normal;";
    NSString *padding = @"padding:0 3 0 3;";
    NSString *justify = @"text-justify:distribute-all-lines;";
    
    NSString *p = [NSString stringWithFormat:@"p{%@%@%@%@%@%@%@%@%@}",backgroundColor,textColor,textAlignment,textFoneSize,textFontName,textLineSpace,word,padding,justify];
    NSString *styleFooter = @"</style>";
    
    NSString *result = [NSString stringWithFormat:@"%@%@%@%@%@",styleHeader,blockquote,p,styleFooter,strUrl];
    return result;
    
}

@end
