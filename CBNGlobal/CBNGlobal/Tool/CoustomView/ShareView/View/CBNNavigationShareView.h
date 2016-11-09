//
//  CBNNavigationShareView.h
//  CBNGlobal
//
//  Created by Jone on 16/10/19.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBNNavigationShareViewDelegate <NSObject>

- (void)sharePlateFromTag:(NSInteger)tag;

@end

@interface CBNNavigationShareView : UIView

@property (nonatomic, assign) id <CBNNavigationShareViewDelegate> delegate;
@end
