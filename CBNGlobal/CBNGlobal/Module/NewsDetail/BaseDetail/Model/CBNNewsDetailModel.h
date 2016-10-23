//
//  CBNNewsDetailModel.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNNewsDetailModel : NSObject
@property (nonatomic, strong) NSString *AppID;
@property (nonatomic, strong) NSString *ArticleID;
@property (nonatomic, strong) NSString *AtomID;
@property (nonatomic, strong) NSString *ChannelID;
@property (nonatomic, strong) NSString *ChannelRoot;
@property (nonatomic, strong) NSString *ColumnID;
@property (nonatomic, strong) NSString *CountAsks;
@property (nonatomic, strong) NSString *CountExperts;
@property (nonatomic, strong) NSString *CountInners;
@property (nonatomic, strong) NSString *CountLemmas;
@property (nonatomic, strong) NSString *CountRelates;
@property (nonatomic, strong) NSString *CountScenes;
@property (nonatomic, strong) NSString *CountStocks;
@property (nonatomic, strong) NSString *CountTracks;
@property (nonatomic, strong) NSString *CountVotes;
@property (nonatomic, strong) NSString *CreateDate;
@property (nonatomic, strong) NSString *CreaterName;
@property (nonatomic, strong) NSString *EntityPath;
@property (nonatomic, strong) NSString *Keywords;
@property (nonatomic, strong) NSString *LastDate;
@property (nonatomic, strong) NSString *LiveAddress;
@property (nonatomic, strong) NSString *LiveDate;
@property (nonatomic, strong) NSString *LiveLink;
@property (nonatomic, strong) NSString *LiveState;
@property (nonatomic, strong) NSString *NewsAddons;
@property (nonatomic, strong) NSString *NewsAuthor;
@property (nonatomic, strong) NSString *NewsBody;
@property (nonatomic, strong) NSString *NewsCover;
@property (nonatomic, strong) NSString *NewsID;
@property (nonatomic, strong) NSString *NewsLength;
@property (nonatomic, strong) NSString *NewsNotes;
@property (nonatomic, strong) NSString *NewsSource;
@property (nonatomic, strong) NSString *NewsThumbs;
@property (nonatomic, strong) NSString *NewsTitle;
@property (nonatomic, strong) NSString *NewsType;
@property (nonatomic, strong) NSString *OuterUrl;
@property (nonatomic, strong) NSString *Stocks;
@property (nonatomic, strong) NSString *Tags;
@property (nonatomic, strong) NSString *UniqueTag;
@property (nonatomic, strong) NSString *VideoUrl;
- (id)initWithNewsDetailInfo:(NSDictionary *)newsDetailInfo;
@end
