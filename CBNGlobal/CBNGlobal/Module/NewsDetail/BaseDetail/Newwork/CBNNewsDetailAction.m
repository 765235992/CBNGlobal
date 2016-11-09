//
//  CBNNewsDetailAction.m
//  CBNGlobal
//
//  Created by Jone on 2016/10/22.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNNewsDetailAction.h"
#import "CBNMoreNewsModel.h"

@interface CBNNewsDetailAction (){
    NSURLSessionDataTask *dataTask;

}
@end

@implementation CBNNewsDetailAction

+ (CBNNewsDetailAction *)sharedManager
{
    static CBNNewsDetailAction *_sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedManager = [[CBNNewsDetailAction alloc] init];
    });
    return _sharedManager;
}
- (void)loadNewsDatetailWithNewsID:(NSInteger)newsID secuessed:(void (^)(CBNNewsDetailModel *newsDetailModel))secuessed failed:(void (^)(NSError *error))failed
{
    
    NSLog(@"——————————————————————————————————————————————————————————————————————————");
    if (dataTask!=nil) {
        NSLog(@"取消请求");
        [dataTask cancel];
        
    }
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
   dataTask = [manger POST:[[CBNParametersLinkManager sharedManager] readNewsWithNewsID:newsID] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        CBNNewsDetailModel *detailModel = [[CBNNewsDetailModel alloc] initWithNewsDetailInfo:dic];
        
        if (secuessed) {
            secuessed(detailModel);
        }

        [self removeTask:task];
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failed) {
            failed(error);
        }

        [self removeTask:task];
        
    }];
    [self addTask:dataTask];
    

//    [self POST:[[CBNParametersLinkManager sharedManager] readNewsWithNewsID:newsID]  parameters:nil success:^(id result) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
//
//        
//        CBNNewsDetailModel *detailModel = [[CBNNewsDetailModel alloc] initWithNewsDetailInfo:dic];
//        if (secuessed) {
//            secuessed(detailModel);
//        }
//        
//    } failed:^(NSError *error) {
//        if (failed) {
//            failed(error);
//        }
//    }];
    
}

+ (void)loadMoreNewssecuessed:(void (^)(NSArray *moreNewsArray))secuessed failed:(void (^)(NSError *error))failed
{
    [self POST:[[CBNParametersLinkManager sharedManager] rankNewsMonthURL] parameters:nil success:^(id result) {
        NSArray *moreNewsArray = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        
        if (moreNewsArray.count<5) {
            return ;
        }
        for (int i = 0; i < 5; i++) {
            CBNMoreNewsModel *tempModel = [[CBNMoreNewsModel alloc] initWithMoreNewsInfo:[moreNewsArray objectAtIndex:i]];
            [resultArray addObject:tempModel];
        }
        if (secuessed) {
            secuessed(resultArray);
        }
    } failed:^(NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}
- (NSMutableDictionary *)taskQueue
{
    NSMutableDictionary *taskDic = objc_getAssociatedObject(self, @selector(addTask:));
    
    if (!taskDic) {
        taskDic = @{}.mutableCopy;
        
        objc_setAssociatedObject(self, @selector(addTask:), taskDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
    return taskDic;
}
- (void)addTask:(NSURLSessionDataTask *)task
{
    NSMutableDictionary *taskQueue = [self taskQueue];
    
    [taskQueue setObject:task forKey:@(task.taskIdentifier)];
    
}
- (void)removeTask:(NSURLSessionDataTask *)task
{
    NSLog(@"移除走了吗？？？？？？？");
    if ([self isRequesting]) {
        NSMutableDictionary *taskQueue = [self taskQueue];
        
        [taskQueue setObject:task forKey:@(task.taskIdentifier)];
    }
}
- (BOOL)isRequesting
{
    NSMutableDictionary *taskDic = objc_getAssociatedObject(self, @selector(addTask:));
    NSLog(@"队列中的请求数据 -- %d",taskDic.allValues.count);
    if (taskDic.allValues.count > 0) {
        
        NSLog(@"队列中有请求");
        return YES;
    }
    NSLog(@"队列中没有有请求");

    return NO;
}

@end
