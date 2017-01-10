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
@property (nonatomic, weak) DKYOrderBrowserLineView *line11;
@property (nonatomic, weak) DKYOrderBrowserLineView *line12;
@property (nonatomic, weak) DKYOrderBrowserLineView *line13;
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
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(weakSelf).with.offset(71);
    }];
    
    DKYOrderBrowserLineItemModel *itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"机构";
    itemModel.firstContent = @"牛逼的公司";
    itemModel.secondTitle = @"交期";
    itemModel.secondContent = @"2016/09/09";
    self.line1.itemModel = itemModel;
    
    self.line2 = [self createViewWithPrevView:self.line1];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"品名";
    itemModel.firstContent = @"好看的衣服";
    itemModel.secondTitle = @"名";
    itemModel.secondContent = @"大衣";
    self.line2.itemModel = itemModel;
    
    self.line3 = [self createViewWithPrevView:self.line2];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"颜色";
    itemModel.firstContent = @"红色";
    self.line3.itemModel = itemModel;
    
    self.line4 = [self createViewWithPrevView:self.line3];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"大";
    itemModel.firstContent = @"M";
    itemModel.secondTitle = @"长";
    itemModel.secondContent = @"85CM";
    self.line4.itemModel = itemModel;
    
    self.line5 = [self createViewWithPrevView:self.line4];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"肩";
    itemModel.firstContent = @"宽";
    itemModel.secondTitle = @"袖";
    itemModel.secondContent = @"大";
    self.line5.itemModel = itemModel;
    
    self.line6 = [self createViewWithPrevView:self.line5];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"下边";
    itemModel.firstContent = @"宽";
    itemModel.secondTitle = @"袖口";
    itemModel.secondContent = @"大";
    self.line6.itemModel = itemModel;
    
    self.line7 = [self createViewWithPrevView:self.line6];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"领";
    itemModel.firstContent = @"宽";
    self.line7.itemModel = itemModel;
    
    self.line8 = [self createViewWithPrevView:self.line7];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"式样";
    itemModel.firstContent = @"新款";
    self.line8.itemModel = itemModel;
    
    self.line9 = [self createViewWithPrevView:self.line8];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"附件";
    itemModel.firstContent = @"xxxx";
    self.line9.itemModel = itemModel;
    
    self.line10 = [self createViewWithPrevView:self.line9];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"袖型";
    itemModel.firstContent = @"紧";
    itemModel.secondTitle = @"袋子";
    itemModel.secondContent = @"3";
    self.line10.itemModel = itemModel;
    
    self.line11 = [self createViewWithPrevView:self.line10];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Both;
    itemModel.firstTitle = @"后道";
    itemModel.firstContent = @"紧";
    itemModel.secondTitle = @"净胸围";
    itemModel.secondContent = @"160";
    self.line11.itemModel = itemModel;
    
    self.line12 = [self createViewWithPrevView:self.line11];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"实际袖长";
    itemModel.firstContent = @"87CM";
    self.line12.itemModel = itemModel;
    
    self.line13 = [self createViewWithPrevView:self.line12];
    itemModel = [[DKYOrderBrowserLineItemModel alloc] init];
    itemModel.type = DkyOrderBrowserLineViewType_Left;
    itemModel.firstTitle = @"备注";
    itemModel.firstContent = @"赞赞赞👍";
    itemModel.showBottomLine = NO;
    self.line13.itemModel = itemModel;
}

- (DKYOrderBrowserLineView*)createViewWithPrevView:(DKYOrderBrowserLineView*)preView{
    WeakSelf(weakSelf);
    DKYOrderBrowserLineView *view = [[DKYOrderBrowserLineView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(17);
        make.top.mas_equalTo(preView.mas_bottom);
    }];
    return view;
}

@end
