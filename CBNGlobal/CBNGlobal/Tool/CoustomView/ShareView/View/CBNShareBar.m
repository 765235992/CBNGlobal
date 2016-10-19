//
//  CBNShareBar.m
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNShareBar.h"

#define share_Margin 10

@implementation CBNShareBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews
{
    CGFloat width = news_Cell_Left_Or_Right_Margin;
    
    NSArray *typeArray = @[[NSNumber numberWithInt:CBNShareFaceBookType],[NSNumber numberWithInt:CBNShareTwitterType],[NSNumber numberWithInt:CBNShareLinKedInType],[NSNumber numberWithInt:CBNShareEmailType]];
    NSArray *imageArray = @[@"CBN_facebook_icon@2x.png",@"CBN_twitter_icon@2x.png",@"CBN_linkedin_icon@2x.png",@"CBN_email_icon@2x.png"];
    for (int i = 0; i < typeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(width, 0, self.frame.size.height, self.frame.size.height);
        
//        button.backgroundColor = [UIColor randomColor];
        
        button.tag = [[typeArray objectAtIndex:i] integerValue];
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        
        [button setBackgroundImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        
        [self addSubview:button];
        
        width = width + share_Margin + self.frame.size.height;
        
        [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
}



- (void)button:(UIButton *)sender
{
    
    if ([self.delegate respondsToSelector:@selector(shareBar:shareType:)]) {
        [self.delegate shareBar:self shareType:(CBNShareType)sender.tag];
    }
    
}

@end
