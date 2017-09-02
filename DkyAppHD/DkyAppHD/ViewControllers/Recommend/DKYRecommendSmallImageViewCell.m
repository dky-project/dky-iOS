//
//  DKYRecommendSmallImageViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/8/31.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYRecommendSmallImageViewCell.h"

@interface DKYRecommendSmallImageViewCell ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *markLabel;

@end

@implementation DKYRecommendSmallImageViewCell

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
    
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(12);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf.titleLabel.mas_top);
    }];
    
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.mas_equalTo(weakSelf.contentView).with.offset(8);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-8);
    }];
}

#pragma mark - UI
- (void)commonInit{
    [self setupTitleLabel];
    
    [self setupImageView];
    
    [self setupMarkLabel];
}

- (void)setupImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
    self.imageView.backgroundColor = [UIColor colorWithHex:0xF0F0F0];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:label];
    self.titleLabel = label;
    
    self.titleLabel.text = @"2005";
}

- (void)setupMarkLabel{
    //
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.clipsToBounds = YES;
    label.layer.cornerRadius = 10;
    
    label.backgroundColor = [UIColor colorWithHex:0x315F7F];
    
    [self.contentView addSubview:label];
    self.markLabel = label;
    
    self.markLabel.text = @"1";
}
@end
