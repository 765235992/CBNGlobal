//
//  CBNSearchSqliteManager.h
//  CBNGlobal
//
//  Created by Jone on 2016/11/14.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseSqlite.h"

@interface CBNSearchSqliteManager : CBNBaseSqlite
+ (CBNSearchSqliteManager *)sharedManager;

- (BOOL)createTableWithTableName:(NSString *)tableName;

- (BOOL)insertObjects:(NSString *)searchResult intoTable:(NSString *)tableName;

- (NSArray *)selectObjectsfromTable:(NSString *)tableName;

- (BOOL)cleanTableWithTableName:(NSString *)tableName;

@end
