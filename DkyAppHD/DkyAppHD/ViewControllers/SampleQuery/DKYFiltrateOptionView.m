//
//  DKYFiltrateOptionView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYFiltrateOptionView.h"

@interface DKYFiltrateOptionView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIImageView *arrowImageView;

@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation DKYFiltrateOptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setSelectedOption:(NSString *)selectedOption{
    _selectedOption = [selectedOption copy];
    
    self.contentLabel.text = selectedOption;
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    
    self.titleLabel.text = title;
}

#pragma mark - UI

- (void)commonInit{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor colorWithHex:0x3C3362].CGColor;
    
    WeakSelf(weakSelf);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if(weakSelf.optionViewTaped){
            weakSelf.optionViewTaped(weakSelf);
        }
    }];
    
    [self addGestureRecognizer:tap];
    
    [self setupTitleLabel];
    [self setupContentLabel];
    [self setupArrowImageView];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor colorWithHex:0x3C3362];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:label];
    self.titleLabel = label;
    
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).with.offset(19);
        make.centerX.mas_equalTo(weakSelf);
    }];
}

- (void)setupContentLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.font = [UIFont systemFontOfSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:label];
    self.contentLabel = label;
    
    WeakSelf(weakSelf);
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf);
    }];
}

- (void)setupArrowImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    imageView.image = [UIImage imageNamed:@"arrow_down"];
    [self addSubview:imageView];
    self.arrowImageView = imageView;
    
    WeakSelf(weakSelf);
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 12));
        make.bottom.mas_equalTo(weakSelf).with.offset(-8);
        make.centerX.mas_equalTo(weakSelf);
    }];
}

@end
