
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JYShuffingAttributeString : NSObject

@property (nonatomic, strong) UIFont *font;
+ (JYShuffingAttributeString *)sharedInstance;

- (CGFloat)getTextHeight;

- (CGSize)getSizeWithText:(NSString *)text maxSize:(CGSize)maxSize;

- (NSAttributedString *)setLiveShuffingTitleWithTitleString:(NSString *)aTitleString;

- (NSAttributedString *)setRedLiveWithAttributedString:(NSAttributedString *)aAttributedString;
@end
