//
//  CBNLoadingView.h
//  CBNGlobal
//
//  Created by Jone on 2016/11/2.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBNLoadingView : UIView


- (void)startLoading;

- (void)loadingFailed;

- (void)loadingSecuessed;
@end
