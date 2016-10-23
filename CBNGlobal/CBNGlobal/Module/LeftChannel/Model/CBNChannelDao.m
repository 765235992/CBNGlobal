//
//  CBNChannelDao.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/23.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNChannelDao.h"

@interface CBNChannelDao ()
{
    FMDatabase *_fmdb;
}

@end

@implementation CBNChannelDao
+ (CBNChannelDao *)sharedManager
{
    static CBNChannelDao *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[CBNChannelDao alloc] init];
    });
    return _sharedManager;
}
- (void)insertChannelItemsWithTableName:(NSString *)tableName andChannelItemArray:(NSArray *)channelItemArray
{
    
    [self open];
    BOOL theTableIsHave = [self isTableOK:tableName];
    
    if (theTableIsHave == NO) {
        
        [self.fmdb executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id INTEGER PRIMARY KEY, ChannelID TEXT NOT NULL, ChannelName INTEGER NOT NULL, EnglishName INTEGER NOT NULL, RootID INTEGER NOT NULL, RootName INTEGER NOT NULL, ChannelMemo INTEGER NOT NULL, ChannelSeo INTEGER NOT NULL);",tableName]];

    }
    
    for (CBNChannelMoel *tempModel in channelItemArray) {
        NSLog(@"%@",channelItemArray);
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@(ChannelID, ChannelName, EnglishName,RootID,RootName,ChannelMemo,ChannelSeo) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@');", tableName,tempModel.ChannelID, tempModel.ChannelName, tempModel.EnglishName,tempModel.RootID,tempModel.RootName,tempModel.ChannelMemo,tempModel.ChannelSeo];

        [self.fmdb executeUpdate:insertSql];

    }
    
    [self.fmdb close];


}

- (NSArray *)queryChannelDataWithTableName:(NSString *)tableName
{
    
    [self open];
    
    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    FMResultSet *set = [self.fmdb executeQuery:querySql];
    NSLog(@"%@",set);
    while ([set next]) {
        
        CBNChannelMoel *model = [[CBNChannelMoel alloc] init];
        
        model.ChannelID = [set stringForColumn:@"ChannelID"];
        model.ChannelName = [set stringForColumn:@"ChannelName"];
        model.EnglishName = [set stringForColumn:@"EnglishName"];
        model.RootID =[set stringForColumn:@"RootID"];
        model.RootName = [set stringForColumn:@"RootName"];
        model.ChannelMemo = [set stringForColumn:@"ChannelMemo"];
        model.ChannelSeo = [set stringForColumn:@"ChannelSeo"];
        [modelArray addObject:model];
    }
    [self.fmdb close];
    
    return modelArray;

}

@end
