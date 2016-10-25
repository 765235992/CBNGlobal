//
//  CBNHomePageRecommendedNewsView.h
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNNewsModel.h"

@class CBNHomePageRecommendedNewsView;
@protocol CBNHomePageRecommendedNewsViewDlegate <NSObject>


- (void)homePageRecommendedNewsView:(CBNHomePageRecommendedNewsView *)homePageRecommendedNewsView newsItemModel:(CBNNewsModel *)newsItemModel;

@end

@interface CBNHomePageRecommendedNewsView : UIView

@property (nonatomic, strong) CBNNewsModel *recommendNewsModel;


@property (nonatomic, assign) id <CBNHomePageRecommendedNewsViewDlegate>delegate;

@end
