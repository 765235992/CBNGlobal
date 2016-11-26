//
//  CBNChannelSqliteManager.m
//  CBNSqliteDemo
//
//  Created by Jone on 2016/10/25.
//  Copyright © 2016年 Burning_Legion. All rights reserved.
//

#import "CBNChannelSqliteManager.h"
@implementation CBNChannelSqliteManager
+ (CBNChannelSqliteManager *)sharedManager
{
    static CBNChannelSqliteManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    
    
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[CBNChannelSqliteManager alloc] init];
        
    });
    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        

    }
    return self;
}
- (BOOL)createTableWithTableName:(NSString *)tableName
{
    BOOL isHaveTheChannelTable = [[JYDataBaseManager shareInstance] dataBase:self.dataBase isExistTable:tableName];
    
    if (isHaveTheChannelTable == NO) {
        
        
        NSMutableDictionary *tableDic = [[NSMutableDictionary alloc] init];
        [tableDic setObject:@"INTEGER NOT NULL" forKey:@"ChannelID"];
        [tableDic setObject:@"INTEGER NOT NULL" forKey:@"RootID"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"ChannelName"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"EnglishName"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"RootName"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"ChannelMemo"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"ChannelSeo"];
        
        BOOL isCreateSecuessed = [[JYDataBaseManager shareInstance] dataBase:self.dataBase createTable:tableName keyTypes:tableDic];
        
        if (!isCreateSecuessed) {
            NSLog(@"创建表失败 -- 表名（%@）",tableName);
        }
        return isCreateSecuessed;

    }else{
        return YES;
    }

}
- (BOOL)insertObjects:(NSArray *)objectsArray intoTable:(NSString *)tableName
{
    [self createTableWithTableName:tableName];
    
    BOOL isInsertSecuessed =  [[JYDataBaseManager shareInstance] dataBase:self.dataBase insertObjects:objectsArray intoTable:tableName];
    
    return isInsertSecuessed;
}

- (NSArray *)selectObjectsfromTable:(NSString *)tableName
{
    
    NSMutableDictionary *typeDic = [[NSMutableDictionary alloc] init];
    [typeDic setObject:@"NSInteger" forKey:@"ChannelID"];
    [typeDic setObject:@"NSInteger" forKey:@"RootID"];
    [typeDic setObject:@"NSString" forKey:@"ChannelName"];
    [typeDic setObject:@"NSString" forKey:@"EnglishName"];
    [typeDic setObject:@"NSString" forKey:@"RootName"];
    [typeDic setObject:@"NSString" forKey:@"ChannelMemo"];
    [typeDic setObject:@"NSString" forKey:@"ChannelSeo"];
    
    NSArray *result = [[JYDataBaseManager shareInstance] dataBase:self.dataBase selectKeyTypes:typeDic fromTable:tableName];
    
    return result;

}
- (BOOL)cleanTableWithTableName:(NSString *)tableName
{
    return [[JYDataBaseManager shareInstance] dataBase:self.dataBase clearTable:tableName];
    
}

- (NSArray *)dictionaryChangeToModelWithDictionaryArray:(NSArray *)dictionaryArray
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *channelDic in dictionaryArray) {
        
        
        if (![[channelDic objectForKey:@"EnglishName"]isEqualToString:@"Video"]) {
            CBNChannelModel *channelModel = [CBNChannelModel mj_objectWithKeyValues:channelDic];
            
            [resultArray addObject:channelModel];

        }
        
    }
    
    return resultArray;
}


@end
