//
//  CBNDao.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/23.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNDao : NSObject

@property (nonatomic, strong) FMDatabase *fmdb;
+ (CBNDao *)sharedManager;

- (NSString *)sqlPath;

- (void)open;

- (BOOL)isTableOK:(NSString *)tableName;


- (void)deleteDataFromTableName:(NSString *)tableName;


@end
