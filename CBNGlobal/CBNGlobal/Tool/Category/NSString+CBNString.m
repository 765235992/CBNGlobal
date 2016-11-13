//
//  NSString+CBNString.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "NSString+CBNString.h"
#import <CommonCrypto/CommonDigest.h>
#define IS_IPHONE_6 (667.0f)
#define IS_IPHONE_6_PLUS (736.0f)

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
//MD5加密
+ (NSString *)getTheMD5EncryptedStringWithString:(NSString *)aString{
    const char* str = [aString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (int)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+ (NSString *)getHtmlStringWithPString:(NSString *)pString
{
    NSString *strUrl = [pString stringByReplacingOccurrencesOfString:@"background-color:rgb(245, 245, 245);" withString:@"background-colorlll"];
    
    NSString *styleHeader = @"<style type=\"text/css\">";
    NSString *blockquote = @"blockquote{border-left:5px solid #DDD;margin:15px 30px 0 3px; padding-left:20px}";
    
    NSString *iframe = @"iframe{display: none;}";
    NSString *backgroundColor = @"background-color:AA;";
    NSString *textColor = @"color:#212121;";
    NSString *textAlignment = @"text-align:justify;";
    NSString *size;
    if (IS_IPHONE_6_PLUS == CBN_Screen_Height) {
        size = @"18";
    }else if (IS_IPHONE_6 == CBN_Screen_Height){
        size = @"16";

    }else{
        size = @"14";

    }

    NSString *textFoneSize = [NSString stringWithFormat:@"font-size:%@px;",size];
    NSString *textFontName = @"font-family:\"DINPro-Light\";";
    NSString *textLineSpace = @"line-height:1.7;";
    NSString *word = @"word-wrap:break-word;word-break: normal;";
    NSString *padding = @"padding:0 3 0 3;";
    NSString *justify = @"text-justify:distribute-all-lines;";
    
    NSString *p = [NSString stringWithFormat:@"%@p{%@%@%@%@%@%@%@%@%@}",iframe,backgroundColor,textColor,textAlignment,textFoneSize,textFontName,textLineSpace,word,padding,justify];
    NSString *styleFooter = @"</style>";
    
    NSString *result = [NSString stringWithFormat:@"%@%@%@%@%@",styleHeader,blockquote,p,styleFooter,strUrl];
    return result;
    
}

+ (BOOL)isHaveIsframeOrGifWithString:(NSString *)htmlString
{
    NSRange iframeRange = [htmlString rangeOfString:@"<iframe"];//匹配得到的下标
    if (iframeRange.length > 0) {
        NSLog(@"包含iframe");
        
        return YES;
    }
    
    NSRange Gifrange = [htmlString rangeOfString:@".gif"];//匹配得到的下标
    
    if (Gifrange.length > 0) {
        NSLog(@"包含gif");
        return YES;
    }
    
    return NO;

}


@end
