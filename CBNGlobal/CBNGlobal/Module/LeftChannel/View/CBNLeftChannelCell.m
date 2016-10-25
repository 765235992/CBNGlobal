//
//  CBNLeftChannelCell.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLeftChannelCell.h"

#define left_margn 20.0f
#define channel_Cell_Height 2*[NSString getTextHeightWithFont:[UIFont newsTitleFont]]
@interface CBNLeftChannelCell ()

@property (nonatomic, strong) UIImageView *channelIconImageView;
@property (nonatomic, strong) UILabel *channelTitleLabel;
@property (nonatomic, strong) UIImageView *channelLineImageView;

@end

@implementation CBNLeftChannelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
      
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, channel_Cell_Height);
        
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.channelIconImageView];
        _channelIconImageView.center = CGPointMake(_channelIconImageView.center.x, channel_Cell_Height/2);
        
        [self addSubview:self.channelTitleLabel];
        
        [self addSubview:self.channelLineImageView];
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

    if (selected) {
        
        _channelTitleLabel.textColor = [UIColor whiteColor];

    }else{
        _channelTitleLabel.textColor = [UIColor lightGrayColor];

    }
}

- (UIImageView *)channelIconImageView
{
    if (!_channelIconImageView) {
        
        self.channelIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(left_margn, channel_Cell_Height/2, channel_Cell_Height/2, channel_Cell_Height/2)];
//        _channelIconImageView.backgroundColor = [UIColor randomColor];
        _channelIconImageView.image = [UIImage imageNamed:@"langy_maichu@2x.png"];

    }
    
    return _channelIconImageView;
}

- (UILabel *)channelTitleLabel
{
    if (!_channelTitleLabel) {
        
        self.channelTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_margn*2+_channelIconImageView.frame.size.width, 0, user_Draw_open_With-2*left_margn, channel_Cell_Height)];
        
        _channelTitleLabel.textColor = [UIColor whiteColor];
        
        _channelTitleLabel.backgroundColor = [UIColor clearColor];
        
        _channelTitleLabel.text = @"Chinese";
    }
    
    return _channelTitleLabel;
}

- (UIImageView *)channelLineImageView
{
    if (!_channelLineImageView) {
       
        self.channelLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(left_margn/2, channel_Cell_Height-1, user_Draw_open_With - left_margn, 1)];
        
        _channelLineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
        _channelLineImageView.backgroundColor = [UIColor grayColor];
        
    }
    
    return _channelLineImageView;
}

- (void)setChannelModel:(CBNChannelMoel *)channelModel
{
    _channelModel = channelModel;
    
    _channelTitleLabel.text = _channelModel.ChannelName;
    
}
@end
