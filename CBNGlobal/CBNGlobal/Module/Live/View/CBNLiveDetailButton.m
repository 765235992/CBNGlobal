//
//  CBNLiveDetailButton.m
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLiveDetailButton.h"

@interface CBNLiveDetailButton ()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImageView *crossImageView;

@property (nonatomic, strong) UIImageView *verticalImageView;
@end

@implementation CBNLiveDetailButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self addSubview:self.textLabel];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _textLabel.frame.size.width + _textLabel.frame.size.height*1.5, _textLabel.frame.size.height);
        _textLabel.frame = CGRectMake(_textLabel.frame.size.height*1.1, 0, _textLabel.frame.size.width, _textLabel.frame.size.height);

        [self addSubview:self.crossImageView];
        
        [self addSubview:self.verticalImageView];
        
    }
    return self;
}


- (UILabel *)textLabel
{
    if (!_textLabel) {
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        _textLabel.textColor = RGBColor_(245, 245, 245);
//        _textLabel.backgroundColor = [UIColor randomColor];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont fontWithSmallSzie:11 middleSize:13 bigSize:14 AndFontName:font_Name_Blod];
        
        _textLabel.text = @"Details";
        
        [_textLabel sizeToFit];
        _textLabel.frame = CGRectMake(0, 0, _textLabel.frame.size.width, _textLabel.frame.size.height);
        
        
    }
    
    return _textLabel;
}

- (UIImageView *)crossImageView
{
    if (!_crossImageView) {
        
        self.crossImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.height*0.35, 2, self.frame.size.height-6, 2)];
        
        _crossImageView.backgroundColor = [UIColor whiteColor];
        
        _crossImageView.center = CGPointMake(_crossImageView.center.x, self.frame.size.height/2);
        
    }
    
    return _crossImageView;
}

- (UIImageView *)verticalImageView
{
    if (!_verticalImageView) {
        
        self.verticalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.height-2, 1, 2, self.frame.size.height-6)];
        
        _verticalImageView.backgroundColor = [UIColor whiteColor];
        
        _verticalImageView.center = CGPointMake(_crossImageView.center.x, _crossImageView.center.y);
        
        
    }
    
    return _verticalImageView;
}
@end
