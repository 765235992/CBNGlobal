//
//  CBNSearcnView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearcnView.h"
#import "CBNSearchField.h"
@interface CBNSearcnView ()<CBNSearchFieldDelegate>
@property (nonatomic, strong) CBNSearchField *searchField;

@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation CBNSearcnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self addSubview:self.searchField];
        
        [self addSubview:self.cancelButton];
    }
    return self;
}

- (CBNSearchField *)searchField
{
    if (!_searchField) {
        
        self.searchField = [[CBNSearchField alloc] initWithFrame:CGRectMake(15, 0, CBN_Screen_Width-40-50, 25)];
        _searchField.layer.cornerRadius = _searchField.frame.size.height/2;

        _searchField.delegate = self;
        
        _searchField.backgroundColor = [UIColor grayColor];
        
        _searchField.center = CGPointMake(_searchField.center.x, 44/2);
    }
    
    return _searchField;
}

- (void)textField:(CBNSearchField *)textField resultString:(NSString *)resultString
{
    if ([self.delegate respondsToSelector:@selector(searchView:searchText:)]) {
        [self.delegate searchView:self searchText:resultString];
        
    }
}
- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cancelButton.frame = CGRectMake(CBN_Screen_Width-15 - 50, 0, 50, 44);
        
        _cancelButton.center = CGPointMake(_cancelButton.center.x, 44/2);
        
        [_cancelButton setTitle:@"cancle" forState:UIControlStateNormal];
        
        _cancelButton.titleLabel.font = [UIFont fontWithSmallSzie:14 middleSize:16 bigSize:18 AndFontName:font_Name_Light];
        
        _cancelButton.dk_tintColorPicker = DKColorPickerWithColors(UIColorFromRGB(0x000000),UIColorFromRGB(0x000000),UIColorFromRGB(0x000000));
        
        [_cancelButton addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _cancelButton;
}

- (void)cancelButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(searchView:cancleButtonClicked:)]) {
        [self.delegate searchView:self cancleButtonClicked:sender];
        
    }
}
- (void)textField:(CBNSearchField *)textField BeginEdit:(BOOL)beginEdit
{
    if ([self.delegate respondsToSelector:@selector(searchView:BeginEdit:)]) {
        [self.delegate searchView:self BeginEdit:beginEdit];
    }
}

- (void)textField:(CBNSearchField *)textField cancleEdit:(BOOL)cancleEdit
{
    if ([self.delegate respondsToSelector:@selector(searchView:cancleEdit:)]) {
        [self.delegate searchView:self cancleEdit:cancleEdit];
    }
}

@end
