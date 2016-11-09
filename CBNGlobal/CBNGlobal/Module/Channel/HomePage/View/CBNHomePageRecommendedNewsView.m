//
//  CBNHomePageRecommendedNewsView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNHomePageRecommendedNewsView.h"

@interface CBNHomePageRecommendedNewsView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *newsThumbImageView;

@property (nonatomic, strong) UILabel *newsTitleLabel;
@end

@implementation CBNHomePageRecommendedNewsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self addSubview:self.newsThumbImageView];
        
        [self addSubview:self.newsTitleLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        
        [self addGestureRecognizer:tap];
        
        self.frame = CGRectMake(0, 0, CBN_Screen_Width, _newsTitleLabel.frame.size.height + _newsTitleLabel.frame.origin.y + news_Cell_Up_Or_Down_Margin);
        
    }
    return self;
}
- (void)tap:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(homePageRecommendedNewsView:newsItemModel:)]) {
        
        [self.delegate homePageRecommendedNewsView:self newsItemModel:nil];
    }
}
- (UIImageView *)newsThumbImageView
{
    if (!_newsThumbImageView) {
        
        self.newsThumbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Width * 0.6)];
        
        
        _newsThumbImageView.image = [UIImage imageNamed:@"default-image.png"];

    }
    
    return _newsThumbImageView;
}

- (UILabel *)newsTitleLabel
{
    if (!_newsTitleLabel) {
        
        self.newsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin, CBN_Screen_Width - 2* news_Cell_Left_Or_Right_Margin, 0)];
        _newsTitleLabel.numberOfLines = 0;
        
        _newsTitleLabel.dk_textColorPicker = DKColorPickerWithKey(news_Title_Color);
        
        _newsTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        
        _newsTitleLabel.font = [UIFont newsTitleFont];

        
        _newsTitleLabel.text = @"Beijing Chokes Again, Smothered by Smog for Three Days";
        
        [_newsTitleLabel sizeToFit];
        
        _newsTitleLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin + _newsThumbImageView.frame.size.height, CBN_Screen_Width - 2* news_Cell_Left_Or_Right_Margin , _newsTitleLabel.frame.size.height);
    }
    
    return _newsTitleLabel;
}


- (void)setRecommendNewsModel:(CBNNewsModel *)recommendNewsModel
{
    _recommendNewsModel = recommendNewsModel;
    
    _newsTitleLabel.text = recommendNewsModel.NewsTitle;
    
    [_newsTitleLabel sizeToFit];
    
    _newsTitleLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin + _newsThumbImageView.frame.size.height, CBN_Screen_Width - 2* news_Cell_Left_Or_Right_Margin , _newsTitleLabel.frame.size.height);
    
    [_newsThumbImageView sd_setImageWithURL:[NSURL URLWithString:[[CBNParametersLinkManager sharedManager] getNewsThumbName:recommendNewsModel.NewsThumbs]] placeholderImage: [UIImage imageNamed:@"default-image.png"]];
    
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _newsTitleLabel.frame.origin.y+_newsTitleLabel.frame.size.height + news_Cell_Up_Or_Down_Margin);
    
}
@end
