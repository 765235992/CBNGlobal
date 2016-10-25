//
//  CBNHomePageHeaderView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNHomePageHeaderView.h"
#import "CBNHomePageRecommendedNewsView.h"
#import "CBNLiveShuffingView.h"
@interface CBNHomePageHeaderView ()<CBNLiveShuffingViewDelegate,CBNHomePageRecommendedNewsViewDlegate>
@property (nonatomic, strong) CBNHomePageRecommendedNewsView *recommendedNewsView;

@property (nonatomic, strong) CBNLiveShuffingView *liveShuffingView;


@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation CBNHomePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.recommendedNewsView];
        
        [self addSubview:self.liveShuffingView];
        
        self.frame = CGRectMake(0, 0, CBN_Screen_Width, _liveShuffingView.frame.size.height + _liveShuffingView.frame.origin.y + news_Cell_Up_Or_Down_Margin);
        
        [self addSubview:self.lineImageView];
        
    }
    return self;
}

- (CBNHomePageRecommendedNewsView *)recommendedNewsView
{
    if (!_recommendedNewsView) {
        
        self.recommendedNewsView = [[CBNHomePageRecommendedNewsView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Width*1.4)];
        
        _recommendedNewsView.delegate = self;
    }
    
    return _recommendedNewsView;
}

- (void)homePageRecommendedNewsView:(CBNHomePageRecommendedNewsView *)homePageRecommendedNewsView newsItemModel:(CBNNewsItemModel *)newsItemModel
{
    if ([self.delegate respondsToSelector:@selector(homePageHeaderLiveShuffingView:recommendedNews:)]) {
        [self.delegate homePageHeaderLiveShuffingView:self recommendedNews:newsItemModel];
        
    }
}
- (CBNLiveShuffingView *)liveShuffingView
{
    if (!_liveShuffingView) {
        
        self.liveShuffingView = [[CBNLiveShuffingView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _recommendedNewsView.frame.size.height, CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin, 50)];
        
        _liveShuffingView.delegate = self;
        
        _liveShuffingView.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    return _liveShuffingView;
}
- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin,self.frame.size.height-1,CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin, 1)];
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
    }
    
    return _lineImageView;
}

- (void)liveShuffingView:(CBNLiveShuffingView *)liveShuffingView didSelecteAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(homePageHeaderLiveShuffingView:didSelectedAtIndex:)]) {
        [self.delegate homePageHeaderLiveShuffingView:self didSelectedAtIndex:index];
    }
}


- (void)setLiveModelArray:(NSMutableArray *)liveModelArray
{
    _liveModelArray = liveModelArray;
    
    _liveShuffingView.liveModelArray = _liveModelArray;
    
    
}

- (void)setRemondNewsModel:(CBNNewsItemModel *)remondNewsModel
{
    _remondNewsModel = remondNewsModel;
    
    _recommendedNewsView.recommendNewsModel = remondNewsModel;
}

@end
