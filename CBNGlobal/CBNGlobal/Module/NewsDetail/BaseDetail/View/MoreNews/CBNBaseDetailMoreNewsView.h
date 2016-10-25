//
//  CBNBaseDetailMoreNewsView.h
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBNBaseDetailMoreNewsView;
@protocol CBNBaseDetailMoreNewsViewDelegate <NSObject>

- (void)moreNewsView:(CBNBaseDetailMoreNewsView *)moreNewsView selectedAtIndex:(NSInteger)index;

@end

@interface CBNBaseDetailMoreNewsView : UIView

@property (nonatomic, assign) id <CBNBaseDetailMoreNewsViewDelegate>delegate;

@property (nonatomic, strong) NSArray *moreNewsArray;
@end
