//
//  CBNChannelListRequest.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseNetworkAction.h"

@interface CBNChannelListRequest : CBNBaseNetworkAction
+ (void)loadNewsItemsWithChannelID:(NSInteger)channelID page:(NSInteger)page pageSize:(NSInteger)pageSize Secuessed:(void (^)(NSArray *channelNewsItemsArray))secuessed failed:(void (^)(NSError *error))failed;

@end
