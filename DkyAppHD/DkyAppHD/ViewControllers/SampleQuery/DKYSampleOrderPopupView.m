//
//  DKYSampleOrderPopupView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleOrderPopupView.h"
#import "KLCPopup.h"
#import "DKYSampleOrderViewCell.h"

@interface DKYSampleOrderPopupView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) KLCPopup *popup;

@property (nonatomic, weak) UIView *titleView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIButton *cancelBtn;

@property (nonatomic, weak) UIButton *confirmBtn;

@end

@implementation DKYSampleOrderPopupView

+ (instancetype)show{
    DKYSampleOrderPopupView *contentView = [[DKYSampleOrderPopupView alloc]initWithFrame:CGRectZero];
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

- (void)confirmBtnClicked:(UIButton*)sender{
    [self dismiss];
}

#pragma mark - UI
- (void)commonInit{
    self.bounds = CGRectMake(0, 0, 514, 610);
    self.backgroundColor = [UIColor whiteColor];

    [self setupTitleView];
    [self setupTitleLabel];
    [self setupTableView];
    [self setupBtns];
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
    label.text = @"下单";
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorInset = UIEdgeInsetsMake(0, 32, 0, 0);
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

- (void)setupBtns{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:btn];
    self.cancelBtn = btn;
    
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    WeakSelf(weakSelf);
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleView);
        make.bottom.mas_equalTo(weakSelf.titleView);
        make.top.mas_equalTo(weakSelf.titleView);
        make.width.mas_equalTo(60);
    }];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:btn];
    self.confirmBtn = btn;
    
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.titleView);
        make.bottom.mas_equalTo(weakSelf.titleView);
        make.top.mas_equalTo(weakSelf.titleView);
        make.width.mas_equalTo(60);
    }];
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKYSampleOrderViewCell *cell = [DKYSampleOrderViewCell sampleOrderViewCellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
