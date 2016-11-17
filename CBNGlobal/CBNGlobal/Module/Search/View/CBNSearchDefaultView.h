//
//  CBNSearchDefaultView.h
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNSearchChannelView.h"
@class CBNSearchDefaultView;
@protocol CBNSearchDefaultViewDelegate <NSObject>

- (void)searchDefaultView:(CBNSearchDefaultView *)searchDefaultView channelDidSelectedAtIndex:(NSInteger)index;

- (void)historySearchText:(NSString *)searText;
@end

@interface CBNSearchDefaultView : UIView

@property (nonatomic, strong) NSString *searchKeywordString;
@property (nonatomic, assign) id <CBNSearchDefaultViewDelegate> delegate;
@end
