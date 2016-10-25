//
//  CBNTextView.h
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNNewsDetailModel.h"
@interface CBNTextView : UITextView
@property (nonatomic, strong) CBNNewsDetailModel *newsDetaileModel;
@property (nonatomic, strong) NSMutableAttributedString *attText;
@end
