//
//  CBNChannelNewsTextCell.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNChannelNewsTextCell.h"
#import "CBNNewsTimeLabel.h"

#define title_And_Author_Margin _newsThumbImageView.frame.size.width + 2*news_Cell_Left_Or_Right_Margin
@interface CBNChannelNewsTextCell ()
@property (nonatomic, strong) UILabel *newsTitleLabel;

@property (nonatomic, strong) UIImageView *newsThumbImageView;


@property (nonatomic, strong) UILabel *authorNameLabel;

@property (nonatomic, strong) CBNNewsTimeLabel *timeLabel;

@property (nonatomic, strong) UIImageView *lineImageView;
@end

@implementation CBNChannelNewsTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.newsThumbImageView];

        [self addSubview:self.newsTitleLabel];
        
        [self addSubview:self.authorNameLabel];
        
        [self addSubview:self.timeLabel];
        
        [self addSubview:self.lineImageView];
    }
    
    return self;
}

- (UIImageView *)newsThumbImageView
{
    if (!_newsThumbImageView) {
        
        CGFloat imageHeight = [NSString getTextHeightWithFont:[UIFont newsTitleFont]]*4.5;
        
        self.newsThumbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin, imageHeight *1.6,  imageHeight * 1.6* 0.6)];
        _newsThumbImageView.contentMode = UIViewContentModeScaleToFill;
        _newsThumbImageView.image = [UIImage imageNamed:@"default-image.png"];
        
    }
    
    return _newsThumbImageView;
}

- (UILabel *)newsTitleLabel
{
    if (!_newsTitleLabel) {
        CGFloat label_Width =CBN_Screen_Width - (_newsThumbImageView.frame.size.width +news_Cell_Left_Or_Right_Margin*3);

        self.newsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(title_And_Author_Margin, news_Cell_Up_Or_Down_Margin, label_Width, 0)];
        
        _newsTitleLabel.dk_textColorPicker = DKColorPickerWithKey(news_Title_Color);
        
        _newsTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        _newsTitleLabel.numberOfLines = 3;

        _newsTitleLabel.font = [UIFont newsTitleFont];
        
        
        
    }
    
    return _newsTitleLabel;
}

- (UILabel *)authorNameLabel
{
    if (!_authorNameLabel) {
        
        self.authorNameLabel = [[UILabel alloc] init];
        
        _authorNameLabel.backgroundColor = [UIColor clearColor];
        _authorNameLabel.dk_textColorPicker = DKColorPickerWithKey(news_Small_Tag_Color);
        _authorNameLabel.font = [UIFont tagFont];
        
        _authorNameLabel.text = @"";
        
        [_authorNameLabel sizeToFit];
        
        _authorNameLabel.frame = CGRectMake(title_And_Author_Margin, _newsThumbImageView.frame.size.height+news_Cell_Up_Or_Down_Margin - _authorNameLabel.frame.size.height, _authorNameLabel.frame.size.width, _authorNameLabel.frame.size.height);
        
    }
    
    return _authorNameLabel;
}

- (CBNNewsTimeLabel *)timeLabel
{
    if (!_timeLabel) {
        
        self.timeLabel = [[CBNNewsTimeLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _timeLabel.backgroundColor = [UIColor clearColor];
        
        _timeLabel.text = @"";
        
        _timeLabel.frame = CGRectMake(CBN_Screen_Width- news_Cell_Left_Or_Right_Margin - _timeLabel.frame.size.width, _authorNameLabel.frame.origin.y, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
        
    }
    
    return _timeLabel;
}

- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Height-1, CBN_Screen_Width - 2* news_Cell_Left_Or_Right_Margin, 1)];
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
    }
    
    return _lineImageView;
}

- (void)setItemModel:(CBNNewsModel *)itemModel
{
    
    _itemModel = itemModel;
    
    _timeLabel.text = [NSDate getNormalDateFromUTCDateString:_itemModel.LastDate];
    
    if (_itemModel.NewsAuthor.length>0&&_itemModel.NewsSource.length>0) {
        
        _authorNameLabel.text = [NSString stringWithFormat:@"%@,%@",itemModel.NewsAuthor,itemModel.NewsSource];

    }else{
        
        if (_itemModel.NewsAuthor.length >0) {
            
            _authorNameLabel.text =  itemModel.NewsAuthor;
            
        }
        if (_itemModel.NewsSource.length > 0) {
            
            _authorNameLabel.text =  itemModel.NewsSource;

        }
    }
    
    [_authorNameLabel sizeToFit];
    
    _authorNameLabel.frame = CGRectMake(title_And_Author_Margin, _newsThumbImageView.frame.size.height+news_Cell_Up_Or_Down_Margin - _authorNameLabel.frame.size.height, _authorNameLabel.frame.size.width, _authorNameLabel.frame.size.height);
    _timeLabel.frame = CGRectMake(CBN_Screen_Width- news_Cell_Left_Or_Right_Margin - _timeLabel.frame.size.width, _newsThumbImageView.frame.size.height+news_Cell_Up_Or_Down_Margin - _timeLabel.frame.size.height, _timeLabel.frame.size.width, _timeLabel.frame.size.height);

    [_newsThumbImageView sd_setImageWithURL:[NSURL URLWithString:[[CBNParametersLinkManager sharedManager] getNewsThumbName:itemModel.NewsThumbs]] placeholderImage:[UIImage imageNamed:@"default-image.png"]];
    
    _newsTitleLabel.text = itemModel.NewsTitle;
    
    [_newsTitleLabel sizeToFit];
    
    CGFloat label_Width =CBN_Screen_Width - (_newsThumbImageView.frame.size.width +news_Cell_Left_Or_Right_Margin*3);
    
    _newsTitleLabel.frame = CGRectMake(title_And_Author_Margin, news_Cell_Up_Or_Down_Margin, label_Width, _newsTitleLabel.frame.size.height);
}

@end
