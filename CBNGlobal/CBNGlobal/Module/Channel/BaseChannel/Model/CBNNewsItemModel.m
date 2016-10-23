
//
//  CBNNewsItemModel.m
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNNewsItemModel.h"

@implementation CBNNewsItemModel
- (id)initWichNewsItemInfo:(NSDictionary *)newsItemoInfo
{
    self = [super init];
    
    if (self) {
        self.ChannelID = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"ChannelID"]];

        self.CreateDate = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"CreateDate"]];

        self.CreaterName = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"CreaterName"]];

        self.EntityChannel = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"EntityChannel"]];

        self.EntityNews = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"EntityNews"]];

        self.EntityPath = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"EntityPath"]];

        self.IsEntity = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"IsEntity"]];

        self.LastDate = [NSString stringWithFormat:@"%@",[NSDate getNormalDateFromUTCDateString:[newsItemoInfo objectForKey:@"LastDate"] ]];
        
        self.NewsAddons = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"NewsAddons"]];

        self.NewsAuthor = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"NewsAuthor"]];

        self.NewsID = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"NewsID"]];

        self.NewsLength = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"NewsLength"]];

        self.NewsNotes = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"NewsNotes"]];

        self.NewsSource = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"NewsSource"]];

        self.NewsThumbs = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"NewsThumbs"]];

        self.NewsTitle = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"NewsTitle"]];

        NSInteger type = [[newsItemoInfo objectForKey:@"NewsType"] integerValue];
        
        if (type > 100) {
            self.NewsID =  [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"EntityNews"]];;

        }
        self.NewsType = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"NewsType"]];

        
        self.OuterUrl = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"OuterUrl"]];

        self.Tags = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"Tags"]];

        self.UniqueTag = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"UniqueTag"]];

        self.VideoUrl = [NSString stringWithFormat:@"%@",[newsItemoInfo objectForKey:@"VideoUrl"]];

    }
    
    return self;
}

- (void)setHeight:(CGFloat)height
{
//    _height = height;
}
@end
