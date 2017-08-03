//
//  DKYDisplayActionView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayActionView.h"
#import "UIButton+Custom.h"

@interface DKYDisplayActionView ()

@property (nonatomic, weak) UIButton *saveBtn;

@property (nonatomic, weak) UIButton *confirmOrderBtn;

@end

@implementation DKYDisplayActionView

+ (instancetype)displayActionViewView{
    DKYDisplayActionView *view = [[DKYDisplayActionView alloc]initWithFrame:CGRectZero];
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

#pragma mark - action method

- (void)confirmOrderBtnClicked:(UIButton*)sender{
    if(self.confirmBtnClicked){
        self.confirmBtnClicked(sender);
    }
}

- (void)saveBtnClicked:(UIButton*)sender{
    if(self.saveBtnClicked){
        self.saveBtnClicked(sender);
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
    self.saveBtn = btn;
    [self.saveBtn setTitle:@"保存下单" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 50));
        make.left.mas_equalTo(weakSelf).with.offset(72);
        make.bottom.mas_equalTo(weakSelf).with.offset(-40);
    }];
    
    
     btn = [UIButton buttonWithCustomType:UIButtonCustomType_Seven];
    [self addSubview:btn];
    self.confirmOrderBtn = btn;
    [self.confirmOrderBtn setTitle:@"确认下单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(confirmOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.confirmOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakSelf.saveBtn);
        make.right.mas_equalTo(weakSelf).with.offset(-72);
        make.bottom.mas_equalTo(weakSelf.saveBtn);
    }];
}

@end
