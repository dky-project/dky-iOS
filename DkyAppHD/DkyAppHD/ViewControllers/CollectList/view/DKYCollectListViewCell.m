//
//  DKYCollectListViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/5/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCollectListViewCell.h"
#import "UIButton+Custom.h"
#import "DKYSampleModel.h"

@interface DKYCollectListViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *sampleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sampleIdLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end


@implementation DKYCollectListViewCell

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
    //    self.sampleNameLabel.text = itemModel.name;
    self.sampleIdLabel.text = itemModel.name;
}

- (IBAction)cancelBtnClicked:(UIButton *)sender {
    if(self.cancelBtnClicekd){
        self.cancelBtnClicekd(self, self.itemModel);
    }
}

#pragma mark - UI

- (void)commonInit{
    [self.cancelBtn customButtonWithTypeEx:UIButtonCustomType_Five];
    
}

@end
