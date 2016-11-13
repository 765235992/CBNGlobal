//
//  CBNSearchResultView.m
//  CBNGlobal
//
//  Created by Jone on 16/10/20.
//  Copyright © 2016年 上海第一财经传媒有限公司. All rights reserved.
//

#import "CBNSearchResultView.h"
#import "CBNSearchCell.h"

@interface CBNSearchResultView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *aTableView;
@property (nonatomic, strong) NSMutableArray *resultArray;
@end

@implementation CBNSearchResultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.resultArray = [[NSMutableArray alloc] init];
        self.dk_backgroundColorPicker = DKColorPickerWithKey(defaule_Background_Color);

        [self addSubview:self.aTableView];
        
        
    }
    return self;
}
- (void)setupTableView
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSearchNewsDataFromSever)];
    
    [footer setTitle:@"Pull up to load more…" forState:MJRefreshStateIdle];
    
    [footer setTitle:@"Loading more news…" forState:MJRefreshStateRefreshing];
    
    [footer setTitle:@"No more news" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont refreshAndLoadingFont];
    //
    //    // 设置颜色
    footer.stateLabel.dk_textColorPicker = DKColorPickerWithKey(refresh_And_Loading_Color);
    // 设置footer
    self.aTableView.mj_footer = footer;

}
- (void)loadMoreSearchNewsDataFromSever
{
    if ([self.delegate respondsToSelector:@selector(loadMoreNews)]) {
        
        [self.delegate loadMoreNews];
        
    }
}
- (UITableView *)aTableView
{
    if (!_aTableView) {
        
        self.aTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CBN_Screen_Width, CBN_Screen_Height-64)];
        
        _aTableView.dk_backgroundColorPicker = DKColorPickerWithKey(defaule_Background_Color);
        
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _aTableView.delegate = self;
        
        _aTableView.dataSource= self;
        
        
    }
    
    return _aTableView;
}
- (void)setSourceArray:(NSMutableArray *)sourceArray
{
    
    _sourceArray = sourceArray;
    
    [self.resultArray removeAllObjects];
    [self.resultArray addObjectsFromArray:_sourceArray];
    
    
    if (_resultArray.count < 10) {
        [_aTableView reloadData];

        [_aTableView.mj_footer endRefreshingWithNoMoreData];
        
    }else{
        [self setupTableView];

        [_aTableView reloadData];

        [_aTableView.mj_footer endRefreshing];
        
    }


    
}

- (void)setMoreNewsArray:(NSMutableArray *)moreNewsArray
{
    _moreNewsArray = moreNewsArray;
    if (_moreNewsArray.count == 0) {
        
        [_aTableView.mj_footer endRefreshingWithNoMoreData];
        
    }
    [self.resultArray addObjectsFromArray:_moreNewsArray];
    [_aTableView reloadData];
    [_aTableView.mj_footer endRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentfier = @"CBNSearchCell";
    CBNSearchModel *searchModel = [_resultArray objectAtIndex:indexPath.row];

    CBNSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:indentfier];
    
    if (cell == nil) {
        
        cell = [[CBNSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentfier];
    }
    
    
    cell.searchModel = searchModel;
    
    searchModel = cell.searchModel;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CBNSearchCell *cell = (CBNSearchCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBNSearchModel *searchModel = [_resultArray objectAtIndex:indexPath.row];
    CBNNewsModel *model = [[CBNNewsModel alloc] init];
    model.NewsID = searchModel.id;
    model.NewsType =  10;
    
    if ([self.delegate respondsToSelector:@selector(tableViewSelectedWithNewsModel:)]) {
        [self.delegate tableViewSelectedWithNewsModel:model];
        
    }
}
@end
