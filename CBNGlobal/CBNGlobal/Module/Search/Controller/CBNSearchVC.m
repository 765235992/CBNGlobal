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

#define isitIncludeLowercaseLettersAndNumbers(str) [[NSPredicate predicateWithFormat:@"SELF MATCHES %@"@"<[a-zA-Z]+(s+[a-zA-Z]+s*=s*(\"([^\"]*)\"|'([^']*)'))*s*/>"] evaluateWithObject:str]

@interface CBNSearchVC ()<CBNSearcnViewDelegate,CBNSearchDefaultViewDelegate,CBNSearchResultViewDelegate>
@property (nonatomic, strong) CBNSearcnView *searchView;
@property (nonatomic, strong) CBNSearchDefaultView *defaultView;
@property (nonatomic, strong) CBNSearchResultView *resultView;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSString *currentKeyWord;

@end

@implementation CBNSearchVC
- (void)dealloc
{
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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

    [_searchView removeFromSuperview];

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_searchView removeFromSuperview];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNoBarItems];
    
    [self.view addSubview:self.resultView];
    [self.view addSubview:self.defaultView];
    

}
#pragma mark Request

- (void)loadSearchWithSearchText:(NSString *)searchtext
{
    _currentPage = 0;
    _currentKeyWord = searchtext;

    _defaultView.searchKeywordString = _currentKeyWord;
    
    [CBNSearchRequest loadNewsItemsWithSearchText:searchtext page:_currentPage pageSize:10 Secuessed:^(NSArray *searchReaultArray) {
        
        
        [self.sourceArray removeAllObjects];
        
        for (NSDictionary *dic in searchReaultArray) {
            
            CBNSearchModel *searchModel = [CBNSearchModel mj_objectWithKeyValues:dic];
            
            [_sourceArray addObject:searchModel];
            
        }
        
        _resultView.sourceArray = _sourceArray;
        _currentPage++;
        
    } failed:^(NSError *error) {
        
    }];
}

- (void)loadMoreSearchNews
{
    [CBNSearchRequest loadNewsItemsWithSearchText:_currentKeyWord page:1 pageSize:10 Secuessed:^(NSArray *searchReaultArray) {
        
        
        [self.sourceArray removeAllObjects];

        for (NSDictionary *dic in searchReaultArray) {
            CBNSearchModel *searchModel = [CBNSearchModel mj_objectWithKeyValues:dic];
            
            [_sourceArray addObject:searchModel];
            
        }
        
        _resultView.moreNewsArray = _sourceArray;
        _currentPage++;
        
    } failed:^(NSError *error) {
        
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
