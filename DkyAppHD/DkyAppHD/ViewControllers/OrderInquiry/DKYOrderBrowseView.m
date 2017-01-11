//
//  DKYOrderBrowseView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderBrowseView.h"
#import "KLCPopup.h"
#import "DKYOrderBrowserViewCell.h"

@interface DKYOrderBrowseView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) KLCPopup *popup;

@property (nonatomic, weak) UIView *titleView;

@property (nonatomic, weak) UIButton *closeBtn;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation DKYOrderBrowseView

+ (instancetype)show{
    DKYOrderBrowseView *contentView = [[DKYOrderBrowseView alloc]initWithFrame:CGRectZero];
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeBounceInFromTop
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    popup.dimmedMaskAlpha = 0.6;
    contentView.popup = popup;

    [popup show];
    return contentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)dismiss{
    [self.popup dismiss:YES];
}

- (void)setDetailOrders:(NSArray *)detailOrders{
    _detailOrders = [detailOrders copy];
    
    [self.tableView reloadData];
}

#pragma mark - action method

- (void)closeBtnClicked:(UIButton*)sender{
    [self dismiss];
}

#pragma mark - UI
- (void)commonInit{
    self.bounds = CGRectMake(0, 0, 514, 610);
    self.backgroundColor = [UIColor whiteColor];
    
    [self setupTitleView];
    [self setupCloseBtn];
    [self setupTableView];
}

- (void)setupTitleView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:view];
    self.titleView = view;
    view.backgroundColor = [UIColor colorWithHex:0x3C3362];
    WeakSelf(weakSelf);
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(60);
    }];
}

- (void)setupCloseBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:btn];
    self.closeBtn = btn;

    [btn setBackgroundImage:[UIImage imageNamed:@"close_icon"] forState:UIControlStateNormal];
    
    WeakSelf(weakSelf);
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(weakSelf.titleView);
        make.right.mas_equalTo(weakSelf.titleView.mas_right).with.offset(-18);
        make.width.mas_equalTo(32);
    }];
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.backgroundColor = [UIColor whiteColor];
    self.tableView = tableView;
    [self addSubview:tableView];
    
    WeakSelf(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleView.mas_bottom);
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
    }];
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailOrders.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKYOrderBrowserViewCell *cell = [DKYOrderBrowserViewCell orderBrowserViewCellWithTableView:tableView];
    cell.itemModel = [self.detailOrders objectOrNilAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
