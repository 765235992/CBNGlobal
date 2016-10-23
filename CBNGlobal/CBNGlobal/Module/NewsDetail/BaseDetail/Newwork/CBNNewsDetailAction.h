//
//  CBNNewsDetailAction.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseNetworkAction.h"
#import "CBNNewsDetailModel.h"

@interface CBNNewsDetailAction : CBNBaseNetworkAction
+ (void)loadNewsDatetailWithNewsID:(NSInteger)newsID secuessed:(void (^)(CBNNewsDetailModel *newsDetailModel))secuessed failed:(void (^)(NSError *error))failed;
@end
