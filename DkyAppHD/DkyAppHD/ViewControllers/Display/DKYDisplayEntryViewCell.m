//
//  DKYDisplayEntryViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayEntryViewCell.h"
#import "DKYGetProductGroupPageModel.h"

@interface DKYDisplayEntryViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *sampleIdLabel;

@end

@implementation DKYDisplayEntryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self commonInit];
}

- (void)setGetProductGroupPageModel:(DKYGetProductGroupPageModel *)getProductGroupPageModel{
    _getProductGroupPageModel = getProductGroupPageModel;
    
    NSURL *url = [NSURL URLWithString:getProductGroupPageModel.dpImgUrl];
    
    [self.imageView sd_setImageWithURL:url placeholderImage:nil];
    self.sampleIdLabel.text = getProductGroupPageModel.groupNo;
}


#pragma mark - UI

- (void)commonInit{
    
}

@end
