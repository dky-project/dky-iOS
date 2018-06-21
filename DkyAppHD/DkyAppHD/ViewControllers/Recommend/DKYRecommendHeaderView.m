//
//  DKYRecommendHeaderView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYRecommendHeaderView.h"

@interface DKYRecommendHeaderView ()

@property (nonatomic, weak) UIButton *preBtn;

@property (nonatomic, weak) UIButton *nextBtn;

@property (weak, nonatomic) UILabel *gwLabel;

@end

@implementation DKYRecommendHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)clear{
    
}

- (void)setGh:(NSString *)gh{
    _gh = [gh copy];
    self.gwLabel.text = [NSString stringWithFormat:@"杆位：%@",gh];
}

#pragma mark - UI
- (void)commonInit{
    [self setupPreBtn];
    [self setupNextBtn];
    [self setupGroupNoLabel];
}

- (void)setupPreBtn{
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Twelve];
    [self addSubview:btn];
    self.preBtn = btn;
    
    [btn setTitle:@"上一组" forState:UIControlStateNormal];
    
    WeakSelf(weakSelf);
    [self.preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 35));
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf).with.offset(32);
    }];
    
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.preBtnClicked){
            weakSelf.preBtnClicked(nil);
        }
    }];
}

- (void)setupNextBtn{
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Twelve];
    [self addSubview:btn];
    self.nextBtn = btn;
    
    [btn setTitle:@"下一组" forState:UIControlStateNormal];
    
    WeakSelf(weakSelf);
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakSelf.preBtn);
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.preBtn.mas_right).with.offset(50);
    }];
    
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.nextBtnClicked){
            weakSelf.nextBtnClicked(nil);
        }
    }];
}

- (void)setupGroupNoLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    self.gwLabel = label;
    
    WeakSelf(weakSelf);
    [self.gwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.nextBtn.mas_right).with.offset(88);
    }];
}

@end
