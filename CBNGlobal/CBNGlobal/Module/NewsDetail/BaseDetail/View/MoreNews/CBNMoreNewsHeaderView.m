//
//  CBNMoreNewsHeaderView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNMoreNewsHeaderView.h"


@interface CBNMoreNewsHeaderView ()
@property (nonatomic, strong) UIImageView *blodLineImageView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UIImageView *lineImageView;
@end

@implementation CBNMoreNewsHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.blodLineImageView];
        [self addSubview:self.promptLabel];
        [self addSubview:self.lineImageView];
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}


- (UIImageView *)blodLineImageView
{
    if (!_blodLineImageView) {
        
        self.blodLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, 0, CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin, 2)];
        
        _blodLineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
        
    }
    
    return _blodLineImageView;
}
- (UILabel *)promptLabel
{
    if (!_promptLabel) {
        
        self.promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, 2+news_Cell_Left_Or_Right_Margin, CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin, [NSString getTextHeightWithFont:[UIFont newsTitleFont]])];
        
        
        _promptLabel.dk_textColorPicker = DKColorPickerWithKey(news_Title_Color);
        _promptLabel.font = [UIFont newsTitleFont];
        
        _promptLabel.text = @"Most read";
    }
    
    return _promptLabel;
}

- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, self.frame.size.height-1, CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin, 1)];
        
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
        
    }
    
    return _lineImageView;
}




@end
