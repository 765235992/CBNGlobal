//
//  CBNLiveHeaderView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLiveHeaderView.h"

@interface CBNLiveHeaderView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UILabel *timeLabel;


@end

@implementation CBNLiveHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.backgroundImageView];
        
        
    }
    return self;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, news_Cell_Up_Or_Down_Margin, CBN_Screen_Width, self.frame.size.height- 2*news_Cell_Up_Or_Down_Margin)];
        
        _backgroundImageView.image = [UIImage imageNamed:@"live-background.png"];

        [_backgroundImageView addSubview:self.timeLabel];

    }
    
    return _backgroundImageView;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Cell_Left_Or_Right_Margin, 0, CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin, _backgroundImageView.frame.size.height)];
        
        _timeLabel.backgroundColor = [UIColor clearColor];
        
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(CBN_Blue_Color);
        
        _timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        _timeLabel.numberOfLines = 0;
        
        _timeLabel.textAlignment = 0;
        
        _timeLabel.font = [UIFont newsTitleFont];
        
//        _timeLabel.text = @"2016-10-19";

    }
    
    return _timeLabel;
}
- (void)setTime:(NSString *)time
{
    _time = time;
    
    _timeLabel.text = _time;
}
@end
