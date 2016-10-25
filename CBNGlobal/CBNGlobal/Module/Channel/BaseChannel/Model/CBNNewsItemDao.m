//
//  CBNNewsItemDao.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/23.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNNewsItemDao.h"
#import "CBNLiveItemModel.h"
@implementation CBNNewsItemDao

+ (CBNNewsItemDao *)sharedManager
{
    static CBNNewsItemDao *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[CBNNewsItemDao alloc] init];
    });
    return _sharedManager;
}

- (void)insertChannelNewsItemsWithTableName:(NSString *)tableName andChannelNewsItemArray:(NSArray *)channelNewsItemsModelArray
{
    [self open];
    BOOL theTableIsHave = [self isTableOK:tableName];
    
    if (theTableIsHave == NO) {
        
        [self.fmdb executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id INTEGER PRIMARY KEY, ChannelID TEXT NOT NULL, CreateDate INTEGER NOT NULL, CreaterName INTEGER NOT NULL, EntityChannel INTEGER NOT NULL, EntityNews INTEGER NOT NULL, EntityPath INTEGER NOT NULL, IsEntity INTEGER NOT NULL, LastDate INTEGER NOT NULL, NewsAddons INTEGER NOT NULL, NewsAuthor INTEGER NOT NULL, NewsID INTEGER NOT NULL, NewsLength INTEGER NOT NULL, NewsNotes INTEGER NOT NULL, NewsSource INTEGER NOT NULL, NewsThumbs INTEGER NOT NULL, NewsTitle INTEGER NOT NULL, NewsType INTEGER NOT NULL, OuterUrl INTEGER NOT NULL, Tags INTEGER NOT NULL, UniqueTag INTEGER NOT NULL, VideoUrl INTEGER NOT NULL);",tableName]];
        
    }
    for (CBNNewsItemModel *tempModel in channelNewsItemsModelArray) {
        
        NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO %@(ChannelID, CreateDate, CreaterName,EntityChannel,EntityNews,EntityPath,IsEntity,LastDate,NewsAddons,NewsAuthor,NewsID,NewsLength,NewsNotes,NewsSource,NewsThumbs,NewsTitle,NewsType,OuterUrl,Tags,UniqueTag,VideoUrl) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@');", tableName,tempModel.ChannelID, tempModel.CreateDate, tempModel.CreaterName,tempModel.EntityChannel,tempModel.EntityNews,tempModel.EntityPath,tempModel.IsEntity,tempModel.LastDate,tempModel.NewsAddons,tempModel.NewsAuthor, tempModel.NewsID, tempModel.NewsLength, tempModel.NewsNotes, tempModel.NewsSource, tempModel.NewsThumbs, tempModel.NewsTitle, tempModel.NewsType, tempModel.OuterUrl, tempModel.Tags, tempModel.UniqueTag, tempModel.VideoUrl];
        
        [self.fmdb executeUpdate:insertSql];
        
    }
    
    [self.fmdb close];
    
    
}

- (NSArray *)queryNewsItemsDataWithTableName:(NSString *)tableName {
    
    [self open];
    
    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    FMResultSet *set = [self.fmdb executeQuery:querySql];
    
    while ([set next]) {
        
        if ([tableName isEqualToString:@"Live"]) {
            CBNLiveItemModel *model = [[CBNLiveItemModel alloc] init];
            model.ChannelID = [set stringForColumn:@"ChannelID"];
            
            model.CreateDate = [set stringForColumn:@"CreateDate"];
            
            model.CreaterName = [set stringForColumn:@"CreaterName"];
            
            model.EntityChannel = [set stringForColumn:@"EntityChannel"];
            
            model.EntityNews = [set stringForColumn:@"EntityNews"];
            
            model.EntityPath = [set stringForColumn:@"EntityPath"];
            
            model.IsEntity = [set stringForColumn:@"IsEntity"];
            
            model.LastDate = [set stringForColumn:@"LastDate"];
            
            model.NewsAddons = [set stringForColumn:@"NewsAddons"];
            
            model.NewsAuthor = [set stringForColumn:@"NewsAuthor"];
            
            model.NewsID = [set stringForColumn:@"NewsID"];
            
            model.NewsLength = [set stringForColumn:@"NewsLength"];
            
            model.NewsNotes = [set stringForColumn:@"NewsNotes"];
            
            model.NewsSource = [set stringForColumn:@"NewsSource"];
            
            model.NewsThumbs = [set stringForColumn:@"NewsThumbs"];
            
            model.NewsTitle = [set stringForColumn:@"NewsTitle"];
            
            NSInteger type = [[set stringForColumn:@"NewsType"] integerValue];
            
            if (type > 100) {
                model.NewsID =  [set stringForColumn:@"EntityNews"];;
                
            }
            model.NewsType =[set stringForColumn:@"NewsType"];
            
            
            model.OuterUrl = [set stringForColumn:@"OuterUrl"];
            
            model.Tags = [set stringForColumn:@"Tags"];
            
            model.UniqueTag = [set stringForColumn:@"UniqueTag"];;
            
            model.VideoUrl = [set stringForColumn:@"VideoUrl"];
            model.height = 0;
            [modelArray addObject:model];

        }else{
            CBNNewsItemModel *model = [[CBNNewsItemModel alloc] init];
            model.ChannelID = [set stringForColumn:@"ChannelID"];
            
            model.CreateDate = [set stringForColumn:@"CreateDate"];
            
            model.CreaterName = [set stringForColumn:@"CreaterName"];
            
            model.EntityChannel = [set stringForColumn:@"EntityChannel"];
            
            model.EntityNews = [set stringForColumn:@"EntityNews"];
            
            model.EntityPath = [set stringForColumn:@"EntityPath"];
            
            model.IsEntity = [set stringForColumn:@"IsEntity"];
            
            model.LastDate = [set stringForColumn:@"LastDate"];
            
            model.NewsAddons = [set stringForColumn:@"NewsAddons"];
            
            model.NewsAuthor = [set stringForColumn:@"NewsAuthor"];
            
            model.NewsID = [set stringForColumn:@"NewsID"];
            
            model.NewsLength = [set stringForColumn:@"NewsLength"];
            
            model.NewsNotes = [set stringForColumn:@"NewsNotes"];
            
            model.NewsSource = [set stringForColumn:@"NewsSource"];
            
            model.NewsThumbs = [set stringForColumn:@"NewsThumbs"];
            
            model.NewsTitle = [set stringForColumn:@"NewsTitle"];
            
            NSInteger type = [[set stringForColumn:@"NewsType"] integerValue];
            
            if (type > 100) {
                model.NewsID =  [set stringForColumn:@"EntityNews"];;
                
            }
            model.NewsType =[set stringForColumn:@"NewsType"];
            
            
            model.OuterUrl = [set stringForColumn:@"OuterUrl"];
            
            model.Tags = [set stringForColumn:@"Tags"];
            
            model.UniqueTag = [set stringForColumn:@"UniqueTag"];;
            
            model.VideoUrl = [set stringForColumn:@"VideoUrl"];
            
            [modelArray addObject:model];

        }
    }
    
    [self.fmdb close];
    
    return modelArray;
}


@end
