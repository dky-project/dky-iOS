//
//  DKYDisplayBigImaeViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/2/7.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYDisplayBigImaeViewCell.h"

@interface DKYDisplayBigImaeViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UILabel *gwLabel;


@end

@implementation DKYDisplayBigImaeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self commonInit];
}

- (void)setBigImageUrl:(NSString *)bigImageUrl{
    _bigImageUrl = [bigImageUrl copy];
    
    WeakSelf(weakSelf);
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:bigImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(error){
            weakSelf.bigImageView.image = [UIImage imageWithColor:[UIColor randomColor]];
        }
    }];
}

- (void)setGh:(NSString *)gh{
    _gh = [gh copy];
    self.gwLabel.text = [NSString stringWithFormat:@"杆位：%@",gh];
}

- (UIImage*)image{
    return self.bigImageView.image;
}

- (void)commonInit{
    [self.bigImageView sd_setShowActivityIndicatorView:YES];
    [self.bigImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //self.bigImageView.backgroundColor = [UIColor randomColor];
}

@end
