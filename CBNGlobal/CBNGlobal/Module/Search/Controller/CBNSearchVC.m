//
//  CBNSearchVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearchVC.h"
#import "CBNSearcnView.h"
#import "CBNSearchDefaultView.h"
#import "CBNSearchResultView.h"
#import "CBNSearchRequest.h"
#import "CBNSearchModel.h"
#import "CBNSearchSqliteManager.h"
#import "CBNLoadingView.h"
#import "CBNNetPromptView.h"

#define isitIncludeLowercaseLettersAndNumbers(str) [[NSPredicate predicateWithFormat:@"SELF MATCHES %@"@"<[a-zA-Z]+(s+[a-zA-Z]+s*=s*(\"([^\"]*)\"|'([^']*)'))*s*/>"] evaluateWithObject:str]

@interface CBNSearchVC ()<CBNSearcnViewDelegate,CBNSearchDefaultViewDelegate,CBNSearchResultViewDelegate>
@property (nonatomic, strong) CBNSearcnView *searchView;
@property (nonatomic, strong) CBNSearchDefaultView *defaultView;
@property (nonatomic, strong) CBNSearchResultView *resultView;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSString *currentKeyWord;
@property (nonatomic, strong) CBNLoadingView *loadingView;
@property (nonatomic, assign) BOOL isHaveNoNetwork;
@property (nonatomic, strong) CBNNetPromptView *netPromptView;

@end

@implementation CBNSearchVC
- (void)dealloc
{
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:@"networkState" object:nil];

    [self.navigationController.navigationBar addSubview:self.searchView];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _searchView.hidden = NO;

    [self.navigationController.navigationBar addSubview:self.searchView];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _searchView.hidden = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"networkState" object:nil];

    [_searchView removeFromSuperview];

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_searchView removeFromSuperview];

}
- (CBNLoadingView *)loadingView
{
    if (!_loadingView) {
        
        self.loadingView = [[CBNLoadingView alloc] initWithFrame:self.view.bounds];
    }
    
    return _loadingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNoBarItems];
    self.isHaveNoNetwork = YES;

    [self.view addSubview:self.resultView];
    [self.view addSubview:self.defaultView];
    [self.view addSubview:self.loadingView];
    _loadingView.hidden = YES;
    [self.view addSubview:self.netPromptView];
    

}
- (void)netWorkChangedWithNetWorkState:(BOOL)currentNetworkState
{
    if ( currentNetworkState == YES && self.isHaveNoNetwork == YES) {
        
    }else{
        [self.view bringSubviewToFront:self.netPromptView];
        
        if (currentNetworkState == YES && self.isHaveNoNetwork == NO) {
            
            self.isHaveNoNetwork = YES;
            [_netPromptView networkStateIsNormal];
            
            //            [self networkNormal];
            
            
        }else if (self.isHaveNoNetwork == YES && currentNetworkState == NO){
            self.isHaveNoNetwork = NO;
            [_netPromptView networkStatusIsAbnormal];
            
        }
        
    }
    
}

- (void)networkChanged:(NSNotification *)notification{
    
    NSDictionary *dic = notification.userInfo;
    
    BOOL currentNetworkState = [[dic objectForKey:@"isHavenetwork"] boolValue];
    [self netWorkChangedWithNetWorkState:currentNetworkState];
    
    //    if (isHaveNetwork == NO && self.isHaveNoNetwork == NO) {
    //        self.isHaveNoNetwork = YES;
    //        [_netPromptView networkStatusIsAbnormal];
    //
    //
    //    }
    //    if (self.isHaveNoNetwork == YES && isHaveNetwork == YES) {
    //        self.isHaveNoNetwork = NO;
    //        [_netPromptView networkStateIsNormal];
    //    }
    
    
    
    
    //    _leftChannelVC.currentNetWorkState = isHaveNetwork;
    //
    //    if (isHaveNetwork == YES) {
    //        
    //        [self requestChannelItem];
    //        
    //    }
}
- (CBNNetPromptView *)netPromptView
{
    if (!_netPromptView) {
        
        self.netPromptView = [[CBNNetPromptView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, 35)];
        
        _netPromptView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _netPromptView;
}

#pragma mark Request

- (void)loadSearchWithSearchText:(NSString *)searchtext
{
    _loadingView.hidden = NO;
    
    _currentPage = 0;
    _currentKeyWord = searchtext;

    _defaultView.searchKeywordString = _currentKeyWord;

    [CBNSearchRequest loadNewsItemsWithSearchText:searchtext page:_currentPage pageSize:10 Secuessed:^(NSArray *searchReaultArray) {
        
        [self.sourceArray removeAllObjects];
        
        _loadingView.hidden = YES;

        for (NSDictionary *dic in searchReaultArray) {
            
            CBNSearchModel *searchModel = [CBNSearchModel mj_objectWithKeyValues:dic];
            
            [_sourceArray addObject:searchModel];
            
        }
        
        _resultView.sourceArray = _sourceArray;
        
        _currentPage++;
        
    } failed:^(NSError *error) {
        
        [_loadingView loadingFailed];
        
    }];
}

- (void)loadMoreSearchNews
{
    
    [CBNSearchRequest loadNewsItemsWithSearchText:_currentKeyWord page:_currentPage pageSize:10 Secuessed:^(NSArray *searchReaultArray) {
        
        
        [self.sourceArray removeAllObjects];

        for (NSDictionary *dic in searchReaultArray) {
            CBNSearchModel *searchModel = [CBNSearchModel mj_objectWithKeyValues:dic];
            
            [_sourceArray addObject:searchModel];
            
        }
        
        _resultView.moreNewsArray = _sourceArray;
        _currentPage++;
        
    } failed:^(NSError *error) {
        _resultView.refreshFiaied = YES;
    }];

}

#pragma mark CBNSearcnViewDelegate

- (void)searchView:(CBNSearcnView *)searcnView cancleButtonClicked:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)searchView:(CBNSearcnView *)searcnView searchText:(NSString *)searchText
{

    [self loadSearchWithSearchText:searchText];
    [self.view bringSubviewToFront:_loadingView];

}

- (void)searchView:(CBNSearcnView *)searchView BeginEdit:(BOOL)beginEdit
{
    [self.view bringSubviewToFront:_resultView];
}
- (void)searchView:(CBNSearcnView *)searchView cancleEdit:(BOOL)cancleEdit
{
    [self.view bringSubviewToFront:_defaultView];

}

#pragma mark CBNSearchDefaultViewDelegate

- (void)searchDefaultView:(CBNSearchDefaultView *)searchDefaultView channelDidSelectedAtIndex:(NSInteger)index
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    if (index > 100) {
        return;
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:index],@"channelIndex", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"channelChanged" object:nil userInfo:dic];
    
}
- (void)historySearchText:(NSString *)searText
{
    [self loadSearchWithSearchText:searText];
    [self.view bringSubviewToFront:_resultView];
    [self.view bringSubviewToFront:_loadingView];

    
}

#pragma mark create_Object

- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        
        self.sourceArray = [[NSMutableArray alloc] init];
    }
    
    return _sourceArray;
}
- (CBNSearcnView *)searchView
{
    if (!_searchView) {
        
        self.searchView = [[CBNSearcnView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, 44)];
        _searchView.backgroundColor = [UIColor clearColor];
        
        _searchView.delegate = self;
    }
    
    return _searchView;
}

- (CBNSearchDefaultView *)defaultView
{
    if (!_defaultView) {
        
        self.defaultView = [[CBNSearchDefaultView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height-64) andCurrentChannelName:self.channelName];
        
        _defaultView.delegate = self;
        
    }
    
    return _defaultView;
}

- (CBNSearchResultView *)resultView
{
    if (!_resultView) {
        
        self.resultView = [[CBNSearchResultView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height-64)];
        _resultView.delegate = self;
    }
    
    return _resultView;
}
- (void)tableViewSelectedWithNewsModel:(CBNNewsModel *)newsModel
{
    [self pushToTextNewsDetailWitNewsID:newsModel.NewsID withChannelName:@"Search"];
    
}

- (void)loadMoreNews
{
    [self loadMoreSearchNews];
    
}

@end
