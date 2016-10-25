//
//  CBNMoreNewsModel.h
//  CBNGlobal
//
//  Created by Jone on 2016/10/24.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNMoreNewsModel : NSObject

@property (nonatomic, strong) NSString *NewsID;
@property (nonatomic, strong) NSString *NewsType;
@property (nonatomic, strong) NSString *NewsTitle;

- (id)initWithMoreNewsInfo:(NSDictionary *)info;
@end
