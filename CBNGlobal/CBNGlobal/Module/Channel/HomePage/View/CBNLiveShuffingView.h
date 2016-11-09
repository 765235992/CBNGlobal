//
//  CBNLiveShuffingView.h
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBNLiveShuffingView;
@protocol CBNLiveShuffingViewDelegate <NSObject>

- (void)liveShuffingView:(CBNLiveShuffingView *)liveShuffingView didSelecteAtIndex:(NSInteger)index;

@end

@interface CBNLiveShuffingView : UIImageView

@property (nonatomic, assign) id <CBNLiveShuffingViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *liveModelArray;

@end
