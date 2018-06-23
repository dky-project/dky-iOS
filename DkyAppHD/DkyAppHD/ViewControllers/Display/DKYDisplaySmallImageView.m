//
//  DKYDisplaySmallImageView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplaySmallImageView.h"
#import "DKYGetProductListByGroupNoModel.h"

@interface DKYDisplaySmallImageView ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation DKYDisplaySmallImageView


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
        make.height.mas_equalTo(18);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf.titleLabel.mas_top);
    }];
}

- (void)setGetProductListByGroupNoModel:(DKYGetProductListByGroupNoModel *)getProductListByGroupNoModel{
    _getProductListByGroupNoModel = getProductListByGroupNoModel;

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:getProductListByGroupNoModel.imgUrl] placeholderImage:nil];
    self.titleLabel.text = getProductListByGroupNoModel.productName;
}

#pragma mark - UI
- (void)commonInit{
    [self setupTitleLabel];
    
    [self setupImageView];
}

- (void)setupImageView{
    WeakSelf(weakSelf);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if(weakSelf.imageTaped){
            weakSelf.imageTaped(weakSelf.imageView);
        }
    }];
    [imageView addGestureRecognizer:tap];
    
    self.imageView.backgroundColor = [UIColor colorWithHex:0xF0F0F0];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:label];
    self.titleLabel = label;
}

@end
