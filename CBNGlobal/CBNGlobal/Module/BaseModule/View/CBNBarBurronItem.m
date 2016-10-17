//
//  CBNBarBurronItem.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBarBurronItem.h"
@interface CBNBarBurronItem ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation CBNBarBurronItem
-(instancetype)initWithTarget:(id)target action:(SEL)action andFrame:(CGRect)rect andImage:(UIImage *)image
{
    
    UIButton *button = [self createButton:rect andImage:image];
    
    self = [self initWithCustomView:button];
    if(self){
        [self setButton:button];
    }
    //    self.style = UIBarButtonItemStyleBordered;
    self.action = action;
    
    self.target = target;
    
    return self;
}

- (UIButton *)createButton:(CGRect)rect andImage:(UIImage *)image
{
    UIButton *buttonView = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonView.backgroundColor = [UIColor redColor];
    buttonView.frame = rect;
    
    [buttonView setImage:image forState:UIControlStateNormal];
    
    [buttonView setBackgroundImage:image forState:UIControlStateNormal];
    
    [buttonView addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return buttonView;
    
}
-(void)buttonClicked:(id)sender{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.target performSelector:self.action withObject:sender];
#pragma clang diagnostic pop;
    
}

@end
