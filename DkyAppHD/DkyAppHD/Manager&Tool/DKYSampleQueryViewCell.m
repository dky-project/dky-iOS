//
//  DKYSampleQueryViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleQueryViewCell.h"
#import "DKYSampleModel.h"

@interface DKYSampleQueryViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DKYSampleQueryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self commonInit];
}

- (void)setItemModel:(DKYSampleModel *)itemModel{
    _itemModel = itemModel;
    NSURL *imageUrl = [NSURL URLWithString:itemModel.imgUrl1];
    [self.imageView sd_setImageWithURL:imageUrl placeholderImage:nil];
}

#pragma mark - UI

- (void)commonInit{

}

@end
