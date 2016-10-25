//
//  CBNNewsModel.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/25.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNNewsModel : NSObject
@property (nonatomic, assign) NSInteger NewsID;
@property (nonatomic, assign) NSInteger NewsType;
@property (nonatomic, assign) NSInteger ChannelID;
@property (nonatomic, assign) NSInteger EntityNews;
@property (nonatomic, assign) NSInteger EntityChannel;
@property (nonatomic, assign) NSInteger NewsLength;
@property (nonatomic, assign) NSInteger UniqueTag;


@property (nonatomic, strong) NSString *NewsTitle;
@property (nonatomic, strong) NSString *EntityPath;
@property (nonatomic, strong) NSString *CreaterName;
@property (nonatomic, strong) NSString *NewsNotes;
@property (nonatomic, strong) NSString *NewsThumbs;
@property (nonatomic, strong) NSString *NewsSource;
@property (nonatomic, strong) NSString *NewsAuthor;
@property (nonatomic, strong) NSString *OuterUrl;
@property (nonatomic, strong) NSString *VideoUrl;
@property (nonatomic, strong) NSString *Tags;
@property (nonatomic, strong) NSString *NewsAddons;

@property (nonatomic, strong) NSString *CreateDate;
@property (nonatomic, strong) NSString *LastDate;

@property (nonatomic, assign) BOOL IsEntity;

@end
