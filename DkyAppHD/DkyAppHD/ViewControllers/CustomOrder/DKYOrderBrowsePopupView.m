//
//  DKYOrderBrowsePopupView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/5/15.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderBrowsePopupView.h"
#import "KLCPopup.h"
#import "DKYOrderBrowsePopupViewCell.h"
#import "DKYOrderBrowseFooterView.h"

@interface DKYOrderBrowsePopupView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) KLCPopup *popup;

@property (nonatomic, weak) UIView *titleView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) DKYOrderBrowseFooterView *footerView;

@end

@implementation DKYOrderBrowsePopupView

+ (instancetype)show{
    DKYOrderBrowsePopupView *contentView = [[DKYOrderBrowsePopupView alloc]initWithFrame:CGRectZero];
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeBounceInFromTop
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:NO
                               dismissOnContentTouch:NO];
    popup.dimmedMaskAlpha = 0.6;
    contentView.popup = popup;
    
    [popup show];
    return contentView;
}

+ (instancetype)showWithcreateOrderBtnBlock:(BlockWithSender)createOrderBtnClicked cancelBtnBlock:(BlockWithSender)cancelBtnClicked{
    DKYOrderBrowsePopupView *view = [DKYOrderBrowsePopupView show];
    view.createOrderBtnClicked = createOrderBtnClicked;
    view.cancelBtnClicked = cancelBtnClicked;
    return view;
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

#pragma mark - action method

- (void)closeBtnClicked:(UIButton*)sender{
    [self dismiss];
}

#pragma mark - UI
- (void)commonInit{
    self.bounds = CGRectMake(0, 0, 514, 550);
    self.backgroundColor = [UIColor whiteColor];
    
    [self setupTitleView];
    [self setupTitleLabel];
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

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.titleView addSubview:label];
    self.titleLabel = label;
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.titleView);
        make.top.mas_equalTo(weakSelf.titleView);
        make.centerX.mas_equalTo(weakSelf.titleView);
    }];
    label.text = @"订单浏览";
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self addSubview:tableView];
    
    WeakSelf(weakSelf);
    DKYOrderBrowseFooterView *footerView = [[DKYOrderBrowseFooterView alloc] initWithFrame:CGRectMake(0, 0, 514, 30)];
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;
    footerView.createOrderBtnClicked = ^(id sender) {
        weakSelf.createOrderBtnClicked(weakSelf);
    };
    
    footerView.cancelBtnClicked = ^(id sender) {
        weakSelf.cancelBtnClicked(weakSelf);
    };
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleView.mas_bottom);
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
    }];
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DKYOrderBrowsePopupViewCell *cell = [DKYOrderBrowsePopupViewCell orderBrowserViewCellWithTableView:tableView];
    cell.orderBrowseModel = self.orderBrowseModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
