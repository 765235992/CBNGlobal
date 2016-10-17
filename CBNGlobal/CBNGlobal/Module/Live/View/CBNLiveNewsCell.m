//
//  CBNLiveNewsCell.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLiveNewsCell.h"

#define circle_Width 5
@interface CBNLiveNewsCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *circleImageView;
@property (nonatomic, strong) UIImageView *verticalLineImageView;
@property (nonatomic, strong) UIImageView *crossLineImageView;
@property (nonatomic, strong) UILabel *liveTitleLabel;
@property (nonatomic, strong) UILabel *liveContenLabel;
@property (nonatomic, strong) UIButton *detailButton;
@end

@implementation CBNLiveNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.timeLabel];
        [self addSubview:self.verticalLineImageView];
        [self addSubview:self.circleImageView];
        [self addSubview:self.liveTitleLabel];
        [self addSubview:self.liveContenLabel];
        [self addSubview:self.detailButton];
        [self addSubview:self.circleImageView];
    }
    
    return self;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, 0, 100, 0)];
        
        _timeLabel.text = @"--:--";
        
        _timeLabel.font =  [UIFont fontWithName:@"STHeitiSC-Light" size:[UIDevice getFontSizeWithBaseFontSize:11]];

        [_timeLabel sizeToFit];
        
        _timeLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, 0, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
        
        _timeLabel.backgroundColor = [UIColor redColor];
        
        
    }
    
    return _timeLabel;
}

- (UIImageView *)circleImageView
{
    if (!_circleImageView) {
        
        self.circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_timeLabel.frame.size.width + news_Cell_Left_Or_Right_Margin*3 , 0, circle_Width, circle_Width)];
        
        _circleImageView.backgroundColor = [UIColor redColor];
        
    }
    
    return _circleImageView;
}
- (UIImageView *)verticalLineImageView
{
    if (!_verticalLineImageView) {
        
        self.verticalLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_timeLabel.frame.size.width + news_Cell_Left_Or_Right_Margin*3 + (circle_Width-1)/2, 0, 1, self.frame.size.height)];
        
        _verticalLineImageView.backgroundColor = [UIColor blackColor];
        
    }
    
    return _verticalLineImageView;
}

- (UILabel *)liveTitleLabel
{
    if (!_liveContenLabel) {
        
        CGFloat width = CBN_Screen_Width - (_circleImageView.frame.size.width + _circleImageView.frame.origin.x + news_Cell_Left_Or_Right_Margin * 3);
        
        self.liveTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_circleImageView.frame.size.width + _circleImageView.frame.origin.x + news_Cell_Left_Or_Right_Margin * 2, news_Cell_Up_Or_Down_Margin, width, 0)];
        _liveTitleLabel.backgroundColor = [UIColor greenColor];
        
        _liveTitleLabel.text = @"Beijing Chokes Again, Smothered by Smog for Three Days";
        
        _liveTitleLabel.font = CBN_News_Title_Font;
        
        _liveTitleLabel.numberOfLines = 0;
        
        [_liveTitleLabel sizeToFit];
        
        _liveTitleLabel.frame = CGRectMake(_circleImageView.frame.size.width + _circleImageView.frame.origin.x + news_Cell_Left_Or_Right_Margin * 2, 0, width, _liveTitleLabel.frame.size.height);
        
        
    }
    
    return _liveTitleLabel;
}


- (UILabel *)liveContenLabel
{
    if (!_liveContenLabel) {
        CGFloat width = CBN_Screen_Width - (_circleImageView.frame.size.width + _circleImageView.frame.origin.x + news_Cell_Left_Or_Right_Margin * 3);

        self.liveContenLabel =  [[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.frame.size.width + _timeLabel.frame.origin.x + news_Cell_Left_Or_Right_Margin * 2, 0 + _liveTitleLabel.frame.size.height, width, 0)];
        _liveContenLabel.backgroundColor = [UIColor greenColor];
        
        _liveContenLabel.text = @"Beijing Chokes Again, Smothered by Smog for Three Days";
        
        _liveContenLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:[UIDevice getFontSizeWithBaseFontSize:13]];
        
        _liveContenLabel.numberOfLines = 0;
        
        [_liveContenLabel sizeToFit];
        
        _liveContenLabel.frame = CGRectMake(_circleImageView.frame.size.width + _circleImageView.frame.origin.x + news_Cell_Left_Or_Right_Margin * 2, news_Cell_Up_Or_Down_Margin  + _liveTitleLabel.frame.size.height, width, _liveTitleLabel.frame.size.height);
        

    }
    
    return _liveContenLabel;
}

- (UIButton *)detailButton
{
    if (!_detailButton) {
        
        self.detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _detailButton.frame = CGRectMake(CBN_Screen_Width - 100 - news_Cell_Left_Or_Right_Margin, _liveContenLabel.frame.size.height + _liveContenLabel.frame.origin.y + news_Cell_Up_Or_Down_Margin ,100  , 30);
        
        
        _detailButton.backgroundColor = [UIColor redColor];
    }
    
    return _detailButton;
}
@end
