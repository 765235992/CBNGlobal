//
//  CBNChannelListRequest.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNChannelListRequest.h"
#import "CBNNewsItemModel.h"
#import "CBNLiveItemModel.h"
@implementation CBNChannelListRequest
+ (void)loadNewsItemsWithChannelID:(NSInteger)channelID page:(NSInteger)page pageSize:(NSInteger)pageSize Secuessed:(void (^)(NSArray *channelNewsItemsArray))secuessed failed:(void (^)(NSError *error))failed
{
    
    NSMutableArray *channelItemModelArray = [[NSMutableArray alloc] init];
    
    [self POST:[[JYParametersLinkManager sharedManager] getNewsListURLWithChannelID:channelID page:page pageSize:pageSize]parameters:nil success:^(id result) {
        NSArray *channelItemArray = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];

        for (NSDictionary *tempDic  in channelItemArray) {
            if (channelID == 206) {
                CBNLiveItemModel *tempModel = [[CBNLiveItemModel alloc] initWichNewsItemInfo:tempDic];
                [channelItemModelArray addObject:tempModel];


            }else{
                CBNNewsItemModel *tempModel = [[CBNNewsItemModel alloc] initWichNewsItemInfo:tempDic];
                [channelItemModelArray addObject:tempModel];


            }
//            CBNNewsItemModel *tempModel = [CBNNewsItemDao mj_objectWithKeyValues:tempDic];
//            ;

            
        }
        
        if (secuessed) {
            secuessed(channelItemModelArray);
            
        }
    } failed:^(NSError *error) {
        if (failed) {
            failed(error);
        }
        NSLog(@"%@",error);
    }];
}
@end
