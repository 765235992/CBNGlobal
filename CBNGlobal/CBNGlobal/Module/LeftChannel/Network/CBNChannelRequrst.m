//
//  CBNChannelRequrst.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNChannelRequrst.h"

@implementation CBNChannelRequrst
+ (void)postChannelsSecuessed:(void (^)(NSArray *channelArray))secuessed failed:(void (^)(NSError *error))failed
{
    NSMutableArray *channelModelArray = [[NSMutableArray alloc] init];
    
 
    [self POST:[[JYParametersLinkManager sharedManager] channelURL] parameters:nil success:^(id result) {
        
        NSArray *channelArray = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
        
        for (NSDictionary *channelInfo in channelArray) {
            
            if ([[channelInfo objectForKey:@"RootName"] isEqualToString:@"频道"]) {
                CBNChannelMoel *channelModel = [CBNChannelMoel mj_objectWithKeyValues:channelInfo];

                [channelModelArray addObject:channelModel];
            }
        }
        
        if (secuessed)
        {
            secuessed(channelModelArray);
        }
    } failed:^(NSError *error) {
        if(failed)
        {
            failed(error);
        }
    }];
}

@end
