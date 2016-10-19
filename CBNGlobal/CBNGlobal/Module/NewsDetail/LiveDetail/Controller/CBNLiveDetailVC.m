
//
//  CBNLiveDetailVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLiveDetailVC.h"
#import "CBNLiveDetailHeaderView.h"
#import "CBNShareBar.h"
#import "CBNLiveMoreNewsView.h"

@interface CBNLiveDetailVC ()

@property (nonatomic, assign) CGFloat scrollViewHeight;

@property (nonatomic, strong) UIScrollView *aScrollView;

@property (nonatomic, strong) CBNLiveDetailHeaderView *liveHeaderView;

@property (nonatomic, strong) UILabel *liveContenLabel;

@property (nonatomic, strong) UILabel *authorNameLabel;

@property (nonatomic, strong) CBNShareBar *shareBar;

@property (nonatomic, strong) CBNLiveMoreNewsView *moreNewsView;
@end

@implementation CBNLiveDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _scrollViewHeight = 0.0;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.aScrollView];
    
    [self setupSubViews];

}


- (UIScrollView *)aScrollView
{
    if (!_aScrollView) {
        
        self.aScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _aScrollView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _aScrollView;
}

- (void)setupSubViews
{
    [_aScrollView addSubview:self.liveHeaderView];
    
    _scrollViewHeight = _liveHeaderView.frame.size.height + news_Cell_Up_Or_Down_Margin;
    
    [_aScrollView addSubview:self.liveContenLabel];
    
    _scrollViewHeight = _scrollViewHeight+_liveContenLabel.frame.size.height + news_Cell_Up_Or_Down_Margin;
    
    [_aScrollView addSubview:self.authorNameLabel];
    
    _scrollViewHeight = _scrollViewHeight+_authorNameLabel.frame.size.height + news_Cell_Up_Or_Down_Margin*5;

    [_aScrollView addSubview:self.shareBar];
    
    _scrollViewHeight = _scrollViewHeight+_shareBar.frame.size.height+news_Cell_Up_Or_Down_Margin/2;
    
    [_aScrollView addSubview:self.moreNewsView];
    
    _scrollViewHeight = _scrollViewHeight+_moreNewsView.frame.size.height+1;

    _aScrollView.contentSize = CGSizeMake(CBN_Screen_Width, _scrollViewHeight);
    
}


- (CBNLiveDetailHeaderView *)liveHeaderView
{
    if (!_liveHeaderView) {
        
        self.liveHeaderView = [[CBNLiveDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, 0)];
        _liveHeaderView.titleString = _liveModel.liveTitleString;
        _liveHeaderView.authorNameString = _liveModel.liveAuthorNameString;
        _liveHeaderView.timeString = _liveModel.liveTimeString;
    }
    
    return _liveHeaderView;
}

- (UILabel *)liveContenLabel
{
    if (!_liveContenLabel) {
        
        self.liveContenLabel = [[UILabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _scrollViewHeight, CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin, 0)];
        
        _liveContenLabel.font = [UIFont newsContentFont];
        
        _liveContenLabel.dk_textColorPicker = DKColorPickerWithKey(news_Content_Color);
        
        _liveContenLabel.numberOfLines = 0;
//        _liveContenLabel.text = _liveModel.liveContentString;
        NSString *str = @"The Chinese currency has come under pressure after strong US economic data released on Oct. 14 led to growing expectations that the Federal Reserve Bank will increase interest rates. The dollar index hit a seven-month high. A US rate hike remains a critical factor in the yuan-dollar exchange rate over the near term, experts said.";
        
        _liveContenLabel.attributedText =[NSMutableAttributedString setLiveContentAttributeStringWithFont:_liveContenLabel.font string:str];
        [_liveContenLabel sizeToFit];
        
        _liveContenLabel.frame = CGRectMake(_liveContenLabel.frame.origin.x, _liveContenLabel.frame.origin.y, CBN_Screen_Width - 2*news_Cell_Left_Or_Right_Margin, _liveContenLabel.frame.size.height);
        
    }
    return _liveContenLabel;
}

- (UILabel *)authorNameLabel
{
    if (!_authorNameLabel) {
        
        self.authorNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _scrollViewHeight, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, [NSString getTextHeightWithFont:[UIFont tagFont]])];
        
        _authorNameLabel.font = [UIFont tagFont];
        
        _authorNameLabel.dk_textColorPicker = DKColorPickerWithKey(news_Content_Color);
        
        _authorNameLabel.text = [NSString stringWithFormat:@"(%@)",_liveModel.liveAuthorNameString];
        
    }
    
    return _authorNameLabel;
}

- (CBNShareBar *)shareBar
{
    if (!_shareBar) {
        
        self.shareBar = [[CBNShareBar alloc] initWithFrame:CGRectMake(0, _scrollViewHeight, CBN_Screen_Width, search_Bar_Height)];
        
        _shareBar.backgroundColor = [UIColor clearColor];
        
    }
    
    return _shareBar;
}

- (CBNLiveMoreNewsView *)moreNewsView
{
    if (!_moreNewsView) {
        
        self.moreNewsView = [[CBNLiveMoreNewsView alloc] initWithFrame:CGRectMake(0, _scrollViewHeight, CBN_Screen_Width, 200)];
        
        _moreNewsView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _moreNewsView;
}
@end
