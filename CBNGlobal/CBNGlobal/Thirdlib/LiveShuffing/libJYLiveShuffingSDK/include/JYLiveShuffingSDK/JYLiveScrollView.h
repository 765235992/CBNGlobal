
#import <UIKit/UIKit.h>
#import "JYLiveShuffingModel.h"

@class JYLiveScrollView;

@protocol JYLiveScrollViewDelegate <NSObject>
@optional
/**
 *  点击了某一个对象
 */
-(void)didSelectedWithLiveShuffingModel:(JYLiveShuffingModel *)model index:(NSInteger)index;


@end

@interface JYLiveScrollView : UIView

@property (nonatomic, assign) id <JYLiveScrollViewDelegate> delegate;

/** 占位图*/
@property (nonatomic, strong) UIImage *placeholderImage;

/** 滚动延时*/
@property (nonatomic, assign) NSTimeInterval AutoScrollDelay;

@property (nonatomic, strong) UIFont *font;
/**
 *  初始化
 *
 *  @param frame      位置大小
 *
 */
- (id)initWithFrame:(CGRect)frame;



/**
 *  刷新
 *
 *  @array 直播对象
 *
 */
- (void)refreshLiveNewsWithLiveShuffingModelArray:(NSArray *)array;




- (void)stop;






@end
