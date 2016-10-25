//
//  CBNBaseSqlite.h
//  CBNSqliteDemo
//
//  Created by Jone on 2016/10/25.
//  Copyright © 2016年 Burning_Legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYSqliteSDK.h"
@interface CBNBaseSqlite : NSObject

@property (nonatomic, strong) FMDatabase *dataBase;

@end
