//
//  CBNFileManager.h
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNFileManager : NSObject
/*
 *  使用单利，因为要全局使用
 */
+ (CBNFileManager *)sharedInstance;

/*
 *  获取本地plist文件地址
 */
- (NSString *)loadPlistFilePathWithPlistName:(NSString *)plistName;


@end
