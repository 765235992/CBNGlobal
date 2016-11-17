//
//  CBNLiveModel.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/25.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBNNewsModel.h"

@interface CBNLiveModel : NSObject
@property (nonatomic, strong) CBNNewsModel *newsModel;
@property (nonatomic, strong) NSAttributedString *liveTitle;
@property (nonatomic, assign) CGFloat height;
@end
