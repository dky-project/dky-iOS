//
//  DKYOrderActionsView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/14.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderActionsView.h"
#import "UIButton+Custom.h"

@interface DKYOrderActionsView ()

@property (nonatomic, weak) UIButton *lastStepBtn;
@property (nonatomic, weak) UIButton *editBtn;
@property (nonatomic, weak) UIButton *saveBtn;
@property (nonatomic, weak) UIButton *nextStepBtn;

@property (nonatomic, weak) UIButton *confirmOrderBtn;
@property (nonatomic, weak) UIButton *reWriteBtn;

@end

@implementation DKYOrderActionsView

+ (instancetype)orderActionsView{
    DKYOrderActionsView *view = [[DKYOrderActionsView alloc]initWithFrame:CGRectZero];
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

- (void)reWriteBtnClicked:(UIButton*)sender{
    if(self.reWriteBtnClicked){
        self.reWriteBtnClicked(sender);
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
    self.confirmOrderBtn = btn;
    [self.confirmOrderBtn setTitle:@"确认下单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(confirmOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.confirmOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 50));
        make.left.mas_equalTo(weakSelf).with.offset(72);
        make.bottom.mas_equalTo(weakSelf).with.offset(-40);
    }];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Seven];
    [self addSubview:btn];
    self.reWriteBtn = btn;
    [self.reWriteBtn setTitle:@"重新填写" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(reWriteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.reWriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakSelf.confirmOrderBtn);
        make.right.mas_equalTo(weakSelf).with.offset(-72);
        make.bottom.mas_equalTo(weakSelf.confirmOrderBtn);
    }];
//    
//    [self addSubview:btn];
//    self.lastStepBtn = btn;
//    [self.lastStepBtn setTitle:@"上一步" forState:UIControlStateNormal];
//    
//    [self.lastStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(140, 50));
//        make.left.mas_equalTo(weakSelf.confirmOrderBtn);
//        make.bottom.mas_equalTo(weakSelf.confirmOrderBtn.mas_top).with.offset(-14);
//    }];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Seven];
//    [self addSubview:btn];
//    self.editBtn = btn;
//    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    
//    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(140, 50));
//        make.right.mas_equalTo(weakSelf.confirmOrderBtn);
//        make.bottom.mas_equalTo(weakSelf.lastStepBtn);
//    }];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Seven];
//    [self addSubview:btn];
//    self.saveBtn = btn;
//    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//    
//    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(140, 50));
//        make.left.mas_equalTo(weakSelf.reWriteBtn);
//        make.bottom.mas_equalTo(weakSelf.lastStepBtn);
//    }];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Seven];
//    [self addSubview:btn];
//    self.nextStepBtn = btn;
//    [self.nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
//    
//    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(140, 50));
//        make.right.mas_equalTo(weakSelf.reWriteBtn);
//        make.bottom.mas_equalTo(weakSelf.lastStepBtn);
//    }];
}

@end
