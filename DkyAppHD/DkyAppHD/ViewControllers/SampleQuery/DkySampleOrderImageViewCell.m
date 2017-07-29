//
//  DkySampleOrderImageViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/7/28.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DkySampleOrderImageViewCell.h"

@interface DkySampleOrderImageViewCell ()

@property (nonatomic, weak) UIImageView *displayImageView;

@end

@implementation DkySampleOrderImageViewCell

+ (instancetype)sampleOrderImageViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DkySampleOrderImageViewCell";
    DkySampleOrderImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DkySampleOrderImageViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self commonInit];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = [imageUrl copy];
    
    [self.displayImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupDisplayImageView];
}

- (void)setupDisplayImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:imageView];
    self.displayImageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    WeakSelf(weakSelf);
    [self.displayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(380);
        make.top.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.contentView);
    }];
}

@end
