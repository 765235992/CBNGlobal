
//  CBNLiveShuffingView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLiveShuffingView.h"
#import <JYLiveShuffingSDK/JYLiveShuffingSDK.h>

@interface CBNLiveShuffingView ()<JYLiveScrollViewDelegate>
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
        _liveScrollView.delegate = self;
        
        
        NSArray *liveArr = [[CBNNewSqliteManager sharedManager] selectObjectsfromTable:@"Live"];
        
        NSArray *liveNewsArray = [CBNNewSqliteManager liveDictionaryChanegeToLiveModekWithDictionaryArray:liveArr];
        if (liveNewsArray.count > 0) {
            NSMutableArray *result = [[NSMutableArray alloc] init];

            for (CBNLiveModel *livemodel in liveNewsArray) {
                JYLiveShuffingModel *tempModel = [[JYLiveShuffingModel alloc] init];
                tempModel.newsTitleString = livemodel.newsModel.NewsTitle;
                tempModel.newsUpdataTimeString =  livemodel.newsModel.LastDate;
                [result addObject:tempModel];
                
            }
            [_liveScrollView refreshLiveNewsWithLiveShuffingModelArray:result];

        }else{
            NSArray *arr = @[@"  ",@"  "];
            NSArray *timeArr = @[@"  ",@"  "];
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for (int i = 0; i < arr.count; i++) {
                JYLiveShuffingModel *tempModel = [[JYLiveShuffingModel alloc] init];
                tempModel.newsTitleString = [arr objectAtIndex:i];
                tempModel.newsUpdataTimeString = [timeArr objectAtIndex:i];
                [result addObject:tempModel];
            }
            [_liveScrollView refreshLiveNewsWithLiveShuffingModelArray:result];

        }
        
    }
    
    return _liveScrollView;
}

- (void)setLiveModelArray:(NSMutableArray *)liveModelArray
{
    _liveModelArray = liveModelArray;
    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (CBNLiveModel *liveModel in _liveModelArray) {
        JYLiveShuffingModel *tempModel = [[JYLiveShuffingModel alloc] init];
        tempModel.newsTitleString = liveModel.newsModel.NewsTitle;
        tempModel.newsUpdataTimeString =  [NSDate getHourDateFromUTCDateString:liveModel.newsModel.LastDate];
        [result addObject:tempModel];

    }
    [_liveScrollView refreshLiveNewsWithLiveShuffingModelArray:result];

}

-(void)didSelectedWithLiveShuffingModel:(JYLiveShuffingModel *)model index:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(liveShuffingView:didSelecteAtIndex:)]) {
        [self.delegate liveShuffingView:self didSelecteAtIndex:index];
        
    }
}

@end
