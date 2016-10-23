//
//  CBNNewsItemModel.h
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBNNewsItemModel.h"

@interface CBNNewsItemModel : NSObject
@property (nonatomic, strong) NSString *ChannelID;
@property (nonatomic, strong) NSString *CreateDate;
@property (nonatomic, strong) NSString *CreaterName;
@property (nonatomic, strong) NSString *EntityChannel;
@property (nonatomic, strong) NSString *EntityNews;
@property (nonatomic, strong) NSString *EntityPath;
@property (nonatomic, strong) NSString *IsEntity;
@property (nonatomic, strong) NSString *LastDate;
@property (nonatomic, strong) NSString *NewsAddons;
@property (nonatomic, strong) NSString *NewsAuthor;
@property (nonatomic, strong) NSString *NewsID;
@property (nonatomic, strong) NSString *NewsLength;
@property (nonatomic, strong) NSString *NewsNotes;
@property (nonatomic, strong) NSString *NewsSource;
@property (nonatomic, strong) NSString *NewsThumbs;
@property (nonatomic, strong) NSString *NewsTitle;
@property (nonatomic, strong) NSString *NewsType;
@property (nonatomic, strong) NSString *OuterUrl;
@property (nonatomic, strong) NSString *Tags;
@property (nonatomic, strong) NSString *UniqueTag;
@property (nonatomic, strong) NSString *VideoUrl;
- (id)initWichNewsItemInfo:(NSDictionary *)newsItemoInfo;
@end
