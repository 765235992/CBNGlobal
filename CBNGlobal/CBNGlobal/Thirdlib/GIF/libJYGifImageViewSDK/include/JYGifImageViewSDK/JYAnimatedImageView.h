
#import <UIKit/UIKit.h>
@class JYAnimatedImage;
@interface JYAnimatedImageView : UIImageView
@property (nonatomic, strong) JYAnimatedImage *animatedImage;
@property (nonatomic, copy) void(^loopCompletionBlock)(NSUInteger loopCountRemaining);
@property (nonatomic, strong, readonly) UIImage *currentFrame;
@property (nonatomic, assign, readonly) NSUInteger currentFrameIndex;
@property (nonatomic, copy) NSString *runLoopMode;

@end
