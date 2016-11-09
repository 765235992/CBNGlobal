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
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 9)];
    view.image = [UIImage imageNamed:@"up-arrow.png"];
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.center = CGPointMake(self.frame.size.width-18, 9/2);
    
    
    [self addSubview:view];
}
- (void)setupSubviews
{
    CGFloat height = 15;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, self.frame.size.width, 0)];
    backgroundView.layer.cornerRadius = 6;
    backgroundView.layer.masksToBounds = YES;

    backgroundView.backgroundColor= [UIColor blackColor];
    [self addSubview:backgroundView];
    NSArray *typeArray = @[[NSNumber numberWithInt:CBNShareFaceBookType],[NSNumber numberWithInt:CBNShareTwitterType],[NSNumber numberWithInt:CBNShareLinKedInType],[NSNumber numberWithInt:CBNShareEmailType]];
    NSArray *imageArray = @[@"share-white-facebook.png",@"share-white-twitter.png",@"share-white-in.png",@"share-white-email.png"];
    CGFloat width = self.frame.size.width/1.5;
    for (int i = 0; i < typeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(0, height, width, width);
        
        button.backgroundColor = [UIColor clearColor];
        
        button.tag = [[typeArray objectAtIndex:i] integerValue];
        
                [button setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        
        [button setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        
        button.center = CGPointMake(self.frame.size.width/2, button.center.y);
        
        
        [self addSubview:button];
        
        height = height + share_Up_Margin + width;
        
        [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    backgroundView.frame = CGRectMake(0, 8, self.frame.size.width, height-8);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    

}

- (void)button:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(sharePlateFromTag:)]) {
        [self.delegate sharePlateFromTag:sender.tag];
        
    }
}


@end
