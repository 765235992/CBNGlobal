//
//  CBNShareLoadingView.m
//  CBNGlobal
//
//  Created by Jone on 2016/11/9.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNShareLoadingView.h"
@interface CBNShareLoadingView ()

@property (nonatomic, strong) UIView *backgroungView;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation CBNShareLoadingView

- (void)dealloc
{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, 100, 100);
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
- (UIView *)backgroungView
{
    if (!_backgroungView) {
        
        self.backgroungView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        
        _backgroungView.backgroundColor = [UIColor blackColor];
        _backgroungView.layer.cornerRadius = 8;
        _backgroungView.layer.masksToBounds = YES;
        _backgroungView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        [_backgroungView addSubview:self.activityView];
        
    }
    
    return _backgroungView;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [_activityView startAnimating];
        
        _activityView.center = CGPointMake(_backgroungView.frame.size.width/2, _backgroungView.frame.size.height/2);
        
    }
    
    return _activityView;
}
- (void)start
{
    [self addSubview:self.backgroungView];
}

- (UILabel *)promptLabel
{
    if (!_promptLabel) {
        
        self.promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 0)];
        _promptLabel.font = [UIFont relatedNewsFont];
        _promptLabel.backgroundColor = [UIColor blackColor];
        _promptLabel.textColor = [UIColor whiteColor];
        
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return _promptLabel;
}
- (void)secuessed
{
    [_activityView stopAnimating];
    [_activityView removeFromSuperview];
    [_backgroungView removeFromSuperview];
    
    [self addSubview:self.promptLabel];
    _promptLabel.text = @"share secuessed";
    [_promptLabel sizeToFit];
    _promptLabel.frame = CGRectMake(0, 0, _promptLabel.frame.size.width+_promptLabel.frame.size.height*2, _promptLabel.frame.size.height*2);
    
    _promptLabel.layer.cornerRadius = _promptLabel.frame.size.height/2;
    _promptLabel.layer.masksToBounds = YES;
    _promptLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [UIView animateWithDuration:1.5 animations:^{
        _promptLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [_promptLabel removeFromSuperview];
    }];

}
- (void)failed
{
    [_activityView stopAnimating];
    [_activityView removeFromSuperview];
    [_backgroungView removeFromSuperview];
    
    [self addSubview:self.promptLabel];
    _promptLabel.text = @"share failed";
    [_promptLabel sizeToFit];
    _promptLabel.frame = CGRectMake(0, 0, _promptLabel.frame.size.width+_promptLabel.frame.size.height*2, _promptLabel.frame.size.height*2);
    
    _promptLabel.layer.cornerRadius = _promptLabel.frame.size.height/2;
    _promptLabel.layer.masksToBounds = YES;

    _promptLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    [UIView animateWithDuration:1.5 animations:^{
        _promptLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [_promptLabel removeFromSuperview];

    }];
}
- (void)clean
{
    
}



@end
