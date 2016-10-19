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

@property (nonatomic, strong) UIImageView *newsThumbView;

@end

@implementation CBNTextDetailHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _height = news_Cell_Up_Or_Down_Margin;
        
        [self addSubview:self.newstHeaderView];
        
        _height = _height+ _newstHeaderView.frame.size.height + news_Cell_Up_Or_Down_Margin*0.25;
        
        [self addSubview:self.newsThumbView];
        
        _height = _height+_newsThumbView.frame.size.height + news_Cell_Up_Or_Down_Margin;

        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _height);
        
    }
    return self;
}

- (CBNBaseDetailHeaderView *)newstHeaderView
{
    if (!_newstHeaderView) {
        
        self.newstHeaderView = [[CBNBaseDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, 0)];
        _newstHeaderView.titleString = @"Duterte: China deserves respect it now enjoys taoday";
        _newstHeaderView.authorNameString = @"Xinhua";
        _newstHeaderView.timeString = @"2016-10-18";
    }
    
    return _newstHeaderView;
}

- (UIImageView *)newsThumbView
{
    if (!_newsThumbView) {
        
        self.newsThumbView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _height, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, CBN_Screen_Width*0.6)];
        _newsThumbView.image = [UIImage imageNamed:@"defaultImage.jpg"];
        
        
    }
    
    return _newsThumbView;
}

@end
