//
//  CBNSearchField.m
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearchField.h"

@interface CBNSearchField ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *searchTextView;
@property (nonatomic, strong) UIButton *cleadButton;
@end

@implementation CBNSearchField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.searchTextView];
//        [self addSubview:self.cleadButton];
    }
    return self;
}
- (UIButton *)cleadButton
{
    if (!_cleadButton) {
        
        self.cleadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cleadButton.backgroundColor = [UIColor orangeColor];
        
        _cleadButton.frame = CGRectMake(self.frame.size.width - self.frame.size.height, 0, self.frame.size.height*0.75, self.frame.size.height*0.75);
        _cleadButton.center = CGPointMake(_cleadButton.center.x, self.frame.size.height/2);
        
    }
    
    return _cleadButton;
}
- (UITextField *)searchTextView
{
    if (!_searchTextView) {
        
        self.searchTextView = [[UITextField alloc] initWithFrame:self.bounds];
        _searchTextView.font = [UIFont fontWithSmallSzie:12 middleSize:14 bigSize:16 AndFontName:font_Name_Light];
        _searchTextView.placeholder = @"Searching...";
        _searchTextView.delegate = self;
        _searchTextView.textColor = [UIColor whiteColor];
        _searchTextView.backgroundColor = [UIColor clearColor];
        _searchTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchTextView.returnKeyType = UIReturnKeySearch;
        _searchTextView.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        _searchTextView.keyboardType = UIKeyboardTypeASCIICapable;

        _searchTextView.borderStyle = UITextBorderStyleRoundedRect;
        _searchTextView.translatesAutoresizingMaskIntoConstraints = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    
    return _searchTextView;
}
- (void)textFieldChanged:(NSNotification *)noti {
    _searchTextView.text = _searchTextView.text;
    if ([self.delegate respondsToSelector:@selector(textField:BeginEdit:)]) {
        [self.delegate textField:self BeginEdit:YES];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //返回一个BOOL值，指定是否循序文本字段开始编辑
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    if ([self.delegate respondsToSelector:@selector(textField:cancleEdit:)]) {
        [self.delegate textField:self cancleEdit:YES];
    }
    textField.text =nil;
    [textField resignFirstResponder];

    return NO;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(textField:resultString:)]) {
        [self.delegate textField:self resultString:textField.text];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];

    return YES;
}


@end
