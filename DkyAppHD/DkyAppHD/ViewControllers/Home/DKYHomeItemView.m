//
//  DKYHomeItemView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/6.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHomeItemView.h"
#import "DKYHomeArticleModel.h"

@interface DKYHomeItemView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *readMoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contentLabel;

@end

@implementation DKYHomeItemView

+ (instancetype)homeItemView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self commonInit];
}
    
- (void)hideReadMoreBtn:(BOOL)hide{
    [UIView animateWithDuration:0.5 animations:^{
        self.readMoreBtn.alpha = hide ? 0.0 : 1.0;
    }];
}

- (void)setItemModel:(DKYHomeArticleModel *)itemModel{
    _itemModel = itemModel;
    
    NSURL *imageUrl = [NSURL URLWithString:itemModel.imageurl];
    
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:nil];
    self.titleLabel.text = itemModel.title;
    self.contentLabel.text = itemModel.decription;
}

//- (void)setTransform:(CGAffineTransform)transform{
//    [super setTransform:transform];
//    CGAffineTransform it = CGAffineTransformInvert(transform);
//    self.titleLabel.transform = it;
//    self.contentLabel.transform = it;
//    self.imageView.transform = it;
//    
//}

//- (void)updateTransform:(CATransform3D)transform{
//    self.titleLabel.layer.transform = transform;
//    self.contentLabel.layer.transform = transform;
//    
//}

- (void)updateFrame:(BOOL)scale{
    // scale yes 缩小
    if(scale){
        self.titleLabel.layer.transform  = CATransform3DScale(CATransform3DIdentity, 1.0, 2.0, 1.0);
        self.contentLabel.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.0, 2.0, 1.0);
    }else{
        self.titleLabel.layer.transform  = CATransform3DIdentity;
        self.contentLabel.layer.transform = CATransform3DIdentity;
    }
}

#pragma mark - UI
- (void)commonInit{
    self.imageView.image = [UIImage imageNamed:@"homeImage1"];
    self.imageView.autoresizingMask = NO;
    
    [self.readMoreBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE3DFD1]] forState:UIControlStateNormal];
    self.readMoreBtn.alpha = 0.0;
}


@end
