//
//  CBNSearchField.h
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBNSearchField;
@protocol CBNSearchFieldDelegate <NSObject>

- (void)textField:(CBNSearchField *)textField resultString:(NSString *)resultString;

- (void)textField:(CBNSearchField *)textField BeginEdit:(BOOL)beginEdit;

- (void)textField:(CBNSearchField *)textField cancleEdit:(BOOL)cancleEdit;

@end

@interface CBNSearchField : UIView

@property (nonatomic, assign) id <CBNSearchFieldDelegate> delegate;

@end
