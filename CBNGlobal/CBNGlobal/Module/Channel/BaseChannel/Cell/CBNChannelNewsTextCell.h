//
//  CBNChannelNewsTextCell.h
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNNewsModel.h"
#import "CBNSearchModel.h"
@interface CBNChannelNewsTextCell : UITableViewCell

@property (nonatomic, strong) CBNNewsModel *itemModel;

@property (nonatomic, strong) CBNSearchModel *searchModel;
@end
