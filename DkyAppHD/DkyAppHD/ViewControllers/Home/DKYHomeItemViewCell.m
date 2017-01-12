//
//  DKYHomeItemViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/12.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHomeItemViewCell.h"
#import "DKYHomeArticleModel.h"
#import "TWLineLayout.h"

@interface DKYHomeItemViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *readMoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *contentLabel;

@end

@implementation DKYHomeItemViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self commonInit];
}

- (void)setItemModel:(DKYHomeArticleModel *)itemModel{
    _itemModel = itemModel;
    
    NSURL *imageUrl = [NSURL URLWithString:itemModel.imageurl];
    
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:nil];
    self.titleLabel.text = itemModel.title;
    self.contentLabel.text = itemModel.decription;
}

- (void)hideReadMoreBtn:(BOOL)hide{
    [UIView animateWithDuration:0.2 animations:^{
        self.readMoreBtn.alpha = hide ? 0.0 : 1.0;
    }];
}

#pragma mark - UI
- (void)commonInit{
    self.imageView.autoresizingMask = NO;
    
    [self.readMoreBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0xE3DFD1]] forState:UIControlStateNormal];
    self.readMoreBtn.alpha = 0;
}

@end
