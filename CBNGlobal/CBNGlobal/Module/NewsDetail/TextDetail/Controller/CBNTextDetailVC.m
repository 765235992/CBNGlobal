//
//  CBNTextDetailVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNTextDetailVC.h"
#import "CBNTextDetailHeaderView.h"
#import "CBNShareBar.h"
#import "CBNTextMoreNewsVie.h"
#import "CBNTextView.h"

@interface CBNTextDetailVC ()
@property (nonatomic, assign) CGFloat scrollViewHeight;

@property (nonatomic, strong) UIScrollView *aScrollView;

@property (nonatomic, strong) CBNTextDetailHeaderView *headerView;

@property (nonatomic, strong) CBNTextView *contentTextView;

@property (nonatomic, strong) CBNShareBar *shareBar;

@property (nonatomic, strong) CBNTextMoreNewsVie *moreNewsView;


@end

@implementation CBNTextDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollViewHeight = 0.0;
    
    [self.view addSubview:self.aScrollView];
    
    [self setupSubViews];

}

- (void)setupSubViews
{
    [_aScrollView addSubview:self.headerView];
    
    _scrollViewHeight = _scrollViewHeight+_headerView.frame.size.height + news_Cell_Up_Or_Down_Margin;
    
    [_aScrollView addSubview:self.contentTextView];
    
    _scrollViewHeight = _scrollViewHeight+_contentTextView.frame.size.height+news_Cell_Up_Or_Down_Margin*3;

    [_aScrollView addSubview:self.shareBar];
    
    _scrollViewHeight = _scrollViewHeight+_shareBar.frame.size.height+news_Cell_Up_Or_Down_Margin/2;
    
    [_aScrollView addSubview:self.moreNewsView];
    
    _scrollViewHeight = _scrollViewHeight+_moreNewsView.frame.size.height+1;
    
    _aScrollView.contentSize = CGSizeMake(CBN_Screen_Width, _scrollViewHeight);

    
}

- (UIScrollView *)aScrollView
{
    if (!_aScrollView) {
        
        self.aScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _aScrollView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _aScrollView;
}


- (CBNTextDetailHeaderView *)headerView
{
    if (!_headerView) {
        
        self.headerView = [[CBNTextDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, 200)];
        
        _headerView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _headerView;
}

- (CBNTextView *)contentTextView
{
    if (!_contentTextView) {
        
        self.contentTextView = [[CBNTextView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin/2, _scrollViewHeight, CBN_Screen_Width - news_Cell_Left_Or_Right_Margin, 0)];
        _contentTextView.backgroundColor = [UIColor clearColor];
    }
    
    return _contentTextView;
}


- (CBNShareBar *)shareBar
{
    if (!_shareBar) {
        
        self.shareBar = [[CBNShareBar alloc] initWithFrame:CGRectMake(0, _scrollViewHeight, CBN_Screen_Width, search_Bar_Height)];
        
        _shareBar.backgroundColor = [UIColor clearColor];
        
    }
    
    return _shareBar;
}

- (CBNTextMoreNewsVie *)moreNewsView
{
    if (!_moreNewsView) {
        
        self.moreNewsView = [[CBNTextMoreNewsVie alloc] initWithFrame:CGRectMake(0, _scrollViewHeight, CBN_Screen_Width, 200)];
        
        _moreNewsView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _moreNewsView;
}

@end
