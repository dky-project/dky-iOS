//
//  DKYOrderBrowserViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderBrowserViewCell.h"
#import "DKYOrderBrowserLineView.h"
#import "DKYOrderBrowserLineItemModel.h"
#import "DKYOrderItemDetailModel.h"

@interface DKYOrderBrowserViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

@property (nonatomic, weak) DKYOrderBrowserLineView *line1;

@property (nonatomic, weak) DKYOrderBrowserLineView *line2;
@property (nonatomic, weak) DKYOrderBrowserLineView *line3;
@property (nonatomic, weak) DKYOrderBrowserLineView *line4;
@property (nonatomic, weak) DKYOrderBrowserLineView *line5;
@property (nonatomic, weak) DKYOrderBrowserLineView *line6;
@property (nonatomic, weak) DKYOrderBrowserLineView *line7;
@property (nonatomic, weak) DKYOrderBrowserLineView *line8;
@property (nonatomic, weak) DKYOrderBrowserLineView *line9;
@property (nonatomic, weak) DKYOrderBrowserLineView *line10;

//@property (nonatomic, weak) DKYOrderBrowserLineView *line11;
//@property (nonatomic, weak) DKYOrderBrowserLineView *line12;
//@property (nonatomic, weak) DKYOrderBrowserLineView *line13;
@end

@implementation DKYOrderBrowserViewCell

+ (instancetype)orderBrowserViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYOrderBrowserViewCell";
    DKYOrderBrowserViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
    self.line1.itemModel.secondContent = itemModel.displayFhDate;
    self.line1.itemModel = self.line1.itemModel;
    
    self.line2.itemModel.firstContent = itemModel.customer;
    self.line2.itemModel = self.line2.itemModel;
    
    self.line3.itemModel.firstContent = itemModel.pdt;
    self.line3.itemModel.secondContent = itemModel.mDimNew12Text;
    self.line3.itemModel = self.line3.itemModel;
    
    self.line4.itemModel.firstContent = itemModel.colorArr;
    self.line4.itemModel.secondContent = itemModel.mDimNew16Text;
    self.line4.itemModel = self.line4.itemModel;
    
    self.line5.itemModel.firstContent = itemModel.xwValue;
    self.line5.itemModel.secondContent = itemModel.ycValue;
    self.line5.itemModel = self.line5.itemModel;
    
    self.line6.itemModel.firstContent = itemModel.xcValue;
    self.line6.itemModel = self.line6.itemModel;
    
    self.line7.itemModel.firstContent = itemModel.mDimNew22Text;
    self.line7.itemModel.secondContent = itemModel.jkValue;
    self.line7.itemModel = self.line7.itemModel;
    
    self.line8.itemModel.firstContent = itemModel.huax;
    //self.line8.itemModel.secondContent = itemModel.bxText;
    self.line8.itemModel = self.line8.itemModel;
    
    self.line9.itemModel.firstContent = itemModel.mDimNew10Text;
    self.line9.itemModel.secondContent = itemModel.mDimNew32Text;
    self.line9.itemModel = self.line9.itemModel;
    
    self.line10.itemModel.firstContent = itemModel.lingValue;
    self.line10.itemModel = self.line10.itemModel;
    
//    self.line11.itemModel.firstContent = itemModel.hdTxt;
//    self.line11.itemModel.secondContent = itemModel.jxwValue;
//    self.line11.itemModel = self.line11.itemModel;
//    
//    self.line12.itemModel.firstContent = itemModel.sjxcValue;
//    self.line12.itemModel = self.line12.itemModel;
//    
//    self.line13.itemModel.firstContent = itemModel.remark;
//    self.line13.itemModel = self.line13.itemModel;
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
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(weakSelf).with.offset(71);
    }];
    
    DKYOrderBrowserLineItemModel *itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"机构";
    itemModel.secondTitle = @"交期";
    self.line1.itemModel = itemModel;
    
    self.line2 = [self createViewWithPrevView:self.line1];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"姓名";
    self.line2.itemModel = itemModel;
    
    self.line3 = [self createViewWithPrevView:self.line2];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"款号";
    itemModel.secondTitle = @"式样";
    self.line3.itemModel = itemModel;
    
    self.line4 = [self createViewWithPrevView:self.line3];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"颜色";
    itemModel.secondTitle = @"针型";
    self.line4.itemModel = itemModel;
    
    self.line5 = [self createViewWithPrevView:self.line4];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"大";
    itemModel.secondTitle = @"衣长";
    self.line5.itemModel = itemModel;
    
    self.line6 = [self createViewWithPrevView:self.line5];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"袖长";
    self.line6.itemModel = itemModel;
    
    self.line7 = [self createViewWithPrevView:self.line6];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"肩型";
    itemModel.secondTitle = @"肩款";
    self.line7.itemModel = itemModel;
    
    self.line8 = [self createViewWithPrevView:self.line7];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"花型";
    //itemModel.secondTitle = @"版型";
    self.line8.itemModel = itemModel;
    
    self.line9 = [self createViewWithPrevView:self.line8];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"下边";
    itemModel.secondTitle = @"袖口";
    self.line9.itemModel = itemModel;
    
//    self.line11 = [self createViewWithPrevView:self.line10];
//    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
//    itemModel.type = DkyOrderBrowserLineViewType_Both;
//    itemModel.firstTitle = @"后道";
//    itemModel.secondTitle = @"净胸围";
//    self.line11.itemModel = itemModel;
//
//    self.line12 = [self createViewWithPrevView:self.line11];
//    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
//    itemModel.type = DkyOrderBrowserLineViewType_Left;
//    itemModel.firstTitle = @"实际袖长";
//    self.line12.itemModel = itemModel;
    
    self.line10 = [self createViewWithPrevView:self.line9];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"领";
    itemModel.showBottomLine = NO;
    self.line10.itemModel = itemModel;
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
