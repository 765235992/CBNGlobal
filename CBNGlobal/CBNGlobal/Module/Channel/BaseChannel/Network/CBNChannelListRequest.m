//
//  CBNChannelListRequest.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNChannelListRequest.h"
#import "CBNNewsModel.h"
@implementation CBNChannelListRequest
+ (void)loadNewsItemsWithChannelID:(NSInteger)channelID page:(NSInteger)page pageSize:(NSInteger)pageSize Secuessed:(void (^)(NSArray *channelNewsItemsArray))secuessed failed:(void (^)(NSError *error))failed
{
        
    [self POST:[[CBNParametersLinkManager sharedManager] getNewsListURLWithChannelID:channelID page:page pageSize:pageSize]parameters:nil success:^(id result) {

        NSArray *channelItemArray = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
        
        if (secuessed) {
            secuessed(channelItemArray);
            
        }
    } failed:^(NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}
+ (void)loadNewsItemsWithRootID:(NSInteger)channelID page:(NSInteger)page pageSize:(NSInteger)pageSize Secuessed:(void (^)(NSArray *channelNewsItemsArray))secuessed failed:(void (^)(NSError *error))failed
{
    
    
    [self POST:[[CBNParametersLinkManager sharedManager] getNewsListURLWithRootlID:28 page:page pageSize:pageSize]parameters:nil success:^(id result) {
        NSArray *channelItemArray = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
        
        if (secuessed) {
            secuessed(channelItemArray);
            
        }
    } failed:^(NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}




//    ;
@end
