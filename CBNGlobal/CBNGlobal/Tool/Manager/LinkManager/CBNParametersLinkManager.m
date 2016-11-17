//
//  CBNParametersLinkManager.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/26.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNParametersLinkManager.h"
#define k_Base_URLString(type) [NSString stringWithFormat:@"https://appcdn.yicai.com/handler/cbnglobal/%@.ashx?",type]
#define k_Base_URLKey @"wuTbBGxk1J8NTzye"
#define k_Base_NewsCover_URl @"http://imgcdn.yicai.com/uppics/slides/"//图片拼接网址


@implementation CBNParametersLinkManager
+ (CBNParametersLinkManager *)sharedManager
{
    static CBNParametersLinkManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[CBNParametersLinkManager alloc] init];
    });
    return _sharedManager;
}
- (NSString *)channelURL
{
    
    
    NSString *str = [NSString stringWithFormat:@"GetChannels%@",k_Base_URLKey];
    
    NSString *urlString = [NSString stringWithFormat:@"%@check=%@",k_Base_URLString(@"GetChannels"),[NSString getTheMD5EncryptedStringWithString:str]];
    
    return urlString;
}
- (NSString *)getNewsListURLWithRootlID:(NSInteger)channelID page:(NSInteger)page pageSize:(NSInteger)pageSize
{
    
    NSString *str = [NSString stringWithFormat:@"%ld%ld%ld%@",(long)channelID,(long)pageSize,(long)page,k_Base_URLKey];
    
    NSString *urlString = [NSString stringWithFormat:@"%@cid=%ld&pagesize=%ld&page=%ld&check=%@",k_Base_URLString(@"GetNewsListByRootId"),(long)channelID,(long)pageSize,(long)page,[NSString getTheMD5EncryptedStringWithString:str]];
    
    return urlString;
    
}

- (NSString *)getNewsListURLWithChannelID:(NSInteger)channelID page:(NSInteger)page pageSize:(NSInteger)pageSize
{
    
    NSString *str = [NSString stringWithFormat:@"%ld%ld%ld%@",(long)channelID,(long)pageSize,(long)page,k_Base_URLKey];
    
    NSString *urlString = [NSString stringWithFormat:@"%@cid=%ld&pagesize=%ld&page=%ld&check=%@",k_Base_URLString(@"GetNewsListByChannelId"),(long)channelID,(long)pageSize,(long)page,[NSString getTheMD5EncryptedStringWithString:str]];
    
    return urlString;
    
}
- (NSString *)getNewsThumbName:(NSString *)newsThumb
{
    NSString *imageURL = [NSString stringWithFormat:@"%@%@@320w_213h_1e_1c",k_Base_NewsCover_URl,newsThumb];
    return imageURL;
}
- (NSString *)getOriginalNewsThumbName:(NSString *)newsThumb
{
    NSString *imageURL = [NSString stringWithFormat:@"http://cmss.yicai.com/uppics/slides/%@",newsThumb];
    return imageURL;
}
- (NSString *)readNewsWithNewsID:(NSInteger)newsID
{
    
    NSString *str = [NSString stringWithFormat:@"%ld%@",(long)newsID,k_Base_URLKey];
    
    NSString *urlString = [NSString stringWithFormat:@"%@nid=%ld&check=%@",k_Base_URLString(@"GetNews"),(long)newsID,[NSString getTheMD5EncryptedStringWithString:str]];
    CBNLog(@"%@",urlString);
    
    return urlString;
    
}
- (NSString *)rankNewsMonthURL
{
    NSString *str = [NSString stringWithFormat:@"10%@",k_Base_URLKey];
    
    NSString *urlString = [NSString stringWithFormat:@"%@type=10&check=%@",k_Base_URLString(@"GetRankNewsMonth"),[NSString getTheMD5EncryptedStringWithString:str]];
    
    return urlString;
    
}

- (NSString *)searchWithKeyword:(NSString *)keyword page:(NSInteger)page pageSize:(NSInteger)pagesize
{
    
    NSString* keywordResultSring=keyword;
    keywordResultSring = [keywordResultSring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    keywordResultSring = [keywordResultSring stringByReplacingOccurrencesOfString:@" " withString:@""];
    keywordResultSring = [keywordResultSring stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *urlStr  = [NSString stringWithFormat:@"http://www.yicai.com/api/appsearch/?type=108contenttype=0&searchKeyWords=%@&start=%ld&pagecount=%ld",keywordResultSring,(long)page,(long)pagesize];
    
    CBNLog(@"%@",urlStr);
    
    return urlStr;
}



@end
