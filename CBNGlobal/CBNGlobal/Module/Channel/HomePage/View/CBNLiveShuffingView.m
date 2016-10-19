//
//  CBNLiveShuffingView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLiveShuffingView.h"
#import <JYLiveShuffingSDK/JYLiveShuffingSDK.h>

@interface CBNLiveShuffingView ()
@property (nonatomic, strong) JYLiveScrollView *liveScrollView;

@end

@implementation CBNLiveShuffingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.liveScrollView];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _liveScrollView.frame.size.height);
        
    }
    return self;
}
- (JYLiveScrollView *)liveScrollView
{
    if (!_liveScrollView) {
        
        self.liveScrollView = [[JYLiveScrollView alloc] initWithFrame:self.bounds];
        _liveScrollView.AutoScrollDelay = 3;
        
        NSArray *arr = @[@"World’s Movies Can Find Opportunities in China",@"Make in India: Finding The Right Balance",@"Philippine President Starts Four-Day State Visit to China Accompanied by 300 Businessmen"];
        NSArray *timeArr = @[@"00:12",@"12:59",@"17:21",@"00:12",@"12:59",@"17:21",@"00:12",@"12:59",@"17:21"];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (int i = 0; i < arr.count; i++) {
            JYLiveShuffingModel *tempModel = [[JYLiveShuffingModel alloc] init];
            tempModel.newsTitleString = [arr objectAtIndex:i];
            tempModel.newsUpdataTimeString = [timeArr objectAtIndex:i];
            [result addObject:tempModel];
        }
        [_liveScrollView refreshLiveNewsWithLiveShuffingModelArray:result];
        
    }
    
    return _liveScrollView;
}

@end
