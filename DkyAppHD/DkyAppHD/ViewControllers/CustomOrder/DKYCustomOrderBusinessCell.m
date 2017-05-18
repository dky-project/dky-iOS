//
//  DKYCustomOrderBusinessCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/16.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderBusinessCell.h"
#import "DKYCustomOrderTextFieldView.h"
#import "DKYCustomOrderItemModel.h"
#import "DKYDeliveryDateView.h"
#import "DKYProductApproveTitleModel.h"
#import "DKYAddProductApproveParameter.h"

static const CGFloat topOffset = 30;
static const CGFloat leftOffset = 53;

static const CGFloat hpadding = 37;
static const CGFloat vpadding = 20;

static const CGFloat basicItemWidth = 196;
static const CGFloat basicItemHeight = 30;


@interface DKYCustomOrderBusinessCell ()

// 机构号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *agencyNumberView;
// 传真日期
@property (nonatomic, weak) DKYCustomOrderTextFieldView *faxDateView;
// 操作者
@property (nonatomic, weak) DKYCustomOrderTextFieldView *handlersView;
// 订单号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *orderNumberView;
// 详细地址
@property (nonatomic, weak) DKYCustomOrderTextFieldView *detailAddressView;
// 发送日期
@property (nonatomic, weak) DKYDeliveryDateView *deliveryDateView;
//备忘录
@property (nonatomic, weak) DKYCustomOrderTextFieldView *memoView;

@end

@implementation DKYCustomOrderBusinessCell

+ (instancetype)customOrderBusinessCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYCustomOrderBusinessCell";
    DKYCustomOrderBusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYCustomOrderBusinessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    [path moveToPoint:CGPointMake(leftOffset, self.tw_height - 1)];
    [path addLineToPoint:CGPointMake(self.tw_width - leftOffset, self.tw_height - 1)];
    [[UIColor colorWithHex:0x999999] setStroke];
    
    [path setLineWidth:1];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapButt];
    
    CGFloat lengths[2] = { 1, 1 };
    CGContextSetLineDash(context, 0, lengths, 2);
    [path stroke];
}

- (void)setProductApproveTitleModel:(DKYProductApproveTitleModel *)productApproveTitleModel{
    _productApproveTitleModel = productApproveTitleModel;
    
    if(productApproveTitleModel == nil) return;
    
    DKYCustomOrderItemModel *itemModel = self.agencyNumberView.itemModel;
    itemModel.content = productApproveTitleModel.code;
    self.agencyNumberView.itemModel = itemModel;
    
    itemModel = self.faxDateView.itemModel;
    itemModel.content = productApproveTitleModel.czDate;
    self.faxDateView.itemModel = itemModel;
    
    itemModel = self.handlersView.itemModel;
    itemModel.content = productApproveTitleModel.userName;
    self.handlersView.itemModel = itemModel;
    
    itemModel = self.deliveryDateView.itemModel;
    itemModel.content = productApproveTitleModel.sendDate;
    self.deliveryDateView.itemModel = itemModel;
    
    itemModel = self.orderNumberView.itemModel;
    itemModel.content = productApproveTitleModel.orderNo;
    self.orderNumberView.itemModel = itemModel;
    
    itemModel = self.detailAddressView.itemModel;
    itemModel.content = @"";
    self.detailAddressView.itemModel = itemModel;
    
    itemModel = self.memoView.itemModel;
    itemModel.content = @"";
    self.memoView.itemModel = itemModel;
}

#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self setupAgencyNumberView];
    [self setupFaxDateView];
    [self setupHandlersView];
    
    [self setupOrderNumberView];
    [self setupDetailAddressView];
    
    [self setupDeliveryDateView];
    [self setupMemoView];
}

- (void)setupAgencyNumberView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.agencyNumberView = view;
    
    WeakSelf(weakSelf);
    [self.agencyNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).with.offset(leftOffset);
        make.width.mas_equalTo(basicItemWidth);
        make.height.mas_equalTo(basicItemHeight);
        make.top.mas_equalTo(weakSelf.contentView).with.offset(topOffset);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"机构号:";
    itemModel.lock = YES;
    itemModel.enabled = NO;
    self.agencyNumberView.itemModel = itemModel;
}

- (void)setupFaxDateView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.faxDateView = view;
    
    WeakSelf(weakSelf);
    [self.faxDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.agencyNumberView.mas_right).with.offset(hpadding);
        make.width.mas_equalTo(weakSelf.agencyNumberView);
        make.height.mas_equalTo(weakSelf.agencyNumberView);
        make.top.mas_equalTo(weakSelf.agencyNumberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"传真日期:";
    itemModel.lock = YES;
    itemModel.enabled = NO;
    self.faxDateView.itemModel = itemModel;
}

- (void)setupHandlersView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.handlersView = view;
    
    WeakSelf(weakSelf);
    [self.handlersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.faxDateView.mas_right).with.offset(hpadding);
        make.width.mas_equalTo(weakSelf.agencyNumberView);
        make.height.mas_equalTo(weakSelf.agencyNumberView);
        make.top.mas_equalTo(weakSelf.agencyNumberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"操作者:";
    itemModel.lock = YES;
    itemModel.enabled = NO;
    self.handlersView.itemModel = itemModel;
}

- (void)setupOrderNumberView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.orderNumberView = view;
    
    WeakSelf(weakSelf);
    [self.orderNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.agencyNumberView);
        make.width.mas_equalTo(weakSelf.agencyNumberView);
        make.height.mas_equalTo(weakSelf.agencyNumberView);
        make.top.mas_equalTo(weakSelf.agencyNumberView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"订单号:";
    itemModel.lock = NO;
    itemModel.enabled = NO;
    self.orderNumberView.itemModel = itemModel;
}

- (void)setupDetailAddressView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.detailAddressView = view;
    
    WeakSelf(weakSelf);
    [self.detailAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.faxDateView);
        make.right.mas_equalTo(weakSelf.handlersView);
        make.height.mas_equalTo(weakSelf.agencyNumberView);
        make.top.mas_equalTo(weakSelf.orderNumberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"详细地址:";
    itemModel.lock = NO;
    itemModel.content = @"";
    self.detailAddressView.itemModel = itemModel;
}

- (void)setupDeliveryDateView{
    DKYDeliveryDateView *view = [[DKYDeliveryDateView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.deliveryDateView = view;
    
    WeakSelf(weakSelf);
    [self.deliveryDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.agencyNumberView);
        make.right.mas_equalTo(weakSelf.handlersView);
        make.height.mas_equalTo(weakSelf.agencyNumberView);
        make.top.mas_equalTo(weakSelf.orderNumberView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"要求发货日期:";
    itemModel.lock = NO;
    itemModel.content = @"点击选择日期";
    itemModel.subText = @"*选择传真日期后9~15天内的第一个星期一";
    self.deliveryDateView.itemModel = itemModel;
}

- (void)setupMemoView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.memoView = view;
    
    WeakSelf(weakSelf);
    [self.memoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.agencyNumberView);
        make.right.mas_equalTo(weakSelf.handlersView);
        make.height.mas_equalTo(weakSelf.agencyNumberView);
        make.top.mas_equalTo(weakSelf.deliveryDateView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"备忘录:";
    itemModel.lock = NO;
    itemModel.content = @"";
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        weakSelf.addProductApproveParameter.shRemark = textField.text;
    };
    self.memoView.itemModel = itemModel;
}

@end
