//
//  CBNLiveModel.m
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLiveModel.h"

@implementation CBNLiveModel
- (id)initWithLiveDictionary:(NSDictionary *)liveDic
{
    self = [super init];
    
    if (self) {
        
        _liveCellHeight = 100.0f;
        
        self.liveTitleString = @"Nation awaits astronauts' arrival at the Tiangong II lab for a 30-day sta";
        self.liveContentString = [liveDic objectForKey:@"LiveContent"];
        
        self.liveAuthorNameString = [liveDic objectForKey:@"AdminName"];
        
        self.liveTimeString = @"19:20";
        
        
    }
    
    return self;
}

- (void)setLiveCellHeight:(CGFloat)liveCellHeight
{
    _liveCellHeight = liveCellHeight;
}
@end
