//
//  DKYSampleDetailGanweiViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/2.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYSampleDetailGanweiViewCell.h"

@interface DKYSampleDetailGanweiViewCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation DKYSampleDetailGanweiViewCell

+ (instancetype)sampleDetailGanweiViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYSampleDetailGanweiViewCell";
    DKYSampleDetailGanweiViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYSampleDetailGanweiViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithHex:0xF1F1F1];
    [self setupTitleLabel];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:label];
    self.titleLabel = label;
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).with.offset(53);
        make.top.mas_equalTo(weakSelf.contentView).with.offset(10);
        make.height.mas_equalTo(14);
        make.bottom.mas_equalTo(weakSelf.contentView).with.offset(-10);
    }];
    
    label.text = @"杆位";
}

@end
