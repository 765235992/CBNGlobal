
#import <Foundation/Foundation.h>
#import "JYAnimatedImageView.h"
extern const NSTimeInterval kJYAnimatedImageDelayTimeIntervalMinimum;


#ifndef NS_DESIGNATED_INITIALIZER
#if __has_attribute(objc_designated_initializer)
#define NS_DESIGNATED_INITIALIZER __attribute((objc_designated_initializer))
#else
#define NS_DESIGNATED_INITIALIZER
#endif
#endif
@interface JYAnimatedImage : NSObject
@property (nonatomic, strong, readonly) UIImage *posterImage;
@property (nonatomic, assign, readonly) CGSize size;
@property (nonatomic, assign, readonly) NSUInteger loopCount;
@property (nonatomic, strong, readonly) NSDictionary *delayTimesForIndexes;
@property (nonatomic, assign, readonly) NSUInteger frameCount;
@property (nonatomic, assign, readonly) NSUInteger frameCacheSizeCurrent;
@property (nonatomic, assign) NSUInteger frameCacheSizeMax;

- (UIImage *)imageLazilyCachedAtIndex:(NSUInteger)index;
+ (CGSize)sizeForImage:(id)image;
- (instancetype)initWithAnimatedGIFData:(NSData *)data;
- (instancetype)initWithAnimatedGIFData:(NSData *)data optimalFrameCacheSize:(NSUInteger)optimalFrameCacheSize predrawingEnabled:(BOOL)isPredrawingEnabled NS_DESIGNATED_INITIALIZER;
+ (instancetype)animatedImageWithGIFData:(NSData *)data;
@property (nonatomic, strong, readonly) NSData *data;

@end

typedef NS_ENUM(NSUInteger, JYLogLevel) {
    JYLogLevelNone = 0,
    JYLogLevelError,
    JYLogLevelWarn,
    JYLogLevelInfo,
    JYLogLevelDebug,
    JYLogLevelVerbose
};

@interface JYAnimatedImage (Logging)

+ (void)setLogBlock:(void (^)(NSString *logString, JYLogLevel logLevel))logBlock logLevel:(JYLogLevel)logLevel;
+ (void)logStringFromBlock:(NSString *(^)(void))stringBlock withLevel:(JYLogLevel)level;

@end

#define JYLog(logLevel, format, ...) [JYAnimatedImage logStringFromBlock:^NSString *{ return [NSString stringWithFormat:(format), ## __VA_ARGS__]; } withLevel:(logLevel)]

@interface JYWeakProxy : NSProxy

+ (instancetype)weakProxyForObject:(id)targetObject;

@end

