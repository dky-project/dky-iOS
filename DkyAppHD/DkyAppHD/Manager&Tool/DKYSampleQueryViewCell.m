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
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

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
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.sampleIdLabel.text = [NSString stringWithFormat:@"%@  %@",itemModel.name, itemModel.mDim16Text];

    self.cancelBtn.selected = itemModel.collected;
}
- (IBAction)collectBtnClicked:(UIButton *)sender {
    if(self.collectBtnClicekd){
        self.collectBtnClicekd(self, self.itemModel);
    }
}

#pragma mark - UI

- (void)commonInit{
    [self.cancelBtn customButtonWithTypeEx:UIButtonCustomType_Ten];
    [self.cancelBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"取消收藏" forState:UIControlStateSelected];
}

@end
