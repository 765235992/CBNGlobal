//
//  CBNHomePageVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/15.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNHomePageVC.h"
#import "CBNFileManager.h"
#import "CBNChannelNewsTextCell.h"
#import "CBNHomePageHeaderView.h"
#import "CBNLiveVC.h"
#import "CBNTextDetailVC.h"


@interface CBNHomePageVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) CBNHomePageHeaderView *tableViewHeaderView;


@end

@implementation CBNHomePageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sourceArray = [[NSMutableArray alloc] init];
    for (NSString * familyName in [UIFont familyNames]) {
        
        
        
        
        for (NSString * fontName in [UIFont fontNamesForFamilyName:familyName]) {
            [_sourceArray addObject:fontName];
        }
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.aTableView];
    
    _aTableView.tableHeaderView = self.tableViewHeaderView;
}
/**
 *  @创建视图
 */
- (UITableView *)aTableView
{
    if (!_aTableView) {
        
        self.aTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        
        _aTableView.backgroundColor = [UIColor whiteColor];
        
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _aTableView.delegate = self;
        
        _aTableView.dataSource = self;
    }
    
    return _aTableView;
}
- (CBNHomePageHeaderView *)tableViewHeaderView
{
    if (!_tableViewHeaderView) {
        
        self.tableViewHeaderView = [[CBNHomePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Width)];
        _aTableView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aaa)];
        [_tableViewHeaderView addGestureRecognizer:tap];
        
    }
    
    return _tableViewHeaderView;
}
- (void)aaa
{
    CBNLiveVC *liveVC = [[CBNLiveVC alloc] init];
    
    [self.navigationController pushViewController:liveVC animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentefier = @"CBNChannelNewsTextCell";
    
    
    CBNChannelNewsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:indentefier];
    
    if (cell == nil) {
        
        cell = [[CBNChannelNewsTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentefier];
        
    }
    
    cell.fontName = [_sourceArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return news_Cell_Height;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CBNTextDetailVC *textDetailVC = [[CBNTextDetailVC alloc] init];
    
    [self.navigationController pushViewController:textDetailVC animated:YES];
    
}

@end
