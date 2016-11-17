//
//  CBNNewSqliteManager.m
//  CBNSqliteDemo
//
//  Created by Jone on 2016/10/25.
//  Copyright © 2016年 Burning_Legion. All rights reserved.
//

#import "CBNNewSqliteManager.h"
#import <JYLiveShuffingSDK/JYLiveShuffingSDK.h>

@implementation CBNNewSqliteManager
+ (CBNNewSqliteManager *)sharedManager
{
    static CBNNewSqliteManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    
    
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[CBNNewSqliteManager alloc] init];
        
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
        [tableDic setObject:@"INTEGER NOT NULL" forKey:@"NewsID"];
        [tableDic setObject:@"INTEGER NOT NULL" forKey:@"NewsType"];
        [tableDic setObject:@"INTEGER NOT NULL" forKey:@"ChannelID"];
        [tableDic setObject:@"INTEGER NOT NULL" forKey:@"EntityNews"];
        [tableDic setObject:@"INTEGER NOT NULL" forKey:@"EntityChannel"];
        [tableDic setObject:@"INTEGER NOT NULL" forKey:@"NewsLength"];
        [tableDic setObject:@"INTEGER NOT NULL" forKey:@"UniqueTag"];
        
        
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"NewsTitle"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"EntityPath"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"CreaterName"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"NewsNotes"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"NewsThumbs"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"NewsSource"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"NewsAuthor"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"OuterUrl"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"VideoUrl"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"Tags"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"NewsAddons"];

        [tableDic setObject:@"TEXT NOT NULL" forKey:@"CreateDate"];
        [tableDic setObject:@"TEXT NOT NULL" forKey:@"LastDate"];

        [tableDic setObject:@"INTEGER NOT NULL" forKey:@"IsEntity"];


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
   BOOL isHaveTable =  [[JYDataBaseManager shareInstance] dataBase:self.dataBase isExistTable:tableName];

    if (isHaveTable == NO) {
        return nil;
    }
    NSMutableDictionary *typeDic = [[NSMutableDictionary alloc] init];
    
    [typeDic setObject:@"NSInteger" forKey:@"NewsID"];
    [typeDic setObject:@"NSInteger" forKey:@"NewsType"];
    [typeDic setObject:@"NSInteger" forKey:@"ChannelID"];
    [typeDic setObject:@"NSInteger" forKey:@"EntityNews"];
    [typeDic setObject:@"NSInteger" forKey:@"EntityChannel"];
    [typeDic setObject:@"NSInteger" forKey:@"NewsLength"];
    [typeDic setObject:@"NSInteger" forKey:@"UniqueTag"];
    
    [typeDic setObject:@"NSString" forKey:@"NewsTitle"];
    [typeDic setObject:@"NSString" forKey:@"EntityPath"];
    [typeDic setObject:@"NSString" forKey:@"CreaterName"];
    [typeDic setObject:@"NSString" forKey:@"NewsNotes"];
    [typeDic setObject:@"NSString" forKey:@"NewsThumbs"];
    [typeDic setObject:@"NSString" forKey:@"NewsSource"];
    [typeDic setObject:@"NSString" forKey:@"NewsAuthor"];
    [typeDic setObject:@"NSString" forKey:@"VideoUrl"];
    [typeDic setObject:@"NSString" forKey:@"OuterUrl"];
    [typeDic setObject:@"NSString" forKey:@"Tags"];
    [typeDic setObject:@"NSString" forKey:@"NewsAddons"];

    [typeDic setObject:@"NSString" forKey:@"CreateDate"];
    [typeDic setObject:@"NSString" forKey:@"LastDate"];
    
    [typeDic setObject:@"BOOL" forKey:@"IsEntity"];

    NSArray *result = [[JYDataBaseManager shareInstance] dataBase:self.dataBase selectKeyTypes:typeDic fromTable:tableName];
    
    return result;

}

- (BOOL)cleanTableWithTableName:(NSString *)tableName
{
    
    
    BOOL isHaveTable =  [[JYDataBaseManager shareInstance] dataBase:self.dataBase isExistTable:tableName];
    
    if (isHaveTable == NO) {
        
        return NO;
    }

    return [[JYDataBaseManager shareInstance] dataBase:self.dataBase clearTable:tableName];
    
}
+ (NSArray *)dictionaryChangeToModelWithDictionaryArray:(NSArray *)dictionaryArray
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];

    for (NSDictionary *newsDic in dictionaryArray) {
        
        CBNNewsModel *newsModel = [CBNNewsModel mj_objectWithKeyValues:newsDic];

        [resultArray addObject:newsModel];
        
    }
    
    return resultArray;
}
+ (NSArray *)liveDictionaryChanegeToLiveModekWithDictionaryArray:(NSArray *)dictionaryArray
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    

    for (NSDictionary *newsDic in dictionaryArray) {
        
        CBNNewsModel *newsModel = [CBNNewsModel mj_objectWithKeyValues:newsDic];
        CBNLiveModel *liveModel = [[CBNLiveModel alloc] init];
        
        liveModel.newsModel = newsModel;
        NSString *resultString = [NSString stringWithFormat:@"LIVE %@ %@",[NSDate getHourDateFromUTCDateString:liveModel.newsModel.LastDate],liveModel.newsModel.NewsTitle];

        liveModel.liveTitle = [[JYShuffingAttributeString sharedInstance] setRedLiveWithAttributedString:[[JYShuffingAttributeString sharedInstance] setLiveShuffingTitleWithTitleString:resultString]];

        liveModel.height = 0.0f;
        [resultArray addObject:liveModel];
        
    }
    return resultArray;
    
}
@end
