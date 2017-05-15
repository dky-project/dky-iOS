//
//  DKYOrderBrowseFooterView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/5/15.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderBrowseFooterView.h"

@interface DKYOrderBrowseFooterView ()

@property (nonatomic, weak) UIButton *createOrderBtn;

@property (nonatomic, weak) UIButton *cancelBtn;

@end

@implementation DKYOrderBrowseFooterView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - action method

- (void)createOrderBtnClicked:(UIButton*)sender{
    if(self.createOrderBtnClicked){
        self.createOrderBtnClicked(sender);
    }
}

- (void)cancelBtnClicked:(UIButton*)sender{
    if(self.cancelBtnClicked){
        self.cancelBtnClicked(sender);
    }
}

#pragma mark - UI

- (void)commonInit{
    [self setupActionBtn];
}

- (void)setupActionBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Seven];
    
    [self addSubview:btn];
    self.createOrderBtn = btn;
    [self.createOrderBtn setTitle:@"生成订单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(createOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.createOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.left.mas_equalTo(weakSelf).with.offset(43);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
    }];
    
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Seven];
    [self addSubview:btn];
    self.cancelBtn = btn;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakSelf.createOrderBtn);
        make.right.mas_equalTo(weakSelf).with.offset(-43);
        make.top.mas_equalTo(weakSelf.createOrderBtn);
    }];
}

@end
