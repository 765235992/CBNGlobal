//
//  CBNParametersLinkManager.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/26.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNParametersLinkManager : NSObject
+ (CBNParametersLinkManager *)sharedManager;

- (NSString *)channelURL;
- (NSString *)getNewsListURLWithRootlID:(NSInteger)channelID page:(NSInteger)page pageSize:(NSInteger)pageSize;

- (NSString *)getNewsListURLWithChannelID:(NSInteger)channelID page:(NSInteger)page pageSize:(NSInteger)pageSize;

- (NSString *)getNewsThumbName:(NSString *)newsThumb;

- (NSString *)readNewsWithNewsID:(NSInteger)newsID;

- (NSString *)rankNewsMonthURL;

@end
