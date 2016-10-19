//
//  CBNTextView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNTextView.h"
#define baseColor [UIColor blackColor]

#define baseFont [UIFont fontWithName:@"Helvetica" size:18]

#define keyWordColor [UIColor orangeColor]

#define readPressColor [UIColor orangeColor]

@interface CBNTextView ()
@end
@implementation CBNTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.editable = NO;
        self.selectable = NO;
        self.allowsEditingTextAttributes = NO;
        
        
    
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        
        NSString *filePath =[resourcePath stringByAppendingPathComponent:@"text.html"];
        
        NSString *pString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithData:[[self getHtmlStringWithPString:pString] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithData:[[self getHtmlStringWithPString:[self aaa]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:attributeString];
        self.attributedText = attr;

        self.autoresizingMask
        = UIViewAutoresizingFlexibleHeight;//自适应高度
        [self sizeToFit];

        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
//        self.scrollEnabled = NO;
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"dealloc -- %@",self);
}

- (NSString *)getHtmlStringWithPString:(NSString *)pString
{
    NSString *strUrl = [pString stringByReplacingOccurrencesOfString:@"background-color:rgb(245, 245, 245);" withString:@"background-colorlll"];

    NSString *styleHeader = @"<style type=\"text/css\">";
    NSString *blockquote = @"blockquote{border-left:5px solid #DDD;margin:15px 30px 0 3px; padding-left:20px}";
    NSString *backgroundColor = @"background-color:AA;";
    NSString *textColor = @"color:#212121;";
    NSString *textAlignment = @"text-align:justify;";
    NSString *textFoneSize = @"font-size:14px;";
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
