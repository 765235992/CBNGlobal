//
//  CBNDao.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/23.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNDao.h"

@interface CBNDao ()
@end


@implementation CBNDao
//static

+ (CBNDao *)sharedManager
{
    static CBNDao *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[CBNDao alloc] init];
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
- (NSString *)sqlPath
{
    // 1 获取数据库对象
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CBNGlobal.sqlite"];

    
    
    return filePath;
    
    
}
- (void)open
{
    NSString *sqlPath = [self sqlPath];
    
    self.fmdb = [FMDatabase databaseWithPath:sqlPath];
    BOOL isOpen = [_fmdb open];
    
    if (isOpen == YES) {
    }else{

    }

}


- (BOOL)isTableOK:(NSString *)tableName
{
    FMResultSet *rs = [_fmdb executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

- (void)deleteDataFromTableName:(NSString *)tableName {
    
    [self open];
    
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
    
    [_fmdb executeUpdate:deleteSql];
    
    [_fmdb close];
    
}


@end
