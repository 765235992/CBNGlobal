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
- (void)dealloc
{
    NSLog(@"CBNShareBar");
}
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
    NSArray *imageArray = @[@"share-blue-facebook.png",@"share-blue-twitter.png",@"share-blue-in.png",@"share-blue-email.png"];
    for (int i = 0; i < typeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(width, 0, self.frame.size.height, self.frame.size.height);
        
        
        button.tag = [[typeArray objectAtIndex:i] integerValue];
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        
        [button setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        
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
