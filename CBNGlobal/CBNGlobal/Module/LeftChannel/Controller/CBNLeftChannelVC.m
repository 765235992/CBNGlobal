//
//  CBNLeftChannelVC.m
//  CBNGlobal
//
//  Created by Jone on 16/10/15.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLeftChannelVC.h"
#import "CBNLeftChannelCell.h"
#import "CBNFileManager.h"
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aaa) name:@"123321" object:nil];

    [self.sourceArray removeAllObjects];
    
    NSArray *arr = [[CBNChannelDao sharedManager] queryChannelDataWithTableName:@"ChannelList"];
    NSLog(@"%@",arr);
    
    [_sourceArray addObjectsFromArray:arr];
    [self.view addSubview:self.aTableView];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [_aTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];

}
- (NSMutableArray *)sourceArray
{
    if (!_sourceArray) {
        
        self.sourceArray = [[NSMutableArray alloc] init];
        
    }
    
    return _sourceArray;
}
- (void)setChannelArray:(NSArray *)channelArray
{
    _channelArray = channelArray;
    
    [_sourceArray removeAllObjects];
    
    [_sourceArray addObjectsFromArray:_channelArray];
    
    [_aTableView reloadData];
    
}
- (void)aaa{
    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
    
    [_aTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
//    [self publiChannel];

}
/**
 *  @创建视图
 */
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceArray.count;
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
    return 2*[NSString getTextHeightWithFont:[UIFont newsTitleFont]];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _currentIndex) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

        return;
    }else{
        _currentIndex = indexPath.row;
    }
    CBNChannelMoel *channelModel = [_sourceArray objectAtIndex:indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            [self homeChannel];
            break;
        case 1:
  
            
        default:
            [self publiChannelWithChannelModel:channelModel];

            break;
    }


}
- (void)homeChannel
{

    CBNHomePageVC *homeChangeVC = [[CBNHomePageVC alloc] init];
    
    CBNChannelNavigationController *navigation = [[CBNChannelNavigationController alloc] initWithRootViewController:homeChangeVC];
    
    [self.mm_drawerController setCenterViewController:navigation withCloseAnimation:YES completion:^(BOOL finished) {
        
    }];

}

- (void)publiChannelWithChannelModel:(CBNChannelMoel *)channelModel
{
    CBNPublicChannelVC *publicChannel = [[CBNPublicChannelVC alloc] init];
    publicChannel.channelModel = channelModel;
    CBNChannelNavigationController *navigation = [[CBNChannelNavigationController alloc] initWithRootViewController:publicChannel];
    [self.mm_drawerController setCenterViewController:navigation withCloseAnimation:YES completion:^(BOOL finished) {
        
    }];
 
}



@end
