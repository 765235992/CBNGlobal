
#import <UIKit/UIKit.h>
#import "JYLabelEnum.h"
@protocol JYLabelDelegate <NSObject>

@optional
- (void)jyLabel:(id)jyLabel didSelectLinkWithURL:(NSURL*)url;
@end
@interface JYLabel : UIView

@property (nonatomic, copy) NSString *text;

@property (nonatomic, unsafe_unretained) id<JYLabelDelegate> delegate;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) JYTextAlignment textAlignment;

@property (nonatomic, assign) JYTextLineBreakMode lineBreakMode;

@property (nonatomic, assign) CGFloat lineSpacing;

@property (nonatomic, assign) CGSize optimumSize;

- (void)setText:(NSString *)text;


@end







/*
 *  使用方法（一）
 *
 *
 */




