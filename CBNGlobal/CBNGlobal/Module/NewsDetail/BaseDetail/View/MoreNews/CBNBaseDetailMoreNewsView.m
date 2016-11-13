//
//  CBNBaseDetailMoreNewsView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/18.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNBaseDetailMoreNewsView.h"
#import "CBNMoreNewsHeaderView.h"
#import "CBNRelatedNewsItemView.h"
#import "CBNMoreNewsModel.h"

@interface CBNBaseDetailMoreNewsView ()
@property (nonatomic, strong) CBNMoreNewsHeaderView *headerView;
@end

@implementation CBNBaseDetailMoreNewsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerView];
//        [self setRelatedNewsItemsView];
        
    }
    return self;
}

- (CBNMoreNewsHeaderView *)headerView
{
    if (!_headerView) {
        
        self.headerView = [[CBNMoreNewsHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, [NSString getTextHeightWithFont:[UIFont newsTitleFont]]+2*news_Cell_Up_Or_Down_Margin+2)];
    }
    
    return _headerView;
}
- (void)tap:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(moreNewsView:selectedAtIndex:)]) {
        [self.delegate moreNewsView:self selectedAtIndex:sender.view.tag];
    }
}
- (void)setMoreNewsArray:(NSArray *)moreNewsArray
{
    _moreNewsArray = moreNewsArray;
    
    CGFloat height = _headerView.frame.size.height;
    for (int i = 0; i < _moreNewsArray.count; i++) {
        
        CBNMoreNewsModel *tempModel = [_moreNewsArray objectAtIndex:i];
        
        CBNRelatedNewsItemView *tempNewsItemView = [[CBNRelatedNewsItemView alloc] initWithFrame:CGRectMake(0, height, CBN_Screen_Width, 0)];
        tempNewsItemView.index =  i+1;
        tempNewsItemView.newsTitleString = [NSString stringWithFormat:@"%@",tempModel.NewsTitle];
        
        [self addSubview:tempNewsItemView];
        tempNewsItemView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [tempNewsItemView addGestureRecognizer:tap];
        
        height = height + tempNewsItemView.frame.size.height;
        
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, CBN_Screen_Width, height);

}


@end
