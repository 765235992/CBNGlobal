//
//  CBNSearcnView.h
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBNSearcnView;

@protocol CBNSearcnViewDelegate <NSObject>
- (void)searchView:(CBNSearcnView *)searchView BeginEdit:(BOOL)beginEdit;
- (void)searchView:(CBNSearcnView *)searchView cancleEdit:(BOOL)cancleEdit;
- (void)searchView:(CBNSearcnView *)searcnView cancleButtonClicked:(UIButton *)sender;
- (void)searchView:(CBNSearcnView *)searcnView searchText:(NSString *)searchText;

@end

@interface CBNSearcnView : UIView

@property (nonatomic, assign) id <CBNSearcnViewDelegate> delegate;

@end
