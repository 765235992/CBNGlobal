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

@interface CBNSearchVC ()<CBNSearcnViewDelegate>
@property (nonatomic, strong) CBNSearcnView *searchView;
@property (nonatomic, strong) CBNSearchDefaultView *defaultView;
@property (nonatomic, strong) CBNSearchResultView *resultView;
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
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchView removeFromSuperview];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNoBarItems];
    [self.view addSubview:self.resultView];
    [self.view addSubview:self.defaultView];

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

- (void)searchView:(CBNSearcnView *)searcnView cancleButtonClicked:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)searchView:(CBNSearcnView *)searcnView searchText:(NSString *)searchText
{
    NSLog(@"%@",searchText);
}

- (void)searchView:(CBNSearcnView *)searchView BeginEdit:(BOOL)beginEdit
{
    [self.view bringSubviewToFront:_resultView];
}
- (void)searchView:(CBNSearcnView *)searchView cancleEdit:(BOOL)cancleEdit
{
    [self.view bringSubviewToFront:_defaultView];

}
- (CBNSearchDefaultView *)defaultView
{
    if (!_defaultView) {
        
        self.defaultView = [[CBNSearchDefaultView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height-64)];
        
        _defaultView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _defaultView;
}
- (CBNSearchResultView *)resultView
{
    if (!_resultView) {
        
        self.resultView = [[CBNSearchResultView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height-60)];
        
        _resultView.backgroundColor = [UIColor greenColor];
    }
    
    return _resultView;
}
@end
