//
//  DKYDisplayEntryViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayEntryViewCell.h"

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


#pragma mark - UI

- (void)commonInit{
    self.imageView.backgroundColor = [UIColor randomColor];
}

@end
