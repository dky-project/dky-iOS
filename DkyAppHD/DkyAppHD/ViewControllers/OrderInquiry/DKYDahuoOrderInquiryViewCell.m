//
//  DKYDahuoOrderInquiryViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/1.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDahuoOrderInquiryViewCell.h"
#import "DKYDahuoOrderInquiryHeaderView.h"
#import "DKYDahuoOrderInfoHeaderView.h"
#import "DKYOrderItemModel.h"
#import "PYPhotoBrowser.h"

@interface DKYDahuoOrderInquiryViewCell ()<PYPhotoBrowseViewDelegate>

@property (weak, nonatomic) UIImageView *rectImageView;
@property (weak, nonatomic) UILabel *orderNumberLabel;

@property (weak, nonatomic) UILabel *sourceOfSampleLabel;
@property (weak, nonatomic) UILabel *sizeLabel;
@property (weak, nonatomic) UILabel *lengthLabel;

@property (nonatomic, weak) UILabel *orderAmountLabel;
@property (nonatomic, weak) UILabel *countLabel;
@property (nonatomic, weak) UIImageView *pictureImageView;

// image
@property (nonatomic, strong) UIImage *normalImage;

@property (nonatomic, copy) UIImage *selectedImage;

@end

@implementation DKYDahuoOrderInquiryViewCell

+ (instancetype)orderInquiryViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYOrderInquiryViewCell";
    DKYDahuoOrderInquiryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYDahuoOrderInquiryViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

- (void)setItemModel:(DKYOrderItemModel *)itemModel{
    _itemModel = itemModel;
    
    self.orderNumberLabel.text = itemModel.displayID;
    
    self.sourceOfSampleLabel.text = itemModel.productName;
    
    self.sizeLabel.text = itemModel.colorName;
    self.lengthLabel.text = itemModel.sizeName;
    
    self.rectImageView.image = itemModel.selected ? self.selectedImage : self.normalImage;
    
    self.orderAmountLabel.text = itemModel.amount;
    self.countLabel.text = itemModel.qty;
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.imgUrl]];
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
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.rectImageView);
    }];
    
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.orderNumberLabel);
    }];
    
    [self.sourceOfSampleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.sourceOfSampleLabel);
    }];
    
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.sizeLabel);
    }];
    
    [self.lengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.lengthLabel);
    }];
    
    [self.orderAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.orderAmountLabel);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.countLabel);
    }];
    
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(72, 72));
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.centerX.mas_equalTo(weakSelf.headerView.bottomHeaderView.pictureLabel);
    }];
}

#pragma mark - PYPhotoBrowseViewDelegate

- (void)photoBrowseView:(PYPhotoBrowseView *)photoBrowseView didLongPressImage:(UIImage *)image index:(NSInteger)index{
    // 长按图片浏览器，相应的时间，类似微信，弹出一个action sheet，有相应的操作。
    //    [self showOptionsPicker];
}

#pragma mark - UI

- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
    
    [self setupRectImageView];
    [self setupOrderNumberLabel];
    
    [self setupSourceOfSampleLabel];
    
    [self setupSizeLabel];
    [self setupLengthLabel];
    
    [self setupOrderAmountLabel];
    [self setupCountLabel];
    
    [self setupPictureLabel];
}

- (void)setupRectImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    UIImage *image = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(11, 11)];
    self.normalImage = [image imageByRoundCornerRadius:0 borderWidth:0.5 borderColor:[UIColor blackColor]];
    
    self.selectedImage = [UIImage imageWithColor:[UIColor colorWithHex:0x3c3562] size:CGSizeMake(11, 11)];
    
    imageView.image = self.normalImage;
    imageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:imageView];
    self.rectImageView = imageView;
}

- (void)setupOrderNumberLabel{
    self.orderNumberLabel = [self createLabelWithName:@""];
}

- (void)setupSourceOfSampleLabel{
    self.sourceOfSampleLabel = [self createLabelWithName:@""];
}


- (void)setupSizeLabel{
    self.sizeLabel = [self createLabelWithName:@""];
}

- (void)setupLengthLabel{
    self.lengthLabel = [self createLabelWithName:@""];
}

- (void)setupOrderAmountLabel{
    self.orderAmountLabel = [self createLabelWithName:@""];
}

- (void)setupCountLabel{
    self.countLabel = [self createLabelWithName:@""];
}

- (void)setupPictureLabel{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    [self.contentView addSubview:imageView];
    self.pictureImageView = imageView;
    self.pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.pictureImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        // 点击图片，显示图片浏览器
        
        // 1. 创建photoBroseView对象
        PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
        
        // 2.1 设置图片源(UIImageView)数组
        photoBroseView.imagesURL = @[self.itemModel.bigImgUrl];
        
        // 2.2 设置初始化图片下标（即当前点击第几张图片）
        photoBroseView.currentIndex = 0;
        
        CGRect frameFormWindow = [self convertRect:self.pictureImageView.frame toView:[UIApplication sharedApplication].keyWindow];
        photoBroseView.frameFormWindow = frameFormWindow;
        photoBroseView.frameToWindow = frameFormWindow;
        
        // 不转屏
        photoBroseView.autoRotateImage = NO;
        
        // 动画时间
        photoBroseView.showDuration = 0.78;
        photoBroseView.hiddenDuration = 0.78;
        
        // 设置代理
        photoBroseView.delegate = self;
        
        // 3.显示(浏览)
        [photoBroseView show];
        
    }];
    
    [self.pictureImageView addGestureRecognizer:tap];
}


- (UILabel*)createLabelWithName:(NSString*)name{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    
    [self.contentView addSubview:label];
    
    label.text = name;
    return label;
}

@end
