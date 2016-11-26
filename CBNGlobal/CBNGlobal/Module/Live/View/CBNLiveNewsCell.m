//
//  CBNLiveNewsCell.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLiveNewsCell.h"
#import "CBNLiveDetailButton.h"

#define detail_Button_Height 25
#define detail_Button_Width 50

#define circle_Width 10
@interface CBNLiveNewsCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *circleImageView;
@property (nonatomic, strong) UIImageView *verticalLineImageView;
@property (nonatomic, strong) UIImageView *crossLineImageView;
@property (nonatomic, strong) UILabel *liveTitleLabel;
@property (nonatomic, strong) UILabel *liveContenLabel;
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
//        [self addSubview:self.detailButton];
        [self addSubview:self.circleImageView];
        [self addSubview:self.crossLineImageView];
    }
    
    return self;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Cell_Left_Or_Right_Margin, 0, 100, 0)];
        _timeLabel.dk_textColorPicker = DKColorPickerWithKey(news_Title_Color);
        
        _timeLabel.textColor = UIColorFromRGB(0x595959);

        _timeLabel.numberOfLines = 0;

        _timeLabel.text = @"00:00";
        
        _timeLabel.font = [UIFont fontWithSmallSzie:13 middleSize:15 bigSize:18 AndFontName:font_Name_Blod];

        [_timeLabel sizeToFit];
        
        _timeLabel.frame = CGRectMake(Cell_Left_Or_Right_Margin, 0, _timeLabel.frame.size.width+5, _timeLabel.frame.size.height);
        
        

    }
    
    return _timeLabel;
}

- (UIImageView *)circleImageView
{
    if (!_circleImageView) {
        
        self.circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_timeLabel.frame.size.width + news_Cell_Left_Or_Right_Margin*3 , 0, circle_Width, circle_Width)];
        _circleImageView.layer.masksToBounds = YES;
        _circleImageView.layer.cornerRadius = circle_Width/2;
        _circleImageView.layer.borderWidth = 1;
        _circleImageView.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
        
        _circleImageView.dk_backgroundColorPicker = DKColorPickerWithKey(CBN_Blue_Color);
        
    }
    
    return _circleImageView;
}
- (UIImageView *)verticalLineImageView
{
    if (!_verticalLineImageView) {
        
        self.verticalLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_timeLabel.frame.size.width + news_Cell_Left_Or_Right_Margin*3 + (circle_Width-1)/2, 4, 1, self.frame.size.height-4)];
        
        _verticalLineImageView.backgroundColor = [UIColor blackColor];
        
    }
    
    return _verticalLineImageView;
}

- (UILabel *)liveTitleLabel
{
    if (!_liveContenLabel) {
        
        CGFloat width = CBN_Screen_Width - (_circleImageView.frame.size.width + _circleImageView.frame.origin.x + news_Cell_Left_Or_Right_Margin * 3);
        
        self.liveTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_circleImageView.frame.size.width + _circleImageView.frame.origin.x + news_Cell_Left_Or_Right_Margin * 2, news_Cell_Up_Or_Down_Margin, width, 0)];
        
        _liveTitleLabel.dk_textColorPicker = DKColorPickerWithKey(news_Title_Color);
        
        _liveTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        _liveTitleLabel.numberOfLines = 0;
        
        _liveTitleLabel.font = [UIFont newsTitleFont];
        
        
   
        
        
    }
    
    return _liveTitleLabel;
}


- (UILabel *)liveContenLabel
{
    if (!_liveContenLabel) {
        CGFloat width = CBN_Screen_Width - (_circleImageView.frame.size.width + _circleImageView.frame.origin.x + news_Cell_Left_Or_Right_Margin * 1.5+Cell_Left_Or_Right_Margin);

        self.liveContenLabel =  [[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.frame.size.width + _timeLabel.frame.origin.x + news_Cell_Left_Or_Right_Margin * 2, 0 + _liveTitleLabel.frame.size.height, width, 0)];
        _liveContenLabel.dk_textColorPicker = DKColorPickerWithKey(news_Content_Color);
        
        _liveContenLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        _liveContenLabel.numberOfLines = 0;
        
        _liveContenLabel.font = [UIFont newsContentFont];
        

    }
    
    return _liveContenLabel;
}

- (UIImageView *)crossLineImageView
{
    if (!_crossLineImageView) {
        
        self.crossLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, 0, CBN_Screen_Width , 1)];
        _crossLineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
        
    }
    
    return _crossLineImageView;
}
- (void)detailButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(liveNewsCell:detailButtonClickedWithLiveModel:)]) {
        [self.delegate liveNewsCell:self detailButtonClickedWithLiveModel:_liveModel];
        
    }
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
}
- (void)setLiveModel:(CBNLiveModel *)liveModel
{
    _liveModel = liveModel;
    
    _timeLabel.text = [NSDate getHourDateFromUTCDateString:_liveModel.newsModel.CreateDate];
    
    
    CGFloat width = CBN_Screen_Width - (_circleImageView.frame.size.width + _circleImageView.frame.origin.x  + news_Cell_Left_Or_Right_Margin + Cell_Left_Or_Right_Margin*2);
    
    _circleImageView.frame = CGRectMake(_timeLabel.frame.origin.x+_timeLabel.frame.size.width + news_Cell_Left_Or_Right_Margin*1.5, _timeLabel.frame.origin.y +(_timeLabel.frame.size.height - circle_Width*0.8 )/2, _circleImageView.frame.size.width, _circleImageView.frame.size.height);

    CGFloat height = 0.0;
    
    _liveTitleLabel.frame= CGRectMake(0, 0, width, 0);
    
    _liveTitleLabel.text = _liveModel.newsModel.NewsTitle;
    
    [_liveTitleLabel sizeToFit];
//    _liveTitleLabel.backgroundColor = [UIColor redColor];
//    _liveContenLabel.backgroundColor = [UIColor orangeColor];
    
    _liveTitleLabel.frame = CGRectMake(_circleImageView.frame.size.width + _circleImageView.frame.origin.x + news_Cell_Left_Or_Right_Margin * 2, 0, width, _liveTitleLabel.frame.size.height);
    
    height = _liveTitleLabel.frame.size.height + news_Cell_Up_Or_Down_Margin;
    
    _liveContenLabel.frame= CGRectMake(0, 0, width, 0);
    
    _liveContenLabel.attributedText = [NSMutableAttributedString setLiveContentAttributeStringWithFont:_liveContenLabel.font string:_liveModel.newsModel.NewsNotes];
    
    [_liveContenLabel sizeToFit];
    
    _liveContenLabel.frame = CGRectMake(_circleImageView.frame.size.width + _circleImageView.frame.origin.x + news_Cell_Left_Or_Right_Margin * 2,height, width, _liveContenLabel.frame.size.height);
    
    height = height + _liveContenLabel.frame.size.height + news_Cell_Up_Or_Down_Margin;
    
    _crossLineImageView.frame = CGRectMake(_liveContenLabel.frame.origin.x, height, width, 1);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height+news_Cell_Up_Or_Down_Margin);
    
    if (_index!=0) {
        _verticalLineImageView.frame = CGRectMake(_circleImageView.center.x, 0, _verticalLineImageView.frame.size.width, self.frame.size.height);

    }else{
        _verticalLineImageView.frame = CGRectMake(_circleImageView.center.x, _circleImageView.frame.origin.y, _verticalLineImageView.frame.size.width, self.frame.size.height);

    }
    
    _liveModel.height = self.frame.size.height;
    
    [_verticalLineImageView setNeedsLayout];
    
    [_verticalLineImageView setNeedsDisplay];
    
    [self setNeedsDisplay];
    
    [self setNeedsLayout];

}
@end
