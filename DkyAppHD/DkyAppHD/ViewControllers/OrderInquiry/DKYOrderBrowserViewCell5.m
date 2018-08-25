//
//  DKYOrderBrowserViewCell2.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/8/11.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYOrderBrowserViewCell5.h"
#import "DKYOrderBrowserLineView.h"
#import "DKYOrderBrowserLineItemModel.h"
#import "DKYOrderItemDetailModel.h"

@interface DKYOrderBrowserViewCell5 ()
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

@property (nonatomic, weak) DKYOrderBrowserLineView *line1;

@property (nonatomic, weak) DKYOrderBrowserLineView *line2;
@property (nonatomic, weak) DKYOrderBrowserLineView *line3;
@property (nonatomic, weak) DKYOrderBrowserLineView *line4;
@end

@implementation DKYOrderBrowserViewCell5

+ (instancetype)orderBrowserViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYOrderBrowserViewCell5";
    DKYOrderBrowserViewCell5 *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self commonInit];
}

- (void)setItemModel:(DKYOrderItemDetailModel *)itemModel{
    _itemModel = itemModel;
    
    if(!itemModel) return;
    
    NSString *orderNum = [NSString stringWithFormat:@"订单编号：%@",itemModel.displayNo1];
    self.orderNumberLabel.text = orderNum;
    
    self.line1.itemModel.firstContent = itemModel.jgNo;
    self.line1.itemModel.secondContent = itemModel.fair;
    self.line1.itemModel = self.line1.itemModel;
    
    self.line2.itemModel.firstContent = itemModel.productName;
    self.line2.itemModel.secondContent = itemModel.colorName;
    self.line2.itemModel = self.line2.itemModel;
    
    self.line3.itemModel.firstContent = itemModel.sizeName;
    self.line3.itemModel = self.line3.itemModel;
    
    self.line4.itemModel.firstContent = itemModel.displayqty;
    self.line4.itemModel.secondContent = [NSString stringWithFormat:@"¥%@",itemModel.pricelist];
    self.line4.itemModel = self.line4.itemModel;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(44, 70)];
    [path addLineToPoint:CGPointMake(self.tw_width - 44, 70)];
    [[UIColor colorWithHex:0x999999] setStroke];
    
    [path setLineWidth:1];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapButt];
    
    CGFloat lengths[2] = { 3, 1 };
    CGContextSetLineDash(context, 0, lengths, 2);
    [path stroke];
}
#pragma mark - UI

- (void)commonInit{
    if([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        self.preservesSuperviewLayoutMargins = NO;
    }
    if ([self respondsToSelector:@selector(setSeparatorInset:)]){
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]){
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setLineView];
}

- (void)setLineView{
    DKYOrderBrowserLineView *view = [[DKYOrderBrowserLineView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.line1 = view;
    WeakSelf(weakSelf);
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(weakSelf).with.offset(71);
    }];
    
    DKYOrderBrowserLineItemModel *itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"机构号";
    itemModel.secondTitle = @"性质";
    self.line1.itemModel = itemModel;
    
    self.line2 = [self createViewWithPrevView:self.line1];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"款号";
    itemModel.secondTitle = @"颜色";
    self.line2.itemModel = itemModel;
    
    self.line3 = [self createViewWithPrevView:self.line2];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"尺码";
    self.line3.itemModel = itemModel;
    
    self.line4 = [self createViewWithPrevView:self.line3];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"数量";
    itemModel.secondTitle = @"标准价";
    itemModel.showBottomLine = NO;
    self.line4.itemModel = itemModel;
}

- (DKYOrderBrowserLineView*)createViewWithPrevView:(DKYOrderBrowserLineView*)preView{
    WeakSelf(weakSelf);
    DKYOrderBrowserLineView *view = [[DKYOrderBrowserLineView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(preView);
        make.top.mas_equalTo(preView.mas_bottom);
    }];
    return view;
}

@end
