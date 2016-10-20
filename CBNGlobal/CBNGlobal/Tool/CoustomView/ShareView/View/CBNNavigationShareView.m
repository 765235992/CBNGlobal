//
//  CBNNavigationShareView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNNavigationShareView.h"
#define share_Up_Margin 4

@interface CBNNavigationShareView ()

@end

@implementation CBNNavigationShareView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        [self setArrow];
        [self setupSubviews];
        
        
    }
    return self;
}
- (void)setArrow
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 15)];
    
    view.backgroundColor = [UIColor redColor];
    
    [self addSubview:view];
}
- (void)setupSubviews
{
    CGFloat height = 15;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, height, self.frame.size.width, 0)];
    backgroundView.backgroundColor= [UIColor whiteColor];
    [self addSubview:backgroundView];
    NSArray *typeArray = @[[NSNumber numberWithInt:CBNShareFaceBookType],[NSNumber numberWithInt:CBNShareTwitterType],[NSNumber numberWithInt:CBNShareLinKedInType],[NSNumber numberWithInt:CBNShareEmailType]];
    NSArray *imageArray = @[@"CBN_facebook_icon@2x.png",@"CBN_twitter_icon@2x.png",@"CBN_linkedin_icon@2x.png",@"CBN_email_icon@2x.png"];
    CGFloat width = self.frame.size.width/1.5;
    for (int i = 0; i < typeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(0, height, width, width);
        
//        button.backgroundColor = [UIColor randomColor];
        
        button.tag = [[typeArray objectAtIndex:i] integerValue];
        
        [button setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        
        [button setBackgroundImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        
        button.center = CGPointMake(self.frame.size.width/2, button.center.y);
        
        
        [self addSubview:button];
        
        height = height + share_Up_Margin + width;
        
//        [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    backgroundView.frame = CGRectMake(0, 15, self.frame.size.width, height-15);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    

}




@end
