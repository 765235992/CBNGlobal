//
//  CBNLiveNewsCell.h
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBNLiveModel.h"
@class CBNLiveNewsCell;
@protocol CBNLiveNewsCellDelegate <NSObject>

- (void)liveNewsCell:(CBNLiveNewsCell *)liveCell detailButtonClickedWithLiveModel:(CBNLiveModel *)liveMoel;

@end

@interface CBNLiveNewsCell : UITableViewCell

@property (nonatomic, assign) id <CBNLiveNewsCellDelegate> delegate;

@property (nonatomic, strong) CBNLiveModel *liveModel;

@end
