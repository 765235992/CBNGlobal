//
//  CBNBaseSqlite.m
//  CBNSqliteDemo
//
//  Created by Jone on 2016/10/25.
//  Copyright © 2016年 Burning_Legion. All rights reserved.
//

#import "CBNBaseSqlite.h"

@implementation CBNBaseSqlite
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /*
         *
         */
        JYDataBaseManager *manager = [[JYDataBaseManager alloc] init];
        
        self.dataBase = [manager createSqliteWithSqliteName:@"CBNGlobal.sqlite"];
        
    }
    return self;
}

@end
