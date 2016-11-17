//
//  CBNSearchSqliteManager.m
//  CBNGlobal
//
//  Created by Jone on 2016/11/14.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearchSqliteManager.h"

@implementation CBNSearchSqliteManager
+ (CBNSearchSqliteManager *)sharedManager
{
    static CBNSearchSqliteManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    
    
    dispatch_once(&oncePredicate, ^{
        
        _sharedManager = [[CBNSearchSqliteManager alloc] init];
        
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
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"result"];
        
        BOOL isCreateSecuessed = [[JYDataBaseManager shareInstance] dataBase:self.dataBase createTable:tableName keyTypes:tableDic];
        
        if (!isCreateSecuessed) {
            NSLog(@"创建表失败 -- 表名（%@）",tableName);
        }
        return isCreateSecuessed;
        
    }else{
        return YES;
    }
    
}

- (BOOL)insertObjects:(NSString *)searchResult intoTable:(NSString *)tableName
{
    [self createTableWithTableName:tableName];
    
    BOOL isInsertSecuessed =  [[JYDataBaseManager shareInstance] dataBase:self.dataBase insertKeyValues:@{@"result":searchResult} intoTable:tableName];
    
    return isInsertSecuessed;
}
- (NSArray *)selectObjectsfromTable:(NSString *)tableName
{
    
    NSMutableDictionary *typeDic = [[NSMutableDictionary alloc] init];
    
    [typeDic setObject:@"NSString" forKey:@"result"];
    
    NSArray *result = [[JYDataBaseManager shareInstance] dataBase:self.dataBase selectKeyTypes:typeDic fromTable:tableName];
    
    NSLog(@"%@",result);
    
    return result;
    
}
- (BOOL)cleanTableWithTableName:(NSString *)tableName
{
    return [[JYDataBaseManager shareInstance] dataBase:self.dataBase clearTable:tableName];
    
}


@end
