//
//  CBNRelatedNewsItemView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNRelatedNewsItemView.h"
#import "JYLabel.h"

@interface CBNRelatedNewsItemView ()

@property (nonatomic, strong) JYLabel *newsTitleLabel;

@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation CBNRelatedNewsItemView

- (void)dealloc
{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.newsTitleLabel];
        
        [self addSubview:self.lineImageView];
    }
    return self;
}

- (JYLabel *)newsTitleLabel
{
    if (!_newsTitleLabel) {
        
        self.newsTitleLabel = [[JYLabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin*1.5+4, news_Cell_Up_Or_Down_Margin, CBN_Screen_Width - 3*news_Cell_Left_Or_Right_Margin-4, 0)];
        
        _newsTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        _newsTitleLabel.font = [UIFont newsTitleFont];
        
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
- (void)setIndex:(NSInteger)index
{
    _index = index;
}
- (void)setNewsTitleString:(NSString *)newsTitleString
{
    _newsTitleString = newsTitleString;
    
    
    CGFloat label_Width = CBN_Screen_Width - 3*news_Cell_Left_Or_Right_Margin-4;
    
    NSString *resultString = [NSString stringWithFormat:@"<font color='#ADADAD'>%ld.</font> <font color='000000'>%@</font>",(long)_index,_newsTitleString];
    
    [_newsTitleLabel setText:resultString];

    CGSize optimumSize = [_newsTitleLabel optimumSize];
    
    CGRect frame = [_newsTitleLabel frame];
    
    frame.size.height = (int)optimumSize.height;
    
    [_newsTitleLabel setFrame:frame];

    _newsTitleLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin*1.5+4, news_Cell_Up_Or_Down_Margin, label_Width, _newsTitleLabel.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _newsTitleLabel.frame.size.height + 2*news_Cell_Up_Or_Down_Margin);
    
    _lineImageView.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, self.frame.size.height-1, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, 1);
    
}


@end
