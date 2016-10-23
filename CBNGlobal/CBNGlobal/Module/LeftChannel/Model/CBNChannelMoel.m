//
//  CBNChannelMoel.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNChannelMoel.h"

@implementation CBNChannelMoel
- (id)initWithChannelInfo:(NSDictionary *)channelInfo
{
    self = [super init];
    
    if (self) {
        self.ChannelID = [NSString stringWithFormat:@"%@",[channelInfo objectForKey:@"ChannelID"]];
        self.ChannelName = [NSString stringWithFormat:@"%@",[channelInfo objectForKey:@"ChannelName"]];
        self.EnglishName = [NSString stringWithFormat:@"%@",[channelInfo objectForKey:@"EnglishName"]];
        self.RootID = [NSString stringWithFormat:@"%@",[channelInfo objectForKey:@"RootID"]];
        self.RootName = [NSString stringWithFormat:@"%@",[channelInfo objectForKey:@"RootName"]];
        self.ChannelMemo = [NSString stringWithFormat:@"%@",[channelInfo objectForKey:@"ChannelMemo"]];
        self.ChannelSeo = [NSString stringWithFormat:@"%@",[channelInfo objectForKey:@"ChannelSeo"]];

    }
    
    return self;
    
}

@end
