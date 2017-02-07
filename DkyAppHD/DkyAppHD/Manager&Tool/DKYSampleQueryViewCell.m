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
@property (weak, nonatomic) IBOutlet UILabel *sampleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sampleIdLabel;

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
//    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.sampleNameLabel.text = itemModel.name;
    self.sampleIdLabel.text = itemModel.name;
}

#pragma mark - UI

- (void)commonInit{

}

@end
