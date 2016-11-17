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
#import "CBNLoadingView.h"
#import "JYShareManager.h"
@interface CBNTextDetailVC ()<CBNBaseDetailMoreNewsViewDelegate,UIScrollViewDelegate,CBNShareBarDelegate>
@property (nonatomic, assign) CGFloat scrollViewHeight;

@property (nonatomic, strong) UIScrollView *aScrollView;

@property (nonatomic, strong) CBNTextDetailHeaderView *headerView;

@property (nonatomic, strong) CBNTextView *contentTextView;

@property (nonatomic, strong) CBNShareBar *shareBar;

@property (nonatomic, strong) CBNTextMoreNewsView *moreNewsView;

@property (nonatomic, strong) CBNNewsDetailModel *newsDetailModel;

@property (nonatomic, strong) CBNLoadingView *loadingView;

@end

@implementation CBNTextDetailVC
- (void)dealloc
{
    NSLog(@"新闻详情释放");
    [[JYShareManager shareManager] stopShare];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    (lsna)
    [self setBackBarButtonItem];
    [self setNavigationTitle:@""];
    [self setShareBarButtonItem];
    
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(defaule_Background_Color);
    
    _scrollViewHeight = 0.0;
    
    [self.view addSubview:self.aScrollView];
    
    [self.view addSubview:self.loadingView];
    [_loadingView startLoading];
    
    
}
- (void)setNewsID:(NSInteger)newsID
{
    
    _newsID = newsID;
    
    [[CBNNewsDetailAction sharedManager] loadNewsDatetailWithNewsID:_newsID secuessed:^(CBNNewsDetailModel *newsDetailModel) {
        _newsDetailModel = newsDetailModel;
        
        [self setupSubViews];

    } failed:^(NSError *error) {

        [_loadingView loadingFailed];

    }];

}

- (void)setupSubViews
{
    
    [_aScrollView addSubview:self.headerView];
    _headerView.newsDetailModel = _newsDetailModel;
     
    _scrollViewHeight = _scrollViewHeight+_headerView.frame.size.height + news_Cell_Up_Or_Down_Margin*0.5;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        NSAttributedString *attributeString = [[NSAttributedString alloc] initWithData:[[NSString getHtmlStringWithPString:_newsDetailModel.NewsBody] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_loadingView loadingSecuessed];
            
            if (_aScrollView==nil) {
                return ;
            }
            [_aScrollView addSubview:self.contentTextView];
            
            
            _contentTextView.attText =(NSMutableAttributedString *)attributeString;

            _scrollViewHeight = _scrollViewHeight+_contentTextView.frame.size.height+news_Cell_Up_Or_Down_Margin*3;
            
            [_aScrollView addSubview:self.shareBar];
            
            _scrollViewHeight = _scrollViewHeight+_shareBar.frame.size.height+news_Cell_Up_Or_Down_Margin/2;
            
            _aScrollView.contentSize = CGSizeMake(CBN_Screen_Width, _scrollViewHeight);

            [self loadMoreNews];
            
            _contentTextView.backgroundColor = [UIColor redColor];

            
        });
        
    });
    
}

- (UIScrollView *)aScrollView
{
    if (!_aScrollView) {
        
        self.aScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height-64)];
        
        _aScrollView.delegate = self;
        
        _aScrollView.dk_backgroundColorPicker = DKColorPickerWithKey(defaule_Background_Color);

        
    }
    
    return _aScrollView;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.shareView.hidden == NO) {
        
        self.shareView.hidden = YES;
        
        if (self.shareButton.selected == YES) {
            
            self.shareButton.selected = NO;

        }else{
            
            self.shareButton.selected = YES;;

        }
    }
}

- (CBNTextDetailHeaderView *)headerView
{
    if (!_headerView) {
        
        self.headerView = [[CBNTextDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, 200)];
        
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
        _shareBar.delegate = self;
        
    }
    
    return _shareBar;
}
- (void)shareBar:(CBNShareBar *)shareBar shareType:(CBNShareType)shareType
{
    [self sharePlateFromTag:shareType];
    
}

- (void)sharePlateFromTag:(NSInteger)tag
{
    [[JYShareManager shareManager] shareNewsWithNewsID:[NSString stringWithFormat:@"%ld",(long)_newsID] newsTitle:_newsDetailModel.NewsTitle newsContent:_newsDetailModel.NewsNotes newsImageURL:[[CBNParametersLinkManager sharedManager] getOriginalNewsThumbName:_newsDetailModel.NewsThumbs]newsType:JYShareType_Web platformType:tag andViewController:self];
    if (self.shareView.hidden == NO) {
        
        self.shareView.hidden = YES;
        
        if (self.shareButton.selected == YES) {
            
            self.shareButton.selected = NO;
            
        }else{
            
            self.shareButton.selected = YES;;
            
        }
    }

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

- (CBNLoadingView *)loadingView
{
    if (!_loadingView) {
        
        self.loadingView = [[CBNLoadingView alloc] initWithFrame:self.view.bounds];
    }
    
    return _loadingView;
}
@end
