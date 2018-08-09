//
//  DKYOrderInfoHeaderView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderInfoHeaderView.h"
#import "DKYOrderInqueryTotalMapModel.h"

#define kLeftMargin     (38)

@interface DKYOrderInfoHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, assign) BOOL selected;

// image
@property (nonatomic, strong) UIImage *normalImage;

@property (nonatomic, copy) UIImage *selectedImage;

@property (nonatomic, weak) UILabel *amountSumLabel;

@property (nonatomic, weak) UILabel *moneySumLabel;
@end

@implementation DKYOrderInfoHeaderView

+ (instancetype)orderInfoHeaderViewWithTableView:(UITableView *)tableView{
//    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    return [[DKYOrderInfoHeaderView alloc] initWithFrame:CGRectZero];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setOrderInqueryTotalMapModel:(DKYOrderInqueryTotalMapModel *)orderInqueryTotalMapModel{
    _orderInqueryTotalMapModel = orderInqueryTotalMapModel;
    
    self.amountSumLabel.text = [NSString stringWithFormat:@"%@",orderInqueryTotalMapModel.TOTALCOUNT ? : @0];
    self.moneySumLabel.text = [NSString stringWithFormat:@"%@",orderInqueryTotalMapModel.TOTALAMOUNT ? : @0];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    DLog(@"frame = %@",NSStringFromCGRect(self.frame));
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(48, self.tw_height - 0.5)];
    [path addLineToPoint:CGPointMake(self.tw_width - 48, self.tw_height - 0.5)];
        [[UIColor colorWithHex:0x666666] setStroke];
//    [[UIColor redColor] setStroke];
    
    [path setLineWidth:0.5];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapButt];

    CGFloat lengths[2] = { 3, 1 };
    CGContextSetLineDash(context, 0, lengths, 2);
    [path stroke];
}

#pragma mark - UI

- (void)commonInit{
    self.backgroundColor = [UIColor colorWithHex:0xEBEBEB];
    
    UIImage *image = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(11, 11)];
    self.normalImage = [image imageByRoundCornerRadius:0 borderWidth:0.5 borderColor:[UIColor blackColor]];
    
//    self.selectedImage = [UIImage imageNamed:@"select_icon"];
    self.selectedImage = [UIImage imageWithColor:[UIColor colorWithHex:0x3c3562] size:CGSizeMake(11, 11)];
    
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.image = self.normalImage;
    
    [self setupFaxDateLabel];
    [self setupStyleLabel];
    
    [self setupPictureLabel];
    [self setupSourceOfSampleLabel];
    
    [self setupClientLabel];
    
    [self setupColorLabel];
    
    [self setupSizeLabel];
    //[self setupLengthLabel];
    
    [self setupOrderAmountLabel];
    [self setupCountLabel];
    
    [self setupMoneySumLabel];
    [self setupAmountSumLabel];
    
//  [self setupSerialNumberLabel];
    
    WeakSelf(weakSelf);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        weakSelf.selected = !weakSelf.selected;
        weakSelf.imageView.image = weakSelf.selected ? weakSelf.selectedImage : weakSelf.normalImage;
        if(weakSelf.taped){
            weakSelf.taped(weakSelf,weakSelf.selected);
        }
    }];
    [self addGestureRecognizer:tap];
}

//- (void)setupOrderNumberLabel{
//    WeakSelf(weakSelf);
//    self.orderNumberLabel = [self createLabelWithName:@"序号"];
//    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.imageView.mas_right).with.offset(48);
//        make.centerY.mas_equalTo(weakSelf.imageView);
//    }];
//}

- (void)setupPictureLabel{
    WeakSelf(weakSelf);
    self.pictureLabel = [self createLabelWithName:@"图片"];
    [self.pictureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleLabel.mas_right).with.offset(40);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
}

- (void)setupSourceOfSampleLabel{
    WeakSelf(weakSelf);
    self.sourceOfSampleLabel = [self createLabelWithName:@"款号"];
    [self.sourceOfSampleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.pictureLabel.mas_right).with.offset(40);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
}

- (void)setupColorLabel{
    WeakSelf(weakSelf);
    self.colorLabel = [self createLabelWithName:@"颜色"];
    [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.clientLabel.mas_right).with.offset(kLeftMargin);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
}

- (void)setupSizeLabel{
    WeakSelf(weakSelf);
    self.sizeLabel = [self createLabelWithName:@"衣大"];
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.colorLabel.mas_right).with.offset(45);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
}

- (void)setupLengthLabel{
    WeakSelf(weakSelf);
    self.lengthLabel = [self createLabelWithName:@"长"];
    [self.lengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.sizeLabel.mas_right).with.offset(45);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
}

- (void)setupOrderAmountLabel{
    WeakSelf(weakSelf);
    self.orderAmountLabel = [self createLabelWithName:@"订单金额"];
    [self.orderAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.lengthLabel.mas_right).with.offset(60);
//        make.centerY.mas_equalTo(weakSelf.imageView);
        make.left.mas_equalTo(weakSelf.sizeLabel.mas_right).with.offset(kLeftMargin);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
}

- (void)setupCountLabel{
    WeakSelf(weakSelf);
    self.countLabel = [self createLabelWithName:@"数量"];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.orderAmountLabel.mas_right).with.offset(kLeftMargin);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
}

- (void)setupMoneySumLabel{
    WeakSelf(weakSelf);
    self.moneySumLabel = [self createLabelWithName:@""];
    [self.moneySumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.orderAmountLabel);
        make.bottom.mas_equalTo(weakSelf).with.offset(-10);
    }];
}

- (void)setupAmountSumLabel{
    WeakSelf(weakSelf);
    self.amountSumLabel = [self createLabelWithName:@""];
    [self.amountSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.countLabel);
        make.bottom.mas_equalTo(weakSelf.moneySumLabel);
    }];
}

- (UILabel*)createLabelWithName:(NSString*)name{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    
    [self addSubview:label];
    label.text = name;
    return label;
}

- (void)setupFaxDateLabel{
    WeakSelf(weakSelf);
    self.faxDateLabel = [self createLabelWithName:@"传真日期"];
    [self.faxDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imageView.mas_right).with.offset(48);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
}

- (void)setupStyleLabel{
    WeakSelf(weakSelf);
    self.styleLabel = [self createLabelWithName:@"编号"];
    [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.faxDateLabel.mas_right).with.offset(kLeftMargin);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
}

- (void)setupClientLabel{
    WeakSelf(weakSelf);
    self.clientLabel = [self createLabelWithName:@"性别"];
    [self.clientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.sourceOfSampleLabel.mas_right).with.offset(kLeftMargin);
        make.centerY.mas_equalTo(weakSelf.imageView);
    }];
}

//- (void)setupSerialNumberLabel{
//    WeakSelf(weakSelf);
//    self.serialNumberLabel = [self createLabelWithName:@"编号"];
//    [self.serialNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.orderNumberLabel.mas_right).with.offset(60);
//        make.centerY.mas_equalTo(weakSelf);
//    }];
//}


@end
