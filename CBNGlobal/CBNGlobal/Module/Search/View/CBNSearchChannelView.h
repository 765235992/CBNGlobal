//
//  CBNSearchChannelView.h
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBNSearchChannelView;

@protocol CBNSearchChannelViewDelegate <NSObject>

- (void)searchChannelView:(CBNSearchChannelView *)searchChannelView didSelectedAtIndex:(NSInteger)index;

@end

@interface CBNSearchChannelView : UIView
- (id)initWithFrame:(CGRect)frame andCurrentChannelName:(NSString *)currentChannelName;
@property (nonatomic, assign) id <CBNSearchChannelViewDelegate> delegate;
@end
