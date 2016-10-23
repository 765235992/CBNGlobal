//
//  CBNChannelMoel.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseNetworkAction.h"

@interface CBNChannelMoel : CBNBaseNetworkAction
@property (nonatomic, strong) NSString *ChannelID;
@property (nonatomic, strong) NSString *ChannelName;
@property (nonatomic, strong) NSString *EnglishName;
@property (nonatomic, strong) NSString *RootID;
@property (nonatomic, strong) NSString *RootName;
@property (nonatomic, strong) NSString *ChannelMemo;
@property (nonatomic, strong) NSString *ChannelSeo;

- (id)initWithChannelInfo:(NSDictionary *)channelInfo;
@end
