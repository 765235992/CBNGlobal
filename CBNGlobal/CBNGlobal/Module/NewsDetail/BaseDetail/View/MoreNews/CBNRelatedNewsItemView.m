//
//  CBNRelatedNewsItemView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNRelatedNewsItemView.h"

@interface CBNRelatedNewsItemView ()

@property (nonatomic, strong) UILabel *newsTitleLabel;

@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation CBNRelatedNewsItemView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.newsTitleLabel];
        
        [self addSubview:self.lineImageView];
    }
    return self;
}

- (UILabel *)newsTitleLabel
{
    if (!_newsTitleLabel) {
        
        self.newsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin, CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin, 0)];
        
        _newsTitleLabel.dk_textColorPicker = DKColorPickerWithKey(news_Title_Color);
        
        _newsTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        _newsTitleLabel.numberOfLines = 0;
        
        _newsTitleLabel.font = [UIFont relatedNewsFont];
        
    }
    
    return _newsTitleLabel;
}
- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, 0, CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin, 1)];
        
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
        
    }
    
    return _lineImageView;
}
- (void)setNewsTitleString:(NSString *)newsTitleString
{
    _newsTitleString = newsTitleString;
    _newsTitleLabel.text = _newsTitleString;
    
    
    [_newsTitleLabel sizeToFit];
    
    CGFloat label_Width = CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin;
    
    _newsTitleLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin, label_Width, _newsTitleLabel.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _newsTitleLabel.frame.size.height + 2*news_Cell_Up_Or_Down_Margin);
    
    _lineImageView.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, self.frame.size.height-1, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, 1);
    
}


@end
