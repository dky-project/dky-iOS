//
//  DKYRecommendEntryViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYRecommendEntryViewCell.h"
#import "DKYGetProductListGhPageModel.h"

@interface DKYRecommendEntryViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *sampleIdLabel;

@end

@implementation DKYRecommendEntryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self commonInit];
}

- (void)setGetProductListGhPageModel:(DKYGetProductListGhPageModel *)getProductListGhPageModel{
    _getProductListGhPageModel = getProductListGhPageModel;
    
    NSURL *url = [NSURL URLWithString:getProductListGhPageModel.clImgUrl];
    
    [self.imageView sd_setImageWithURL:url placeholderImage:nil];
    NSMutableString *gw = [NSMutableString stringWithFormat:@"杆位：%@",getProductListGhPageModel.gh];
    self.sampleIdLabel.text = gw;
}

#pragma mark - UI

- (void)commonInit{
    
}

@end
