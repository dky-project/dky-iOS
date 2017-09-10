//
//  DKYRecommendEntryViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYRecommendEntryViewCell.h"

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

#pragma mark - UI

- (void)commonInit{
    self.imageView.backgroundColor = [UIColor randomColor];
}

@end
