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
        CBNLog(@"创建");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
        
        CGFloat imageHeight = [NSString getTextHeightWithFont:CBN_News_Title_Font]*4;
        
        self.newsThumbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin, imageHeight *1.3, imageHeight)];
        
        _newsThumbImageView.image = [UIImage imageNamed:@"defaultImage.jpg"];
        
    }
    
    return _newsThumbImageView;
}

- (UILabel *)newsTitleLabel
{
    if (!_newsTitleLabel) {
        
        self.newsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(title_And_Author_Margin, news_Cell_Up_Or_Down_Margin, CBN_Screen_Width - (_newsThumbImageView.frame.size.width + 2*news_Cell_Left_Or_Right_Margin *3), 0)];
        
        _newsTitleLabel.numberOfLines = 3;
        
        _newsTitleLabel.backgroundColor = [UIColor whiteColor];
        _newsTitleLabel.font = CBN_News_Title_Font;
        _newsTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        

        
        
    }
    
    return _newsTitleLabel;
}

- (UILabel *)authorNameLabel
{
    if (!_authorNameLabel) {
        
        self.authorNameLabel = [[UILabel alloc] init];
        
        _authorNameLabel.backgroundColor = [UIColor clearColor];
        _authorNameLabel.textColor = [UIColor grayColor];
        _authorNameLabel.font =  [UIFont fontWithName:@"STHeitiSC-Light" size:[UIDevice getFontSizeWithBaseFontSize:10]];
        _authorNameLabel.text = @"Yicai";
        
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
        
        _timeLabel.text = @"2016-10-17";
        
        _timeLabel.frame = CGRectMake(CBN_Screen_Width- news_Cell_Left_Or_Right_Margin - _timeLabel.frame.size.width, _authorNameLabel.frame.origin.y, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
        
    }
    
    return _timeLabel;
}

- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin,news_Cell_Height-1, CBN_Screen_Width - 2* news_Cell_Left_Or_Right_Margin, 1)];
        _lineImageView.backgroundColor = [UIColor blackColor];
    }
    
    return _lineImageView;
}
- (void)setFontName:(NSString *)fontName
{
//    _newsTitleLabel.text = @"Shenzhou-11 Astronauts Take With Them 100 Tasty Meals, Will Perform Outer Space Experiments";
//    _newsTitleLabel.font = [UIFont fontWithName:fontName size:[UIDevice getFontSizeWithBaseFontSize:14]];
    _newsTitleLabel.text = [NSString stringWithFormat:@"Beijing Chokes Again, Smothered by Smog for Three Days"];
//    NSLog(@"%@",fontName);
    [_newsTitleLabel sizeToFit];
    
    CGFloat label_Width =CBN_Screen_Width - (_newsThumbImageView.frame.size.width +news_Cell_Left_Or_Right_Margin*3);
    _newsTitleLabel.frame = CGRectMake(title_And_Author_Margin, news_Cell_Up_Or_Down_Margin, label_Width, _newsTitleLabel.frame.size.height);
}
@end
