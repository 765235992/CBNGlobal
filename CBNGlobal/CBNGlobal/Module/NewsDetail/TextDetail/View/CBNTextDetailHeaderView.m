//
//  CBNTextDetailHeaderView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNTextDetailHeaderView.h"
#import "CBNBaseDetailHeaderView.h"


@interface CBNTextDetailHeaderView ()

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) CBNBaseDetailHeaderView *newstHeaderView;

@end

@implementation CBNTextDetailHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _height = news_Cell_Up_Or_Down_Margin;
        
        [self addSubview:self.newstHeaderView];
        
        _height = _height+ _newstHeaderView.frame.size.height + news_Cell_Up_Or_Down_Margin*0.25;

        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _height);
        
    }
    return self;
}

- (CBNBaseDetailHeaderView *)newstHeaderView
{
    if (!_newstHeaderView) {
        
        self.newstHeaderView = [[CBNBaseDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, 0)];
    
    }
    
    return _newstHeaderView;
}
- (void)setNewsDetailModel:(CBNNewsDetailModel *)newsDetailModel
{
    _newsDetailModel = newsDetailModel;
    
    _height = news_Cell_Up_Or_Down_Margin;
    
    
    _newstHeaderView.newsDetailModel = _newsDetailModel;
    
    _height = _height+ _newstHeaderView.frame.size.height ;
   
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _height);

}
@end
