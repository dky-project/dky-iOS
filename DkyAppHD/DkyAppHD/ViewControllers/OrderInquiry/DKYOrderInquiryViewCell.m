//
//  DKYOrderInquiryViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderInquiryViewCell.h"
#import "DKYOrderInquiryHeaderView.h"
#import "DKYOrderInfoHeaderView.h"

@interface DKYOrderInquiryViewCell ()

@property (weak, nonatomic) UIImageView *rectImageView;
@property (weak, nonatomic) UILabel *orderNumberLabel;
@property (weak, nonatomic) UILabel *serialNumberLabel;
@property (weak, nonatomic) UILabel *sourceOfSampleLabel;
@property (weak, nonatomic) UILabel *clientLabel;
@property (weak, nonatomic) UILabel *faxDateLabel;
@property (weak, nonatomic) UILabel *styleLabel;
@property (weak, nonatomic) UILabel *sizeLabel;
@property (weak, nonatomic) UILabel *lengthLabel;

@end

@implementation DKYOrderInquiryViewCell

+ (instancetype)orderInquiryViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYOrderInquiryViewCell";
    DKYOrderInquiryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYOrderInquiryViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(48, self.tw_height - 0.5)];
    [path addLineToPoint:CGPointMake(self.tw_width - 48, self.tw_height - 0.5)];
    [[UIColor colorWithHex:0x666666] setStroke];

    [path setLineWidth:0.5];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapButt];
    
    CGFloat lengths[2] = { 3, 1 };
    CGContextSetLineDash(context, 0, lengths, 2);
    [path stroke];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    WeakSelf(weakSelf);
    [self.rectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(11, 11));
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.rectImageView);
    }];
    
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.orderNumberLabel);
    }];
    
    [self.serialNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.serialNumberLabel);
    }];
    
    [self.sourceOfSampleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.sourceOfSampleLabel);
    }];
    
    [self.clientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.clientLabel);
    }];
    
    [self.faxDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.faxDateLabel);
    }];
    
    [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.styleLabel);
    }];
    
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.sizeLabel);
    }];
    
    [self.lengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.lengthLabel);
    }];
}

#pragma mark - UI

- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
    
    [self setupRectImageView];
//    [self setupOrderNumberLabel];
//    [self setupSerialNumberLabel];
//    [self setupSourceOfSampleLabel];
//    [self setupClientLabel];
//    [self setupFaxDateLabel];
//    [self setupStyleLabel];
//    [self setupSizeLabel];
    [self setupLengthLabel];
    
}

- (void)setupRectImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    UIImage *image = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(11, 11)];
    image = [image imageByRoundCornerRadius:0 borderWidth:0.5 borderColor:[UIColor blackColor]];
    imageView.image = image;
    [self.contentView addSubview:imageView];
    self.rectImageView = imageView;
}

- (void)setupOrderNumberLabel{
    self.orderNumberLabel = [self createLabelWithName:@"001"];
}

- (void)setupSerialNumberLabel{
    self.serialNumberLabel = [self createLabelWithName:@"DKY0378"];
}

- (void)setupSourceOfSampleLabel{
    self.sourceOfSampleLabel = [self createLabelWithName:@"门店"];
}

- (void)setupClientLabel{
    self.clientLabel = [self createLabelWithName:@"张三"];
}

- (void)setupFaxDateLabel{
    self.faxDateLabel = [self createLabelWithName:@"16/05/14"];
}

- (void)setupStyleLabel{
    self.styleLabel = [self createLabelWithName:@"圆领V"];
}

- (void)setupSizeLabel{
    self.sizeLabel = [self createLabelWithName:@"M"];
}

- (void)setupLengthLabel{
    self.lengthLabel = [self createLabelWithName:@"87cm"];
}

- (UILabel*)createLabelWithName:(NSString*)name{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    
    [self.contentView addSubview:label];
    self.faxDateLabel = label;
    
    label.text = name;
    return label;
}

@end
