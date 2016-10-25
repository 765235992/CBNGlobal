//
//  CBNNewSqliteManager.h
//  CBNSqliteDemo
//
//  Created by Jone on 2016/10/25.
//  Copyright © 2016年 Burning_Legion. All rights reserved.
//

#import "CBNBaseSqlite.h"

@interface CBNNewSqliteManager : CBNBaseSqlite
+ (CBNNewSqliteManager *)sharedManager;

- (BOOL)createTableWithTableName:(NSString *)tableName;

- (BOOL)insertObjects:(NSArray *)objectsArray intoTable:(NSString *)tableName;

- (NSArray *)selectObjectsfromTable:(NSString *)tableName;

- (BOOL)cleanTableWithTableName:(NSString *)tableName;

+ (NSArray *)dictionaryChangeToModelWithDictionaryArray:(NSArray *)dictionaryArray;

+ (NSArray *)liveDictionaryChanegeToLiveModekWithDictionaryArray:(NSArray *)dictionaryArray;
@end
