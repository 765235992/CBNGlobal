//
//  CBNNetPromptView.m
//  CBNGlobal
//
//  Created by Jone on 2016/11/25.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNNetPromptView.h"


@interface CBNNetPromptView ()
@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation CBNNetPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.promptLabel];
        
    }
    return self;
}

- (UILabel *)promptLabel
{
    if (!_promptLabel) {
        
        self.promptLabel = [[UILabel alloc] initWithFrame:self.frame];
        
        _promptLabel.textAlignment = 1;
        
        _promptLabel.font = [UIFont newsContentFont];
        
        _promptLabel.textColor = [UIColor whiteColor];
        
    }
    
    return _promptLabel;
}

- (void)networkStateIsNormal
{
    
    self.alpha = 1.0;
    
    _promptLabel.text = @"connected";
    
    self.dk_backgroundColorPicker = DKColorPickerWithKey(promptNormal);
    
    [UIView animateWithDuration:3.0 animations:^{
        
        self.alpha = 0.0;

    } completion:^(BOOL finished) {
        
    }];

}


- (void)networkStatusIsAbnormal
{
    self.alpha = 1.0;
    
    _promptLabel.text = @"No Internet Connection";
    
    self.dk_backgroundColorPicker = DKColorPickerWithKey(promptRed);
    
    [UIView animateWithDuration:10.0 animations:^{
        
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
    }];

}

@end
