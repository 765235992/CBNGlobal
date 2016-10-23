//
//  CBNNewsDetailModel.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNNewsDetailModel.h"

@implementation CBNNewsDetailModel
- (id)initWithNewsDetailInfo:(NSDictionary *)newsDetailInfo
{
    self = [super init];
    
    if (self) {
        self.AppID= [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"AppID"]];

        self.ArticleID = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"ArticleID"]];

        self.AtomID = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"AtomID"]];

        self.ChannelID = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"ChannelID"]];

        self.ChannelRoot = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"ChannelRoot"]];

        self.ColumnID = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"ColumnID"]];

        self.CountAsks = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CountAsks"]];

        self.CountExperts = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CountExperts"]];

        self.CountInners = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CountInners"]];

        self.CountLemmas = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CountLemmas"]];

        self.CountRelates = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CountRelates"]];

        self.CountScenes = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CountScenes"]];

        self.CountTracks = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CountTracks"]];

        self.CountStocks= [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CountStocks"]];

        self.CountVotes = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CountVotes"]];

        self.CreateDate = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CreateDate"]];
        self.CreaterName = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"CreaterName"]];

        self.EntityPath = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"EntityPath"]];


        self.Keywords = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"Keywords"]];

        self.LastDate = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"LastDate"]];

        self.LiveAddress = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"LiveAddress"]];

        self.LiveDate = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"LiveDate"]];

        self.LiveLink = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"LiveLink"]];

        self.LiveState = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"LiveState"]];

        self.NewsAddons = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsAddons"]];

        self.NewsAuthor = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsAuthor"]];
        self.NewsBody = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsBody"]];

        self.NewsCover = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsCover"]];

        self.NewsID = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsID"]];

        self.NewsLength = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsLength"]];

        self.NewsNotes = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsNotes"]];

        self.NewsSource = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsSource"]];

        self.NewsThumbs = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsThumbs"]];

        self.NewsTitle = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsTitle"]];

        self.NewsType = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"NewsType"]];

        self.OuterUrl = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"OuterUrl"]];

        
        self.Stocks = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"Stocks"]];

        self.Tags = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"Tags"]];

        self.UniqueTag = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"UniqueTag"]];

        self.VideoUrl = [NSString stringWithFormat:@"%@",[newsDetailInfo objectForKey:@"VideoUrl"]];

    }
    
    return self;
}

@end
