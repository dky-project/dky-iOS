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

@interface DKYCustomOrderBusinessCell ()

@property (nonatomic, weak) DKYCustomOrderTextFieldView *agencyNumberView;
@property (nonatomic, weak) DKYCustomOrderTextFieldView *faxDateView;
@property (nonatomic, weak) DKYCustomOrderTextFieldView *handlersView;

@property (nonatomic, weak) DKYCustomOrderTextFieldView *orderNumberView;
@property (nonatomic, weak) DKYCustomOrderTextFieldView *detailAddressView;

@property (nonatomic, weak) DKYDeliveryDateView *deliveryDateView;

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

#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self setupAgencyNumberView];
    [self setupFaxDateView];
    [self setupHandlersView];
    
    [self setupOrderNumberView];
    [self setupDetailAddressView];
    
    [self setupDeliveryDateView];
}

- (void)setupAgencyNumberView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.agencyNumberView = view;
    
    WeakSelf(weakSelf);
    [self.agencyNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).with.offset(60);
        make.width.mas_equalTo(188);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(weakSelf.contentView).with.offset(20);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"机构号:";
    itemModel.lock = YES;
    itemModel.content = @"99999";
    self.agencyNumberView.itemModel = itemModel;
}

- (void)setupFaxDateView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.faxDateView = view;
    
    WeakSelf(weakSelf);
    [self.faxDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.agencyNumberView.mas_right).with.offset(42);
        make.width.mas_equalTo(weakSelf.agencyNumberView);
        make.height.mas_equalTo(weakSelf.agencyNumberView);
        make.top.mas_equalTo(weakSelf.agencyNumberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"传真日期:";
    itemModel.lock = YES;
    itemModel.content = @"2017-01-01";
    self.faxDateView.itemModel = itemModel;
}

- (void)setupHandlersView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.handlersView = view;
    
    WeakSelf(weakSelf);
    [self.handlersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.faxDateView.mas_right).with.offset(42);
        make.width.mas_equalTo(weakSelf.agencyNumberView);
        make.height.mas_equalTo(weakSelf.agencyNumberView);
        make.top.mas_equalTo(weakSelf.agencyNumberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"操作者:";
    itemModel.lock = YES;
    itemModel.content = @"root";
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
        make.top.mas_equalTo(weakSelf.agencyNumberView.mas_bottom).with.offset(20);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"订单号:";
    itemModel.lock = NO;
    itemModel.content = @"20170216202618";
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
        make.top.mas_equalTo(weakSelf.orderNumberView.mas_bottom).with.offset(20);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"要求发货日期:";
    itemModel.lock = NO;
    itemModel.content = @"点击选择日期";
    itemModel.subText = @"*选择传真日期后9~15天内的第一个星期一";
    self.deliveryDateView.itemModel = itemModel;
}

@end
