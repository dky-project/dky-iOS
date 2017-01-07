//
//  DKYSampleQueryViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleQueryViewCell.h"

@interface DKYSampleQueryViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DKYSampleQueryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self commonInit];
}

- (void)setItemModel:(NSObject *)itemModel{
    self.imageView.image = (UIImage*)itemModel;
}

#pragma mark - UI

- (void)commonInit{
//    self.imageView.image = [UIImage imageWithColor:[UIColor randomColor]];
    
}

@end
