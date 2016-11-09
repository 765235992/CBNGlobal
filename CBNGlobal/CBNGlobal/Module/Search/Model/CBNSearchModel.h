//
//  CBNSearchModel.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/28.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNSearchModel : NSObject
@property (nonatomic, strong) NSString *author;
@property (nonatomic, assign) NSInteger channelid;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *creationDate;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *previewImage;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger typeo;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) CGFloat height;
@end
