//
//  CBNChannelModel.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/25.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNChannelModel : NSObject
@property (nonatomic, strong) NSString *ChannelID;
@property (nonatomic, strong) NSString *ChannelName;
@property (nonatomic, strong) NSString *EnglishName;
@property (nonatomic, strong) NSString *RootID;
@property (nonatomic, strong) NSString *RootName;
@property (nonatomic, strong) NSString *ChannelMemo;
@property (nonatomic, strong) NSString *ChannelSeo;

@end
