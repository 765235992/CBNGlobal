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

@interface CBNTextView ()<UITextViewDelegate,UIScrollViewDelegate>
@end
@implementation CBNTextView
- (void)dealloc
{
    NSLog(@"CBNTextView 释放");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.editable = NO;
        self.selectable = NO;
        self.allowsEditingTextAttributes = NO;
        self.delegate = self;
        self.userInteractionEnabled = YES;
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    return self;
}

- (void)setNewsDetaileModel:(CBNNewsDetailModel *)newsDetaileModel
{
    
    _newsDetaileModel = newsDetaileModel;
    


    
    
}
- (void)setAttText:(NSMutableAttributedString *)attText

{
    _attText = attText;
    
    self.attributedText = attText;
    
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    [self sizeToFit];

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"111");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"22");
}
@end
