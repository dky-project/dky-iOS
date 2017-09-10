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

#pragma mark - UI
- (void)commonInit{
    [self setupPreBtn];
    [self setupNextBtn];
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


@end
