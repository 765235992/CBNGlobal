//
//  CBNSearchDefaultView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearchDefaultView.h"
#import "CBNHistoryItemCell.h"

#import "CBNSearchSqliteManager.h"

@interface CBNSearchDefaultView ()<CBNSearchChannelViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *channelVerticalImageView;

@property (nonatomic, strong) UILabel *channelPromptView;

@property (nonatomic, strong) UIImageView *channelCrossIineImageView;

@property (nonatomic, strong) CBNSearchChannelView *channelView;

@property (nonatomic, strong) UILabel *historyLbel;

@property (nonatomic, strong) UIImageView *historyVerticalImageView;

@property (nonatomic, strong) UIImageView *historyCrossLineImageView;

@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation CBNSearchDefaultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.sourceArray = [[NSMutableArray array] init];

        [_sourceArray addObjectsFromArray:[[CBNSearchSqliteManager sharedManager] selectObjectsfromTable:@"search"]];
        
        
        NSLog(@"%@",self.sourceArray);
        
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.channelPromptView];
        
        [self addSubview:self.channelVerticalImageView];

        [self addSubview:self.channelCrossIineImageView];
        
        [self addSubview:self.channelView];
        
        [self addSubview:self.historyLbel];
        
        [self addSubview:self.historyVerticalImageView];
        
        [self addSubview:self.historyCrossLineImageView];
        
        [self addSubview:self.deleteButton];
        
        [self addSubview:self.aTableView];
        
        [self.aTableView reloadData];
        
        self.dk_backgroundColorPicker = DKColorPickerWithKey(defaule_Background_Color);

    }
    return self;
}


- (UILabel *)channelPromptView
{
    if (!_channelPromptView) {
        
        self.channelPromptView = [[UILabel alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, news_Cell_Up_Or_Down_Margin, 100, 0)];
        
        _channelPromptView.font = [UIFont fontWithSmallSzie:14 middleSize:16 bigSize:18 AndFontName:font_Name_Blod];
        
        _channelPromptView.dk_textColorPicker = DKColorPickerWithKey(news_Small_Tag_Color);

        _channelPromptView.text = @"channel";
        
        [_channelPromptView sizeToFit];
        
        _channelPromptView.frame = CGRectMake(news_Cell_Left_Or_Right_Margin*2+5, news_Cell_Up_Or_Down_Margin, _channelPromptView.frame.size.width, _channelPromptView.frame.size.height);
        
    }
    
    return _channelPromptView;
}
- (UIImageView *)channelVerticalImageView
{
    if (!_channelVerticalImageView) {
        
        self.channelVerticalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _channelPromptView.frame.origin.y, 5, _channelPromptView.frame.size.height)];
        
        _channelVerticalImageView.backgroundColor = UIColorFromRGB(0x0096d9);
        
        _channelVerticalImageView.layer.cornerRadius = 2.5;
        
    }
    
    return _channelVerticalImageView;
}

- (UIImageView *)channelCrossIineImageView
{
    if (!_channelCrossIineImageView) {
        
        self.channelCrossIineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _channelPromptView.frame.size.height+_channelPromptView.frame.origin.y+news_Cell_Up_Or_Down_Margin, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, 1)];
        
        _channelCrossIineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
        
    }
    
    return _channelCrossIineImageView;
}

- (CBNSearchChannelView *)channelView
{
    if (!_channelView) {
        
        self.channelView = [[CBNSearchChannelView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _channelCrossIineImageView.frame.size.height+_channelCrossIineImageView.frame.origin.y+news_Cell_Up_Or_Down_Margin, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, 0)];
        _channelView.delegate = self;
        
    }
    
    return _channelView;
}
- (void)searchChannelView:(CBNSearchChannelView *)searchChannelView didSelectedAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(searchDefaultView:channelDidSelectedAtIndex:)]) {
        [self.delegate searchDefaultView:self channelDidSelectedAtIndex:index];
    }
}



- (UILabel *)historyLbel
{
    if (!_historyLbel) {
        
        self.historyLbel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _historyLbel.font = [UIFont fontWithSmallSzie:14 middleSize:16 bigSize:18 AndFontName:font_Name_Blod];
        
        _historyLbel.dk_textColorPicker = DKColorPickerWithKey(news_Small_Tag_Color);
        
        _historyLbel.text = @"history";
        
        [_historyLbel sizeToFit];
        
        _historyLbel.frame = CGRectMake(news_Cell_Left_Or_Right_Margin*2+5, _channelView.frame.size.height+_channelView.frame.origin.y+news_Cell_Up_Or_Down_Margin*3, _channelPromptView.frame.size.width, _channelPromptView.frame.size.height);
        

        
    }
    
    return _historyLbel;
}


- (UIImageView *)historyVerticalImageView
{
    if (!_historyVerticalImageView) {
        self.historyVerticalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _historyLbel.frame.origin.y, 5, _historyLbel.frame.size.height)];
        
        _historyVerticalImageView.backgroundColor = UIColorFromRGB(0x0096d9);
        
        _historyVerticalImageView.layer.cornerRadius = 2.5;
    }
    
    return _historyVerticalImageView;
}


- (UIImageView *)historyCrossLineImageView
{
    if (!_historyCrossLineImageView) {
        
        self.historyCrossLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(news_Cell_Left_Or_Right_Margin, _historyLbel.frame.size.height+_historyLbel.frame.origin.y+news_Cell_Up_Or_Down_Margin, CBN_Screen_Width-2*news_Cell_Left_Or_Right_Margin, 1)];
        
        _historyCrossLineImageView.dk_backgroundColorPicker = DKColorPickerWithKey(news_Cell_Divider_Color);
        
    }
    
    return _historyCrossLineImageView;
}
- (void)setSearchKeywordString:(NSString *)searchKeywordString
{
    
    
    _searchKeywordString = searchKeywordString;
   _searchKeywordString = [_searchKeywordString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *newString = [_searchKeywordString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (newString.length==0) {
        return;
    }
 
    NSDictionary *dic = @{@"result":newString};
    NSArray *arr = [[CBNSearchSqliteManager sharedManager] selectObjectsfromTable:@"search"];
    
    if ([arr indexOfObject:dic]!=NSNotFound) {
    }else{
        [[CBNSearchSqliteManager sharedManager] insertObjects:newString intoTable:@"search"];

    }
    
//    [_sourceArray setObject:dic atIndexedSubscript:0];
    [_sourceArray addObject:dic];
    [_aTableView reloadData];
    

}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _deleteButton.frame = CGRectMake(CBN_Screen_Width-news_Cell_Left_Or_Right_Margin-_historyVerticalImageView.frame.size.height, _historyVerticalImageView.frame.origin.y, _historyVerticalImageView.frame.size.height*1.5, _historyVerticalImageView.frame.size.height*1.5) ;
        
        [_deleteButton addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_deleteButton setImage:[UIImage imageNamed:@"delete-image.png"] forState:UIControlStateNormal];
        
        [_deleteButton setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];

        _deleteButton.backgroundColor = [UIColor clearColor];
    }
    
    return _deleteButton;
}


- (void)deleteButton:(UIButton *)sender
{
    
    [[CBNSearchSqliteManager sharedManager] cleanTableWithTableName:@"search"];
    
    [_sourceArray removeAllObjects];
    
    [_aTableView reloadData];
    
    
}
- (UITableView *)aTableView
{
    if (!_aTableView) {
        
        self.aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _historyCrossLineImageView.frame.size.height+_historyCrossLineImageView.frame.origin.y, CBN_Screen_Width, self.frame.size.height - (_historyCrossLineImageView.frame.size.height+_historyCrossLineImageView.frame.origin.y))];
        _aTableView.backgroundColor = [UIColor clearColor];
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _aTableView.scrollEnabled = YES;
        _aTableView.delegate = self;
        _aTableView.dataSource = self;

    }
    
    return _aTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *kCellID = @"cellID";
    
    CBNHistoryItemCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    if (cell == nil) {
        cell = [[CBNHistoryItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
        
        cell.backgroundColor = [UIColor clearColor];
        

    }
    cell.historyString = [[_sourceArray objectAtIndex:indexPath.row] objectForKey:@"result"];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *historyText = [[_sourceArray objectAtIndex:indexPath.row] objectForKey:@"result"];

    if ([self.delegate respondsToSelector:@selector(historySearchText:)]) {
        [self.delegate historySearchText:historyText];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CBNHistoryItemCell *cell = (CBNHistoryItemCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
    
}

@end
