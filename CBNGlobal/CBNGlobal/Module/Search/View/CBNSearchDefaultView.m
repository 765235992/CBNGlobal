//
//  CBNSearchDefaultView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearchDefaultView.h"


@interface CBNSearchDefaultView ()<CBNSearchChannelViewDelegate>
@property (nonatomic, strong) UILabel *channelPromptView;

@property (nonatomic, strong) UIImageView *lineImageView;

@property (nonatomic, strong) CBNSearchChannelView *channelView;


@end

@implementation CBNSearchDefaultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.channelPromptView];
        [self addSubview:self.lineImageView];
        
        [self addSubview:self.channelView];
        self.dk_backgroundColorPicker = DKColorPickerWithKey(defaule_Background_Color);

    }
    return self;
}

- (UILabel *)channelPromptView
{
    if (!_channelPromptView) {
        
        self.channelPromptView = [[UILabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin, 100, 0)];
        
        _channelPromptView.font = [UIFont fontWithSmallSzie:12 middleSize:13 bigSize:15 AndFontName:font_Name_Blod];
        
        _channelPromptView.dk_textColorPicker = DKColorPickerWithKey(news_Small_Tag_Color);

        _channelPromptView.text = @"您感兴趣的频道";
        
        [_channelPromptView sizeToFit];
        
        _channelPromptView.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin, _channelPromptView.frame.size.width, _channelPromptView.frame.size.height);
        
    }
    
    return _channelPromptView;
}

- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _channelPromptView.frame.size.height+_channelPromptView.frame.origin.y+news_Cell_Up_Or_Down_Margin, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, 1)];
        
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
        
    }
    
    return _lineImageView;
}

- (CBNSearchChannelView *)channelView
{
    if (!_channelView) {
        
        self.channelView = [[CBNSearchChannelView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _lineImageView.frame.size.height+_lineImageView.frame.origin.y+news_Cell_Up_Or_Down_Margin, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, 0)];
        _channelView.delegate = self;
        
    }
    
    return _channelView;
}
- (void)searchChannelView:(CBNSearchChannelView *)searchChannelView didSelectedAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(searchDefaultView:channelDidSelectedAtIndex:)]) {
        [self.delegate searchDefaultView:self channelDidSelectedAtIndex:index];
    }
}
@end
