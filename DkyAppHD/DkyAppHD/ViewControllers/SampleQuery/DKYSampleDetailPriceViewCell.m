//
//  DKYSampleDetailPriceViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/27.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleDetailPriceViewCell.h"
#import "DKYSampleProductInfoModel.h"

@interface DKYSampleDetailPriceViewCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *priceLabel;

@end

@implementation DKYSampleDetailPriceViewCell

+ (instancetype)sampleDetailPriceViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYSampleDetailPriceViewCell";
    DKYSampleDetailPriceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYSampleDetailPriceViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

- (void)setSampleProductInfo:(DKYSampleProductInfoModel *)sampleProductInfo{
    _sampleProductInfo = sampleProductInfo;
    
    if (!sampleProductInfo) return;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",sampleProductInfo.pdtPrice];
}

#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupTitleLabel];
    [self setupPriceLabel];
    [self setupLine];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor colorWithHex:0x666666];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:label];
    self.titleLabel = label;
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.contentView).with.offset(18);
        make.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(14);
//        make.bottom.mas_equalTo(weakSelf.contentView).with.offset(-18);
    }];
    
   label.text = @"定制款零售基础价";
}

- (void)setupPriceLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:46];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:label];
    self.priceLabel = label;
    WeakSelf(weakSelf);
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakSelf.contentView).with.offset(50);
        make.right.mas_equalTo(weakSelf.contentView);
//        make.height.mas_equalTo(14);
        make.bottom.mas_equalTo(weakSelf.contentView).with.offset(-32);
    }];
    
    label.text = @"--元";
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
//    label.font = [UIFont boldSystemFontOfSize:46];
//    label.textColor = [UIColor colorWithHex:0x333333];
//    label.textAlignment = NSTextAlignmentCenter;
//    
//    [self.contentView addSubview:label];
//    
//    self.priceLabel = label;
//    WeakSelf(weakSelf);
//    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.contentView);
//        make.top.mas_equalTo(weakSelf.contentView).with.offset(64);
//        make.right.mas_equalTo(weakSelf.contentView);
//        make.bottom.mas_offset(weakSelf.contentView).with.offset(-32);
//    }];
//    
//    label.text = @"1280元";
}

- (void)setupLine{
    UIView *line = [[UIView alloc]initWithFrame:CGRectZero];
    line.backgroundColor = [UIColor colorWithHex:0x666666];
    [self.contentView addSubview:line];
    WeakSelf(weakSelf);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(kOnePixLine);
    }];
}

@end
