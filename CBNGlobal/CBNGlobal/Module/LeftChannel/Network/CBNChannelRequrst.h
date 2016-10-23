//
//  CBNChannelRequrst.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseNetworkAction.h"

@interface CBNChannelRequrst : CBNBaseNetworkAction

+ (void)postChannelsSecuessed:(void (^)(NSArray *channelArray))secuessed failed:(void (^)(NSError *error))failed;
@end
