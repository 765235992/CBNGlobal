//
//  CBNLeftChannelCell.m
//  CBNGlobal
//
//  Created by Jone on 16/10/17.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNLeftChannelCell.h"

#define left_margn 20.0f
@interface CBNLeftChannelCell ()


@property (nonatomic, strong) UILabel *channelTitleLabel;
@property (nonatomic, strong) UIImageView *channelLineImageView;

@end

@implementation CBNLeftChannelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
      
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.channelTitleLabel];
        
        [self addSubview:self.channelLineImageView];
    }
    
    return self;
}


- (UILabel *)channelTitleLabel
{
    if (!_channelTitleLabel) {
        
        self.channelTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(left_margn, 0, user_Draw_open_With-2*left_margn, 49)];
        
        _channelTitleLabel.textColor = [UIColor whiteColor];
        
        _channelTitleLabel.backgroundColor = [UIColor clearColor];
        
        _channelTitleLabel.text = @"Chinese";
    }
    
    return _channelTitleLabel;
}

- (UIImageView *)channelLineImageView
{
    if (!_channelLineImageView) {
       
        self.channelLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(left_margn/2, 49, user_Draw_open_With - left_margn, 1)];
        
        _channelLineImageView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _channelLineImageView;
}

- (void)setChannelInfo:(NSDictionary *)channelInfo
{
    _channelTitleLabel.text = [channelInfo objectForKey:@"newsChannelTitle"];

}
@end
