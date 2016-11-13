//
//  CBNRefreshHeader.m
//  CBNGlobal
//
//  Created by Jone on 2016/11/2.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNRefreshHeader.h"
#import "JYGifImageViewSDK.h"
@interface CBNRefreshHeader ()
@property (nonatomic, strong) UILabel *promptLbabel;
@property (nonatomic, strong) JYAnimatedImageView *loadingImageView;
@property (nonatomic, strong) JYAnimatedImage *animatedImage;
@end

@implementation CBNRefreshHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    UILabel *promptLbabel = [[UILabel alloc] init];
    promptLbabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:promptLbabel];
    
    // 设置字体
    promptLbabel.font =  [UIFont refreshAndLoadingFont];
    
    
    // 设置颜色
    promptLbabel.dk_textColorPicker = DKColorPickerWithKey(refresh_And_Loading_Color);
    
    self.promptLbabel = promptLbabel;
    
    JYAnimatedImageView *loadingImageView = [[JYAnimatedImageView alloc] init];
    
    loadingImageView.frame = CGRectMake(0, 0, 30, 30);
    loadingImageView.backgroundColor = [UIColor clearColor];
    loadingImageView.contentMode = UIViewContentModeScaleAspectFit;
    loadingImageView.clipsToBounds = YES;
    [self addSubview:loadingImageView];
    
    self.loadingImageView = loadingImageView;
    NSData *data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"loaing" withExtension:@"gif"]];
    JYAnimatedImage *animatedImage = [JYAnimatedImage animatedImageWithGIFData:data];
    _animatedImage = animatedImage;

}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.loadingImageView.center = CGPointMake(self.frame.size.width*0.25, self.mj_h * 0.5);
        
    _promptLbabel.frame = self.bounds;
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
            
        case MJRefreshStateIdle:
            
            if (oldState == MJRefreshStateIdle) {
                [self RefreshStateIdleIseqal];

            }else{
                [self RefreshStateIdle];
                
            }

            break;
        case MJRefreshStatePulling:
            [self StatePulling];
            
            break;
        case MJRefreshStateRefreshing:
            
            [self RefreshStateRefreshing];
            
            break;
        default:
            break;
    }
}
- (void)RefreshStateRefreshing{
    [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
        self.promptLbabel.text = @"refresh...";
        
        _loadingImageView.animatedImage = _animatedImage;
        
    }];

}
- (void)RefreshStateIdleIseqal
{
    [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{

    } completion:^(BOOL finished) {
        
        if (self.state != MJRefreshStateIdle) return;

        _loadingImageView.image = [UIImage imageNamed:@"refresh-Arrow@2x.png"];

    }];
    
}

- (void)RefreshStateIdle
{
    _loadingImageView.image = [UIImage imageNamed:@"refresh-Arrow@2x.png"];

    [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
        self.promptLbabel.text = @"Pull to refresh...";

        _loadingImageView.transform = CGAffineTransformIdentity;
    }];
    

}
- (void)StatePulling{
    [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
        self.promptLbabel.text = @"let go refresh";

        _loadingImageView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
    }];

}
#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
//    // 1.0 0.5 0.0
//    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
    self.promptLbabel.textColor = [UIColor lightGrayColor];
}

@end
