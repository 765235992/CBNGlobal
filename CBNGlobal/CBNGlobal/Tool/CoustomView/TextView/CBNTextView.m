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
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    }
    return self;
}
- (void)dealloc
{
    CBNLog(@"详情HTML文章释放");
}

- (void)setNewsDetaileModel:(CBNNewsDetailModel *)newsDetaileModel
{
    
    _newsDetaileModel = newsDetaileModel;
    


    
    
}
- (void)setAttText:(NSMutableAttributedString *)attText

{
    _attText = attText;
    
    self.attributedText = attText;
    
    self.autoresizingMask
    = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    [self sizeToFit];

}

@end
