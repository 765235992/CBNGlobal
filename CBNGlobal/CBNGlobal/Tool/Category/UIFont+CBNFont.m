//
//  UIFont+CBNFont.m
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "UIFont+CBNFont.h"
#define IS_IPHONE_6 (667.0f)
#define IS_IPHONE_6_PLUS (736.0f)
@implementation UIFont (CBNFont)
+ (UIFont *)newsDetaileTitleFont
{
    
    return [self fontWithSmallSzie:14 middleSize:18 bigSize:20 AndFontName:font_Name_Blod];
    
}
+ (UIFont *)newsTitleFont
{
    
    return [self fontWithSmallSzie:14 middleSize:16 bigSize:18 AndFontName:font_Name_Blod];
    
}
+ (UIFont *)newsContentFont
{
    
    return [self fontWithSmallSzie:13 middleSize:15 bigSize:17 AndFontName:font_Name_Light];

}
+ (UIFont *)tagFont
{
    return [self fontWithSmallSzie:10 middleSize:11 bigSize:12 AndFontName:font_Name_Light];

}
+ (UIFont *)relatedNewsFont
{
    return [self fontWithSmallSzie:13 middleSize:15 bigSize:17 AndFontName:font_Name_Blod];

}

+ (UIFont *)refreshAndLoadingFont
{
    return [self fontWithSmallSzie:12 middleSize:13 bigSize:14 AndFontName:font_Name_Blod];

}

+ (UIFont *)fontWithSmallSzie:(CGFloat)samllSize middleSize:(CGFloat)middelSize bigSize:(CGFloat)bigSize AndFontName:(NSString *)fontName
{
    if (IS_IPHONE_6_PLUS == CBN_Screen_Height) {
        return [UIFont fontWithName:fontName size:bigSize];
        
    }else if (IS_IPHONE_6 == CBN_Screen_Height){
        return [UIFont fontWithName:fontName size:middelSize];

    }else{
        return [UIFont fontWithName:fontName size:samllSize];

    }
}
@end
