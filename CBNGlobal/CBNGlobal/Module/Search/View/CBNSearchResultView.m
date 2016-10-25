//
//  CBNSearchResultView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearchResultView.h"

@interface CBNSearchResultView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *aTableView;

@end

@implementation CBNSearchResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.aTableView];
        
    }
    return self;
}

- (UITableView *)aTableView
{
    if (!_aTableView) {
        
        self.aTableView = [[UITableView alloc] initWithFrame:self.bounds];
        
        _aTableView.backgroundColor = [UIColor blueColor];
        
        _aTableView.delegate = self;
        
        _aTableView.dataSource= self;
        
        
    }
    
    return _aTableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentfier = @"searchCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentfier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentfier];
    }
    
    cell.backgroundColor = [UIColor randomColor];
    
    return cell;
    
}


@end
