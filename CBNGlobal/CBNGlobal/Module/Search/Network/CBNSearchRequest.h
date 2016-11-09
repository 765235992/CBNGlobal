//
//  CBNSearchRequest.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/28.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseNetworkAction.h"

@interface CBNSearchRequest : CBNBaseNetworkAction

+ (void)loadNewsItemsWithSearchText:(NSString *)searchText page:(NSInteger)page pageSize:(NSInteger)pageSize Secuessed:(void (^)(NSArray *searchReaultArray))secuessed failed:(void (^)(NSError *error))failed;
@end
