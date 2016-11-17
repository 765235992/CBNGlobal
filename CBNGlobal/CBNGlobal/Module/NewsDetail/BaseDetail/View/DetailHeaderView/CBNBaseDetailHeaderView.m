//
//  CBNBaseDetailHeaderView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseDetailHeaderView.h"
#import "CBNNewsTimeLabel.h"
@interface CBNBaseDetailHeaderView ()
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) CBNNewsTimeLabel *timeLabel;
@end

@implementation CBNBaseDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _height = news_Cell_Up_Or_Down_Margin;
        
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.authorNameLabel];
        
        [self addSubview:self.timeLabel];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin, CBN_Screen_Width- 2*news_Cell_Left_Or_Right_Margin, 0)];
        
        _titleLabel.numberOfLines = 0;
        
        _titleLabel.font = [UIFont newsDetaileTitleFont];
        
        
    }
    
    return _titleLabel;
}

- (UILabel *)authorNameLabel
{
    if (!_authorNameLabel) {
        
        self.authorNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _height, 100, 0)];
        
        _authorNameLabel.backgroundColor = [UIColor clearColor];
        _authorNameLabel.dk_textColorPicker = DKColorPickerWithKey(news_Small_Tag_Color);
        _authorNameLabel.font = [UIFont tagFont];
    }
    
    return _authorNameLabel;
}


- (CBNNewsTimeLabel *)timeLabel
{
    if (!_timeLabel) {
        
        self.timeLabel = [[CBNNewsTimeLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _timeLabel.backgroundColor = [UIColor clearColor];
        
        _timeLabel.text = @"2016-10-17";
        
        _timeLabel.frame = CGRectMake(CBN_Screen_Width- news_Cell_Left_Or_Right_Margin - _timeLabel.frame.size.width, _authorNameLabel.frame.origin.y, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
        
    }
    
    return _timeLabel;
}

- (void)setNewsDetailModel:(CBNNewsDetailModel *)newsDetailModel
{
    _newsDetailModel = newsDetailModel;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    _titleLabel.text = _newsDetailModel.NewsTitle;
    [_titleLabel sizeToFit];
    
    _titleLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, _height, CBN_Screen_Width- 2*news_Cell_Left_Or_Right_Margin, _titleLabel.frame.size.height);
    
    _height = _height + _titleLabel.frame.size.height + news_Cell_Up_Or_Down_Margin;
    
    
    
    if (_newsDetailModel.NewsAuthor.length>0&&_newsDetailModel.NewsSource.length>0) {
        
        _authorNameLabel.text = [NSString stringWithFormat:@"%@,%@",_newsDetailModel.NewsAuthor,_newsDetailModel.NewsSource];
        [_authorNameLabel sizeToFit];
        
        _authorNameLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, _height, _authorNameLabel.frame.size.width+news_Cell_Left_Or_Right_Margin, _authorNameLabel.frame.size.height);
    }else{
        
        if (_newsDetailModel.NewsAuthor.length >0) {
            
            _authorNameLabel.text =  _newsDetailModel.NewsAuthor;
            [_authorNameLabel sizeToFit];

            _authorNameLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, _height, _authorNameLabel.frame.size.width+news_Cell_Left_Or_Right_Margin, _authorNameLabel.frame.size.height);

            
        }
        if (_newsDetailModel.NewsSource.length > 0) {
            _authorNameLabel.text =  _newsDetailModel.NewsSource;

            [_authorNameLabel sizeToFit];

            _authorNameLabel.text =  _newsDetailModel.NewsSource;
            
            _authorNameLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, _height, _authorNameLabel.frame.size.width+news_Cell_Left_Or_Right_Margin, _authorNameLabel.frame.size.height);

        }
        
        if (_newsDetailModel.NewsAuthor.length == 0&&_newsDetailModel.NewsSource.length == 0) {
            _authorNameLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, _height, 0, _authorNameLabel.frame.size.height);

        }
    }
    
    _timeLabel.text = [NSDate getNormalDateFromUTCDateString:_newsDetailModel.LastDate];
    
    [_timeLabel sizeToFit];

    _timeLabel.frame = CGRectMake(_authorNameLabel.frame.origin.x + _authorNameLabel.frame.size.width, _height, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _timeLabel.frame.size.height + _timeLabel.frame.origin.y );
}


@end
