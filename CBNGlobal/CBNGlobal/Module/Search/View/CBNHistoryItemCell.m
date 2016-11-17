//
//  CBNHistoryItemCell.m
//  CBNGlobal
//
//  Created by Jone on 2016/11/14.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNHistoryItemCell.h"

@interface CBNHistoryItemCell ()

@property (nonatomic, strong) UILabel *historyLabel;

@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation CBNHistoryItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.historyLabel];
        
        [self.contentView addSubview:self.lineImageView];
        
    }
    
    return self;
}


- (UILabel *)historyLabel
{
    if (!_historyLabel) {
        
        self.historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, 10)];
        
        _historyLabel.numberOfLines = 0;
        
        _historyLabel.font = [UIFont newsTitleFont];
        
        _historyLabel.textColor = [UIColor grayColor];
        
    }
    
    return _historyLabel;
}

- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 1)];
        
        _lineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
        
    }
    
    return _lineImageView;
}


- (void)setHistoryString:(NSString *)historyString
{
    
    _historyString = historyString;
    
    [_historyLabel setNeedsDisplay];
    
    _historyLabel.text = historyString;
    
    [_historyLabel sizeToFit];
    
    
    _historyLabel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, _historyLabel.frame.size.height);
    
    
    self.frame = CGRectMake(0, 0, CBN_Screen_Width, _historyLabel.frame.size.height + 2*news_Cell_Up_Or_Down_Margin+1);
    
    _lineImageView.frame = CGRectMake(0, self.frame.size.height-1, CBN_Screen_Width, 1);
}

@end
