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
#import "CBNTextMoreNewsView.h"
#import "CBNTextView.h"
#import "CBNNewsDetailAction.h"
#import "CBNMoreNewsModel.h"

@interface CBNTextDetailVC ()<CBNBaseDetailMoreNewsViewDelegate>
@property (nonatomic, assign) CGFloat scrollViewHeight;

@property (nonatomic, strong) UIScrollView *aScrollView;

@property (nonatomic, strong) CBNTextDetailHeaderView *headerView;

@property (nonatomic, strong) CBNTextView *contentTextView;

@property (nonatomic, strong) CBNShareBar *shareBar;

@property (nonatomic, strong) CBNTextMoreNewsView *moreNewsView;

@property (nonatomic, strong) CBNNewsDetailModel *newsDetailModel;
@end

@implementation CBNTextDetailVC
- (void)dealloc
{
    CBNLog(@"新闻详情释放");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButtonItem];
    [self setNavigationTitle:@""];
    [self setShareBarButtonItem];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollViewHeight = 0.0;
    
    [self.view addSubview:self.aScrollView];
    
}
- (void)setNewsID:(NSInteger)newsID
{
    _newsID = newsID;
    
    [CBNNewsDetailAction loadNewsDatetailWithNewsID:_newsID secuessed:^(CBNNewsDetailModel *newsDetailModel) {
        _newsDetailModel = newsDetailModel;
        
        [self setupSubViews];
    } failed:^(NSError *error) {
        
    }];

}

- (void)setupSubViews
{
    
    [_aScrollView addSubview:self.headerView];
    _headerView.newsDetailModel = _newsDetailModel;
     
    _scrollViewHeight = _scrollViewHeight+_headerView.frame.size.height + news_Cell_Up_Or_Down_Margin*0.5;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithData:[[NSString getHtmlStringWithPString:_newsDetailModel.NewsBody] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:attributeString];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_aScrollView addSubview:self.contentTextView];
            _contentTextView.attText =attr;

            _scrollViewHeight = _scrollViewHeight+_contentTextView.frame.size.height+news_Cell_Up_Or_Down_Margin*3;
            
            [_aScrollView addSubview:self.shareBar];
            
            _scrollViewHeight = _scrollViewHeight+_shareBar.frame.size.height+news_Cell_Up_Or_Down_Margin/2;
            
       
            
            _aScrollView.contentSize = CGSizeMake(CBN_Screen_Width, _scrollViewHeight);

            [self loadMoreNews];
            
        });
        
    });
    
}

- (UIScrollView *)aScrollView
{
    if (!_aScrollView) {
        
        self.aScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height-64)];
        
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

- (CBNTextMoreNewsView *)moreNewsView
{
    if (!_moreNewsView) {
        
        self.moreNewsView = [[CBNTextMoreNewsView alloc] initWithFrame:CGRectMake(0, _scrollViewHeight, CBN_Screen_Width, 200)];
        _moreNewsView.delegate = self;
        
        _moreNewsView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _moreNewsView;
}

- (void)loadMoreNews
{
    [CBNNewsDetailAction loadMoreNewssecuessed:^(NSArray *moreNewsArray) {
        
        [_aScrollView addSubview:self.moreNewsView];

        _moreNewsView.moreNewsArray = moreNewsArray;
        
        _scrollViewHeight = _scrollViewHeight+_moreNewsView.frame.size.height+1;
    
        _aScrollView.contentSize = CGSizeMake(CBN_Screen_Width, _scrollViewHeight);

    } failed:^(NSError *error) {
        _scrollViewHeight = _scrollViewHeight + 40;
        
        _aScrollView.contentSize = CGSizeMake(CBN_Screen_Width, _scrollViewHeight);
    }];
    
}
- (void)moreNewsView:(CBNBaseDetailMoreNewsView *)moreNewsView selectedAtIndex:(NSInteger)index
{
    CBNMoreNewsModel *temp = [moreNewsView.moreNewsArray objectAtIndex:index];
    [self pushToTextNewsDetailWitNewsID:[temp.NewsID integerValue]];
}

@end
