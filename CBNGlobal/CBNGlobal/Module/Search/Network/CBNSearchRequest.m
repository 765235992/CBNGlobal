//
//  CBNSearchRequest.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/28.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearchRequest.h"

@implementation CBNSearchRequest
+ (void)loadNewsItemsWithSearchText:(NSString *)searchText page:(NSInteger)page pageSize:(NSInteger)pageSize Secuessed:(void (^)(NSArray *searchReaultArray))secuessed failed:(void (^)(NSError *error))failed
{
    


    [self GET:[[CBNParametersLinkManager sharedManager] searchWithKeyword:[searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] page:page  pageSize:pageSize] parameters:nil success:^(id result) {
        if (secuessed) {
            
            secuessed([result objectForKey:@"result"]);
            
        }
    } failed:^(NSError *error) {
        
    }];
}
@end
