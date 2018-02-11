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
    
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:bigImageUrl]];
}

- (void)setGh:(NSString *)gh{
    _gh = [gh copy];
    self.gwLabel.text = [NSString stringWithFormat:@"杆位：%@",gh];
}

- (void)commonInit{
    self.bigImageView.backgroundColor = [UIColor randomColor];
}

@end
