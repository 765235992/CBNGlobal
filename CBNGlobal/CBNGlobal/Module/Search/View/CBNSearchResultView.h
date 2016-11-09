//
//  CBNSearchResultView.h
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBNSearchResultView;
@protocol CBNSearchResultViewDelegate <NSObject>

- (void)tableViewSelectedWithNewsModel:(CBNNewsModel *)newsModel;

- (void)loadMoreNews;

@end

@interface CBNSearchResultView : UIView

@property (nonatomic, assign) id <CBNSearchResultViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@property (nonatomic, strong) NSMutableArray *moreNewsArray;
@end
