//
//  CBNHomePageHeaderView.h
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBNHomePageHeaderView;
@protocol CBNHomePageHeaderViewDelegate <NSObject>

- (void)homePageHeaderLiveShuffingView:(CBNHomePageHeaderView *)homePageView didSelectedAtIndex:(NSInteger)index;

- (void)homePageHeaderLiveShuffingView:(CBNHomePageHeaderView *)homePageView recommendedNews:(id)news;
@end

@interface CBNHomePageHeaderView : UIView

@property (nonatomic, assign) id <CBNHomePageHeaderViewDelegate> delegate;
@property (nonatomic, strong) CBNNewsModel *remondNewsModel;

@property (nonatomic, strong) NSMutableArray *liveModelArray;
@end
