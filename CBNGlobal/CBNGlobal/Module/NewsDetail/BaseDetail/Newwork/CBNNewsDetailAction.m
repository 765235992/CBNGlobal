//
//  CBNNewsDetailAction.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNNewsDetailAction.h"

@implementation CBNNewsDetailAction
+ (void)loadNewsDatetailWithNewsID:(NSInteger)newsID secuessed:(void (^)(CBNNewsDetailModel *newsDetailModel))secuessed failed:(void (^)(NSError *error))failed
{
    [self POST:[[JYParametersLinkManager sharedManager] readNewsWithNewsID:newsID]  parameters:nil success:^(id result) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
//        CBNNewsDetailModel *detailModel = [CBNNewsDetailModel mj_objectWithKeyValues:dic];

        
        CBNNewsDetailModel *detailModel = [[CBNNewsDetailModel alloc] initWithNewsDetailInfo:dic];
        if (secuessed) {
            secuessed(detailModel);
        }
        
    } failed:^(NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
    
}
@end
