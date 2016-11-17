//
//  CBNSearchChannelView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearchChannelView.h"

@interface CBNSearchChannelView ()
@property (nonatomic, strong) NSString *currentChannelName;
@end

@implementation CBNSearchChannelView

- (id)initWithFrame:(CGRect)frame andCurrentChannelName:(NSString *)currentChannelName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentChannelName = currentChannelName;
        self.userInteractionEnabled = YES;
        [self createChannelItems];
        
    }
    return self;
}

- (void)createChannelItems
{
    int width = 0;
    int height = 0;
    int number = 0;
    int han = 0;
    UIFont *buttonFont = [UIFont fontWithSmallSzie:14 middleSize:16 bigSize:20 AndFontName:font_Name_Blod];
    
    CGFloat buttonHeight = [NSString getTextHeightWithFont:buttonFont]*1.5;
    
    NSMutableArray *titleArr =  [[NSMutableArray alloc] init];
    CBNChannelModel *homeChannelModel = [[CBNChannelModel alloc] init];
    
    homeChannelModel.ChannelName = @"Home";
    homeChannelModel.EnglishName = @"Home";
    
    [titleArr addObject:homeChannelModel];
    NSArray *channelList = [[CBNChannelSqliteManager sharedManager] selectObjectsfromTable:@"ChannelList"];
    
    [titleArr addObjectsFromArray:[[CBNChannelSqliteManager sharedManager]dictionaryChangeToModelWithDictionaryArray:channelList] ];
    
    
    //创建button
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 300 + i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        CBNChannelModel *tempModel = titleArr[i];
        
        CGSize titleSize = [tempModel.ChannelName boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:buttonFont} context:nil].size;
        titleSize.width += buttonHeight;
        
        //自动的折行
        han = han +titleSize.width+news_Cell_Up_Or_Down_Margin;
        if (han > [[UIScreen mainScreen]bounds].size.width) {
            han = 0;
            han = han + titleSize.width;
            height++;
            width = 0;
            width = width+titleSize.width;
            number = 0;
            button.frame = CGRectMake(0, (buttonHeight+news_Cell_Up_Or_Down_Margin)*height, titleSize.width, buttonHeight);
        }else{
            button.frame = CGRectMake(width+(number*news_Cell_Up_Or_Down_Margin), (buttonHeight+news_Cell_Up_Or_Down_Margin)*height, titleSize.width, buttonHeight);
            width = width+titleSize.width;
        }
        number++;
        button.titleLabel.font = buttonFont;
        
        button.titleLabel.textAlignment =NSTextAlignmentCenter;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = buttonHeight/2;
        button.dk_backgroundColorPicker = DKColorPickerWithKey(CBN_Blue_Color);
        button.titleLabel.font = buttonFont;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:tempModel.ChannelName forState:UIControlStateNormal];
        [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.currentChannelName isEqualToString:tempModel.ChannelName]) {
            [button setTitleColor:UIColorFromRGB(0xB8B8B8) forState:UIControlStateNormal];
            button.backgroundColor = UIColorFromRGB(0x595959);
            button.tag = 500 + i;

        }
        [self addSubview:button];
        
    }
    self.frame= CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, (buttonHeight+news_Cell_Up_Or_Down_Margin)*height + buttonHeight);
    
}

- (void)button:(UIButton *)sender
{
    NSInteger tag = sender.tag - 300;
    if ([self.delegate respondsToSelector:@selector(searchChannelView:didSelectedAtIndex:)]) {
        
        [self.delegate searchChannelView:self didSelectedAtIndex:tag];
        
    }
}

@end
