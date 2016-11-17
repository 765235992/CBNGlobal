//
//  CBNLoadingView.m
//  CBNGlobal
//
//  Created by Jone on 2016/11/2.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLoadingView.h"
#import "JYGifImageViewSDK.h"
@interface CBNLoadingView ()

@property (nonatomic, strong) JYAnimatedImageView *loadingImageView;

@property (nonatomic, strong) UILabel *promptLabel;

@property (nonatomic, strong) UIButton *reLoadingButton;

@end

@implementation CBNLoadingView

- (void)dealloc
{
    NSLog(@"CBNLoadingView 释放");
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.loadingImageView];
        
        _loadingImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 -100);
        
        [self addSubview:self.promptLabel];
        
        [self startLoading];
        
        
    }
    
    return self;
    
}
- (void)butsecuessed
{
    [self loadingSecuessed];
}

- (void)butfailed

{
    [self loadingFailed];
    
}


- (JYAnimatedImageView *)loadingImageView
{
    if (!_loadingImageView) {

        self.loadingImageView = [[JYAnimatedImageView alloc] init];
        
        _loadingImageView.frame = CGRectMake(0, 0, 50, 50);
        _loadingImageView.backgroundColor = [UIColor clearColor];
        _loadingImageView.contentMode = UIViewContentModeScaleAspectFill;
        _loadingImageView.clipsToBounds = YES;

      
    }
    
    return _loadingImageView;
}

- (UILabel *)promptLabel
{
    if (!_promptLabel) {
        
        self.promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _loadingImageView.frame.size.height + _loadingImageView.frame.origin.y, self.frame.size.width, 44)];
        
        _promptLabel.font = [UIFont newsTitleFont];
        
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        
        
    }
    
    return _promptLabel;
}









- (void)startLoading
{
    
    NSData *data1 = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"loaing" withExtension:@"gif"]];
    JYAnimatedImage *animatedImage1 = [JYAnimatedImage animatedImageWithGIFData:data1];
    _loadingImageView.animatedImage = animatedImage1;
    
    _promptLabel.text = @" ";
    
}

- (void)loadingFailed
{
    [_loadingImageView stopAnimating];
    _loadingImageView.image = [UIImage imageNamed:@"loadingFailed-image.png"];
    _promptLabel.text = @"Loading failed";


}

- (void)loadingSecuessed
{
    [_loadingImageView stopAnimating];
    [self removeFromSuperview];
    

}











@end
