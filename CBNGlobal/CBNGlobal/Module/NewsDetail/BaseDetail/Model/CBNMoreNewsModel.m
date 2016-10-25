//
//  CBNMoreNewsModel.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/24.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNMoreNewsModel.h"

@implementation CBNMoreNewsModel
- (id)initWithMoreNewsInfo:(NSDictionary *)info
{
    self = [super init];
    
    if (self) {
        self.NewsID = [NSString stringWithFormat:@"%@",[info objectForKey:@"NewsID"]];
        self.NewsType = [NSString stringWithFormat:@"%@",[info objectForKey:@"NewsType"]];

        self.NewsTitle = [NSString stringWithFormat:@"%@",[info objectForKey:@"NewsTitle"]];

    }
    
    return self;
}

@end
