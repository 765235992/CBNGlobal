//
//  CBNSearchCell.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/28.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearchCell.h"
#import "CBNNewsTimeLabel.h"

@interface CBNSearchCell ()
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) CBNNewsTimeLabel *timeLabel;
@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation CBNSearchCell


- (void)setSearchModel:(CBNSearchModel *)searchModel
{
    _searchModel = searchModel;
    _height = news_Cell_Up_Or_Down_Margin;

    _titleLabel.text = _searchModel.title;
    [_titleLabel sizeToFit];
    
    _titleLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, _height, CBN_Screen_Width- 2*news_Cell_Left_Or_Right_Margin, _titleLabel.frame.size.height);
    [_titleLabel setNeedsDisplay];
    
    _height = _height + _titleLabel.frame.size.height + news_Cell_Up_Or_Down_Margin;
    
    
    
    if (_searchModel.author.length>0&&_searchModel.source.length>0) {
        
        _authorNameLabel.text = [NSString stringWithFormat:@"%@,%@",_searchModel.author,_searchModel.source];
        [_authorNameLabel sizeToFit];
        
        _authorNameLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, _height, _authorNameLabel.frame.size.width+news_Cell_Left_Or_Right_Margin, _authorNameLabel.frame.size.height);
    }else{
        
        if (_searchModel.author.length >0) {
            
            _authorNameLabel.text =  _searchModel.author;
            [_authorNameLabel sizeToFit];
            
            _authorNameLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, _height, _authorNameLabel.frame.size.width+news_Cell_Left_Or_Right_Margin, _authorNameLabel.frame.size.height);
            
            
        }
        if (_searchModel.source.length > 0) {
            _authorNameLabel.text =  _searchModel.source;
            
            [_authorNameLabel sizeToFit];
            
            _authorNameLabel.text =  _searchModel.source;
            
            _authorNameLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, _height, _authorNameLabel.frame.size.width+news_Cell_Left_Or_Right_Margin, _authorNameLabel.frame.size.height);
            
        }
        
        if (_searchModel.author.length == 0&&_searchModel.source.length == 0) {
            _authorNameLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, _height, 0, _authorNameLabel.frame.size.height);
            
        }
    }
    
    _timeLabel.text = [NSDate getNormalDateFromDateString:_searchModel.creationDate];
    
    [_timeLabel sizeToFit];
    
    _timeLabel.frame = CGRectMake( CBN_Screen_Width - _timeLabel.frame.size.width-news_Cell_Left_Or_Right_Margin, _height, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CBN_Screen_Width, _timeLabel.frame.size.height + _timeLabel.frame.origin.y + news_Cell_Up_Or_Down_Margin+1);
    _searchModel.height = self.frame.size.height;
    
    _lineImageView.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, self.frame.size.height-2, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, 1);
    
    [self setNeedsDisplay];
    
    [self setNeedsLayout];

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _height = news_Cell_Up_Or_Down_Margin;
        
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.authorNameLabel];
        
        [self addSubview:self.timeLabel];
        
        [self addSubview:self.lineImageView];
        
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

- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, 0, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, 1)];
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
    }
    
    return _lineImageView;
}

@end
