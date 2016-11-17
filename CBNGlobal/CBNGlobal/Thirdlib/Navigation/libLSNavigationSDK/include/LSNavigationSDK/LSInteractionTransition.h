
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UIViewController+LSNavigationBarTransition.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface LSStack : NSObject
- (id)getTop;
- (void)push:(id)obj;
- (void)pop;
@end

@interface LSInteractionTransition : NSObject<UIViewControllerInteractiveTransitioning,UIViewControllerAnimatedTransitioning>
- (void)updateWithPercent:(CGFloat)percent;

- (void)finishBy:(BOOL)finished;
@end


