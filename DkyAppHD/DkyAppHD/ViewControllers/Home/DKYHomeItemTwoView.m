//
//  DKYHomeItemTwoView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/7.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHomeItemTwoView.h"

@interface DKYHomeItemTwoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *readMoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contentLabel;

@end

@implementation DKYHomeItemTwoView

+ (instancetype)homeItemTwoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self commonInit];
}

- (void)hideReadMoreBtn:(BOOL)hide{
    self.readMoreBtn.hidden = hide;
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

#pragma mark - UI
- (void)commonInit{
    self.imageView.image = [UIImage imageNamed:@"homeImage2"];
    self.imageView.autoresizingMask = NO;
    
    [self.readMoreBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE3DFD1]] forState:UIControlStateNormal];
    self.readMoreBtn.hidden = YES;
}

@end
