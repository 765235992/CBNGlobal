//
//  NSDate+CBNDate.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "NSDate+CBNDate.h"

@implementation NSDate (CBNDate)
+ (NSString *)getNormalDateFromUTCDateString:(NSString *)utcDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDateString];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    
    return dateString;

}

+ (NSString *)getNormalDateFromDateString:(NSString *)aDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:aDateString];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    
    return dateString;
    
}


+ (NSString *)getHourDateFromUTCDateString:(NSString *)utcDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDateString];
    //输出格式
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
    
}

@end
