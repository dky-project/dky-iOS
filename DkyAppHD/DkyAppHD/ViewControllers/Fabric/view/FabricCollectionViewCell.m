//
//  FabricCollectionViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2019/9/18.
//  Copyright © 2019 haKim. All rights reserved.
//

#import "FabricCollectionViewCell.h"
#import "DKYProductImgModel.h"

@interface FabricCollectionViewCell ()

@property (nonatomic, weak) UIImageView *imageView;

//@property (nonatomic, weak) TTTAttributedLabel *titleLabel;

@end

@implementation FabricCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setImgModel:(DKYProductImgModel *)imgModel{
    _imgModel = imgModel;
    
    NSURL *imageUrl = [NSURL URLWithString:imgModel.imgUrl];
    
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:self.imageView.image];
}

- (void)commonInit{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
//    TTTAttributedLabel *label = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont boldSystemFontOfSize:18];
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:label];
//    self.titleLabel = label;
    
    WeakSelf(weakSelf)
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(weakSelf.contentView);
//        make.left.mas_equalTo(weakSelf.contentView);
//        make.right.mas_equalTo(weakSelf.contentView);
//    }];
    
    //self.imageView.image = [UIImage imageWithColor:[UIColor randomColor]];
    //self.titleLabel.text = @"26S克什米尔";
}

@end
