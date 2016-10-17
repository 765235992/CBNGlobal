//
//  CBNFileManager.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNFileManager.h"

@implementation CBNFileManager
/*
 *  使用单利，因为要全局使用
 */
+ (CBNFileManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    
    static CBNFileManager *_sharedInstance;
    
    dispatch_once(&onceToken, ^{
        
        _sharedInstance = [[CBNFileManager alloc] init];
        
    });
    
    return _sharedInstance;
}
- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}
/*
 *  获取本地plist文件地址
 */
- (NSString *)loadPlistFilePathWithPlistName:(NSString *)plistName
{
    return [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
}

@end
