//
//  CBNLeftChannelVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/15.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLeftChannelVC.h"
#import "CBNLeftChannelCell.h"
#import "CBNHomePageVC.h"
#import "CBNPublicChannelVC.h"
#import "CBNChannelNavigationController.h"

NSString * const CBNChannelChanged = @"CBNChannelChanged";

@interface CBNLeftChannelVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, assign) NSInteger currentIndex;;

@end

@implementation CBNLeftChannelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _currentIndex = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(channelChanged:) name:@"channelChanged" object:nil];
 

    [self.sourceArray removeAllObjects];
    
    CBNChannelModel *homeChannelModel = [[CBNChannelModel alloc] init];
    homeChannelModel.ChannelName = @"Home";

    homeChannelModel.EnglishName = @"Home";

    [self.sourceArray addObject:homeChannelModel];
    
    NSArray *channelList = [[CBNChannelSqliteManager sharedManager] selectObjectsfromTable:@"ChannelList"];
    
    [_sourceArray addObjectsFromArray:[[CBNChannelSqliteManager sharedManager]dictionaryChangeToModelWithDictionaryArray:channelList] ];
    
    [self.view addSubview:self.aTableView];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_aTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];

}
#pragma mark NSNotification

- (void)channelChanged:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    NSInteger  index = [[userInfo objectForKey:@"channelIndex"] integerValue];
    [self channelChangedWithIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    [_aTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];

    
}

#pragma mark UITableViewDataSource_And_UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentefier = @"CBNLeftChannelCell";
    
    
    CBNLeftChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:indentefier];
    
    if (cell == nil) {
        
        cell = [[CBNLeftChannelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentefier];
        
    }
    
    
    cell.channelModel = [_sourceArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2.5*[NSString getTextHeightWithFont:[UIFont newsTitleFont]];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self channelChangedWithIndex:indexPath.row];
}

- (void)channelChangedWithIndex:(NSInteger)index
{
    if (index == _currentIndex) {
        
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        
        return;
        
    }else{
        
        _currentIndex = index;
        
    }
    
    CBNChannelModel *channelModel = [_sourceArray objectAtIndex:index];
    
    switch (index) {
        case 0:
            
            [self homeChannel];
            
            break;
        case 1:
            
            
        default:
            [self publiChannelWithChannelModel:channelModel];
            
            break;
    }
    

}
/*
 *  切换为主频道
 */
- (void)homeChannel
{

    CBNHomePageVC *homeChangeVC = [[CBNHomePageVC alloc] init];
    
    CBNChannelNavigationController *navigation = [[CBNChannelNavigationController alloc] initWithRootViewController:homeChangeVC];
    
    [self.mm_drawerController setCenterViewController:navigation withCloseAnimation:YES completion:^(BOOL finished) {
        
    }];

}
/*
 *  切换为主公共频道
 */
- (void)publiChannelWithChannelModel:(CBNChannelModel *)channelModel
{
    
    CBNPublicChannelVC *publicChannel = [[CBNPublicChannelVC alloc] init];
    
    publicChannel.channelModel = channelModel;
    
    CBNChannelNavigationController *navigation = [[CBNChannelNavigationController alloc] initWithRootViewController:publicChannel];
    
    [self.mm_drawerController setCenterViewController:navigation withCloseAnimation:YES completion:^(BOOL finished) {
        
    }];
 
}
#pragma mark reset
- (void)setChannelArray:(NSArray *)channelArray
{
    _channelArray = channelArray;
    
    [_sourceArray removeAllObjects];
    
    CBNChannelModel *homeChannelModel = [[CBNChannelModel alloc] init];
    
    homeChannelModel.EnglishName = @"Home";
    homeChannelModel.ChannelName = @"Home";

    [self.sourceArray addObject:homeChannelModel];
    
    [_sourceArray addObjectsFromArray:_channelArray];
    
    [_aTableView reloadData];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_aTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
    
}


#pragma mark create_Object

- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        
        self.sourceArray = [[NSMutableArray alloc] init];
        
    }
    
    return _sourceArray;
}
- (UITableView *)aTableView
{
    if (!_aTableView) {
        
        self.aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, user_Draw_open_With, CBN_Screen_Height-108)];
        
        _aTableView.backgroundColor = [UIColor blackColor];
        
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _aTableView.delegate = self;
        
        _aTableView.dataSource = self;
        
    }
    
    return _aTableView;
}

@end
