//
//  DKYFiltrateView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYFiltrateView.h"
#import "DKYFiltrateOptionView.h"

@interface DKYFiltrateView ()

@property (nonatomic, weak) UILabel *filterConditionLabel;

@property (nonatomic, weak) UIButton *oneKeyClearBtn;

@end

@implementation DKYFiltrateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - action method

- (void)oneKeyClearBtnClicked:(UIButton*)sender{
    
}

- (void)optionViewTaped:(DKYFiltrateOptionView*)optionView{
    UIViewController *vc = [self viewController];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [vc jxt_showActionSheetWithTitle:nil
                             message:optionView.title
                   appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                       alertMaker.
                       addActionCancelTitle(@"cancel").
                       addActionDefaultTitle(@"1").
                       addActionDefaultTitle(@"2").
                       addActionDefaultTitle(@"3");
                   } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                       
                       if ([action.title isEqualToString:@"cancel"]) {
                           DLog(@"cancel");
                       }
                       else if ([action.title isEqualToString:@"1"]) {
                           DLog(@"1");
                       }
                   } sourceView:optionView];
#pragma clang diagnostic pop
}

#pragma mark - UI

- (void)commonInit{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    [self setupFilterConditionLabel];
    [self setupOneKeyClearBtn];
    
    
    [self test];
}

- (void)setupFilterConditionLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor colorWithHex:0x3C3362];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:label];
    self.filterConditionLabel = label;
    
    label.text = @"筛选条件";
    [label sizeToFit];
    
    WeakSelf(weakSelf);
    [self.filterConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).with.offset(28);
        make.left.mas_equalTo(weakSelf).with.offset(75);
    }];
//    self.filterConditionLabel.tw_x = 75;
//    self.filterConditionLabel.tw_y = 28;
}

- (void)setupOneKeyClearBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(oneKeyClearBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.oneKeyClearBtn = btn;
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setTitle:@"一键清除" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor colorWithHex:0xE2E2E2].CGColor;
    
    WeakSelf(weakSelf);
    [self.oneKeyClearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(31);
        make.right.mas_equalTo(weakSelf).with.offset(-32);
        make.top.mas_equalTo(weakSelf).with.offset(20);
        make.width.mas_equalTo(171);
    }];
//    btn.frame =  CGRectMake(512, 20, 171, 31);
}

- (void)test{
    WeakSelf(weakSelf);
    DKYFiltrateOptionView *opention1 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention1];
    [opention1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(171, 171));
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-28);
    }];
    opention1.title = @"性别";
    opention1.selectedOption = @"全部";
    opention1.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention2 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention2];
    [opention2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(171, 171));
        make.left.mas_equalTo(opention1.mas_right).with.offset(70);
        make.bottom.mas_equalTo(opention1);
    }];
    opention2.title = @"原料";
    opention2.selectedOption = @"羊绒";
    opention2.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention3 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention3];
    [opention3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(171, 171));
        make.left.mas_equalTo(opention2.mas_right).with.offset(70);
        make.bottom.mas_equalTo(opention1);
    }];
    opention3.title = @"式样";
    opention3.selectedOption = @"DKY0082";
    opention3.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
}

@end
