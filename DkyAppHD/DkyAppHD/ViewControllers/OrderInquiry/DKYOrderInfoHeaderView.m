//
//  DKYOrderInfoHeaderView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderInfoHeaderView.h"

@interface DKYOrderInfoHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


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
    
    //    //设置虚线颜色
    //    CGContextSetStrokeColorWithColor(currentContext, [UIColor colorWithHex:0x666666].CGColor);
    //    //设置虚线宽度
    //    CGContextSetLineWidth(currentContext, 1);
    //    //设置虚线绘制起点
    //    CGContextMoveToPoint(currentContext, 0, 0);
    //    //设置虚线绘制终点
    //    CGContextAddLineToPoint(currentContext, self.frame.origin.x + self.frame.size.width, 0);
    //    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    //    CGFloat arr[] = {3,1};
    //    //下面最后一个参数“2”代表排列的个数。
    //    CGContextSetLineDash(currentContext, 0, arr, 2);
    //    CGContextDrawPath(currentContext, kCGPathStroke);
}

#pragma mark - UI

- (void)commonInit{
    self.backgroundColor = [UIColor colorWithHex:0xEBEBEB];
    UIImage *image = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(11, 11)];
    image = [image imageByRoundCornerRadius:0 borderWidth:0.5 borderColor:[UIColor blackColor]];
    self.imageView.image = image;
    
    [self setupOrderNumberLabel];
    [self setupSerialNumberLabel];
    [self setupSourceOfSampleLabel];
    [self setupClientLabel];
    [self setupFaxDateLabel];
    [self setupStyleLabel];
    [self setupSizeLabel];
    [self setupLengthLabel];
}

- (void)setupOrderNumberLabel{
    WeakSelf(weakSelf);
    self.orderNumberLabel = [self createLabelWithName:@"序号"];
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.imageView.mas_right).with.offset(48);
        make.centerY.mas_equalTo(weakSelf);
    }];
}

- (void)setupSerialNumberLabel{
    WeakSelf(weakSelf);
    self.serialNumberLabel = [self createLabelWithName:@"编号"];
    [self.serialNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.orderNumberLabel.mas_right).with.offset(60);
        make.centerY.mas_equalTo(weakSelf);
    }];
}

- (void)setupSourceOfSampleLabel{
    WeakSelf(weakSelf);
    self.sourceOfSampleLabel = [self createLabelWithName:@"来源样衣"];
    [self.sourceOfSampleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.serialNumberLabel.mas_right).with.offset(45);
        make.centerY.mas_equalTo(weakSelf);
    }];
}

- (void)setupClientLabel{
    WeakSelf(weakSelf);
    self.clientLabel = [self createLabelWithName:@"客户"];
    [self.clientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.sourceOfSampleLabel.mas_right).with.offset(45);
        make.centerY.mas_equalTo(weakSelf);
    }];
}

- (void)setupFaxDateLabel{
    WeakSelf(weakSelf);
    self.faxDateLabel = [self createLabelWithName:@"传真日期"];
    [self.faxDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.clientLabel.mas_right).with.offset(45);
        make.centerY.mas_equalTo(weakSelf);
    }];
}

- (void)setupStyleLabel{
    WeakSelf(weakSelf);
    self.styleLabel = [self createLabelWithName:@"式样"];
    [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.faxDateLabel.mas_right).with.offset(45);
        make.centerY.mas_equalTo(weakSelf);
    }];
}

- (void)setupSizeLabel{
    WeakSelf(weakSelf);
    self.sizeLabel = [self createLabelWithName:@"大"];
    [self.sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleLabel.mas_right).with.offset(70);
        make.centerY.mas_equalTo(weakSelf);
    }];
}

- (void)setupLengthLabel{
    WeakSelf(weakSelf);
    self.lengthLabel = [self createLabelWithName:@"长"];
    [self.lengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.sizeLabel.mas_right).with.offset(70);
        make.centerY.mas_equalTo(weakSelf);
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

@end
