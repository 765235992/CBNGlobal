//
//  CBNNewsTimeLabel.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNNewsTimeLabel.h"

@interface CBNNewsTimeLabel ()

@property (nonatomic, strong) UIImageView *tiemIconImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation CBNNewsTimeLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.timeLabel];

        [self addSubview:self.tiemIconImageView];
        
    }
    return self;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 35)];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font =  [UIFont fontWithName:@"STHeitiSC-Light" size:[UIDevice getFontSizeWithBaseFontSize:10]];
        _timeLabel.text = @"Yicai";

        _timeLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _timeLabel;
}
- (UIImageView *)tiemIconImageView
{
    if (!_tiemIconImageView) {
        
        self.tiemIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        
        _tiemIconImageView.backgroundColor = [UIColor redColor];

    }
    
    return _tiemIconImageView;
}
- (void)setText:(NSString *)text
{
    _text = text;
    
    _timeLabel.text = text;
    [_timeLabel sizeToFit];
    _timeLabel.frame = CGRectMake(_timeLabel.frame.size.height+3, 0, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
    _tiemIconImageView.frame = CGRectMake(0, 0, _timeLabel.frame.size.height, _timeLabel.frame.size.height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _timeLabel.frame.size.width + _timeLabel.frame.size.height + 3, _timeLabel.frame.size.height);
    
}









@end
