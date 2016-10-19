//
//  CBNLiveModel.h
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNLiveModel : NSObject
@property (nonatomic, strong) NSString *liveTitleString;
@property (nonatomic, strong) NSString *liveAuthorNameString;
@property (nonatomic, strong) NSString *liveTimeString;
@property (nonatomic, strong) NSString *liveContentString;
@property (nonatomic, assign) CGFloat liveCellHeight;
- (id)initWithLiveDictionary:(NSDictionary *)liveDic;
@end
