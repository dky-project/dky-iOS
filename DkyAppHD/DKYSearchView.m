//
//  DKYSearchView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSearchView.h"

@interface DKYSearchView ()

@property (nonatomic, weak) UIButton *searchBtn;

@end

@implementation DKYSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.searchBtn.center = CGPointMake(self.tw_width / 2, self.tw_height / 2);
}

#pragma mark - action method

- (void)searchBtnClicked:(UIButton*)sender{
    if(self.searchBtnClicked){
        self.searchBtnClicked(self);
    }
}

#pragma mark - UI

- (void)commonInit{
    self.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
    
    [self setupSearchBtn];
}

- (void)setupSearchBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [[UIImage imageWithColor:[UIColor colorWithHex:0x3C3362] size:CGSizeMake(56, 56)] imageByRoundCornerRadius:28];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"tabbar_discover"] forState:UIControlStateNormal];
    [self addSubview:btn];
    self.searchBtn = btn;
    btn.bounds = CGRectMake(0, 0, 56, 56);
}

@end
