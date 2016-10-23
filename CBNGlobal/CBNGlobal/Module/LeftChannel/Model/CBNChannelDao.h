//
//  CBNChannelDao.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/23.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBNDao.h"

@interface CBNChannelDao : CBNDao
+ (CBNChannelDao *)sharedManager;

- (void)insertChannelItemsWithTableName:(NSString *)tableName andChannelItemArray:(NSArray *)channelItemArray;

- (NSArray *)queryChannelDataWithTableName:(NSString *)tableName;
//
//- (void)deleteDataFromTableName:(NSString *)tableName;
@end
