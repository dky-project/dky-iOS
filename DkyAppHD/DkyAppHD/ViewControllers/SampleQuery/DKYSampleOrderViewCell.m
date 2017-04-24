//
//  DKYSampleOrderViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleOrderViewCell.h"
#import "DKYCustomOrderTextFieldView.h"
#import "DKYCustomOrderItemModel.h"
#import "DKYSampleOrderVarietyItemView.h"
#import "DKYSampleOrderSizeItemView.h"
#import "DKYSampleOrderJingSizeItemView.h"
#import "DKYSampleOrderJianTypeItemView.h"
#import "DKYSampleProductInfoModel.h"
#import "DKYProductApproveTitleModel.h"
#import "DKYMadeInfoByProductNameParameter.h"

static const CGFloat topOffset = 30;
static const CGFloat leftOffset = 20;

static const CGFloat hpadding = 30;
static const CGFloat vpadding = 20;

static const CGFloat basicItemWidth = 222;
static const CGFloat basicItemHeight = 30;

@interface DKYSampleOrderViewCell ()

// 编号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *numberView;
// 客户号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *clientView;

// 手机号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *phoneNumberView;

// 款号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *styleNumberView;

// 品种
@property (nonatomic, weak) DKYSampleOrderVarietyItemView *varietyView;

// 尺寸View
@property (nonatomic, weak) DKYSampleOrderSizeItemView *sizeView;

// 净尺寸
@property (nonatomic, weak) DKYSampleOrderJingSizeItemView *jingSizeItemView;

// 肩型
@property (nonatomic, weak) DKYSampleOrderJianTypeItemView *jianTypeView;

@property (nonatomic, strong) DKYMadeInfoByProductNameModel *madeInfoByProductName;

@end

@implementation DKYSampleOrderViewCell

+ (instancetype)sampleOrderViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYSampleOrderViewCell";
    DKYSampleOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYSampleOrderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

- (void)setSampleProductInfo:(DKYSampleProductInfoModel *)sampleProductInfo{
    _sampleProductInfo = sampleProductInfo;
    
    if(sampleProductInfo == nil) return;
    
    // 默认值
    // 款号
    DKYCustomOrderItemModel *model = self.styleNumberView.itemModel;
    model.content = sampleProductInfo.name;
    self.styleNumberView.itemModel = model;
    
    // 编号
    model = self.numberView.itemModel;
    model.content = @"怎么获取";
    self.numberView.itemModel = model;
}

- (void)setProductApproveTitleModel:(DKYProductApproveTitleModel *)productApproveTitleModel{
    _productApproveTitleModel = productApproveTitleModel;
    
    self.varietyView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.jianTypeView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.sizeView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.jingSizeItemView.customOrderDimList = productApproveTitleModel.dimListModel;
    
    if(productApproveTitleModel){
        [self getMadeInfoByProductNameFromServer];
    }
}

- (void)getMadeInfoByProductNameFromServer{
    [DKYHUDTool show];
    DKYMadeInfoByProductNameParameter *p = [[DKYMadeInfoByProductNameParameter alloc] init];
    p.productName = self.styleNumberView.itemModel.content;
    
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] getMadeInfoByProductNameWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.madeInfoByProductName = [DKYMadeInfoByProductNameModel mj_objectWithKeyValues:result.data];
            
            [weakSelf dealWithstyleNumber];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
    } failure:^(NSError *error) {
        [DKYHUDTool dismiss];
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

- (void)dealWithstyleNumber{
//    [self updateModelViews];
//    
//    // 定制订单，默认赋值参数
//    [self updateAddProductApproveParameter];
}

- (void)updateModelViews{
    self.jianTypeView.madeInfoByProductName = self.madeInfoByProductName;
    self.sizeView.madeInfoByProductName = self.madeInfoByProductName;
    self.varietyView.madeInfoByProductName = self.madeInfoByProductName;
    self.jingSizeItemView.madeInfoByProductName = self.madeInfoByProductName;
}

#pragma mark - UI
- (void)commonInit{
    // 第一行 款号，客户，手机号
    [self setupNumberView];
    [self setupClientView];
    
    // 第二行 款号，手机号
    [self setupStyleNumberView];
    [self setupPhoneNumberView];

    // 第三大行 品种 4个选择器
    [self setupVarietyView];
    
    // 第五大行，尺寸
    [self setupSizeView];

    // 第六大行，净尺寸
    [self setupJingSizeItemView];
    
    // 第七大行,肩型
    [self setupJanTypeView];
}

- (void)setupNumberView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.numberView = view;
    
    WeakSelf(weakSelf);
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).with.offset(leftOffset);
        make.width.mas_equalTo(basicItemWidth);
        make.height.mas_equalTo(basicItemHeight);
        make.top.mas_equalTo(weakSelf.contentView).with.offset(topOffset);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"编号:";
    itemModel.placeholder = @"请输入1-6位的数字编号";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.textFieldLeftOffset = 16;
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        // 编号
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    };
    self.numberView.itemModel = itemModel;
}


- (void)setupClientView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.clientView = view;
    
    WeakSelf(weakSelf);
    [self.clientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.numberView.mas_right).with.offset(hpadding);
        make.width.mas_equalTo(weakSelf.numberView);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.numberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*客户:";
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        // 客户号
    };
    itemModel.content = @"样衣五";
    self.clientView.itemModel = itemModel;
}

- (void)setupStyleNumberView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.styleNumberView = view;
    
    WeakSelf(weakSelf);
    [self.styleNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.numberView);
        make.width.mas_equalTo(weakSelf.numberView);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.numberView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*款号:";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.content = @"1";
    
    itemModel.textFieldDidEndEditing = ^(UITextField *sender){
        
    };
    
    self.styleNumberView.itemModel = itemModel;
}

- (void)setupPhoneNumberView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.phoneNumberView = view;
    
    WeakSelf(weakSelf);
    [self.phoneNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.numberView.mas_right).with.offset(hpadding);
        make.width.mas_equalTo(weakSelf.numberView);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.styleNumberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*手机号:";
    itemModel.keyboardType = UIKeyboardTypePhonePad;
    itemModel.textFieldDidEndEditing = ^(UITextField *textField){
        
    };
    
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    };
    self.phoneNumberView.itemModel = itemModel;
}

- (void)setupVarietyView{
    DKYSampleOrderVarietyItemView *view = [[DKYSampleOrderVarietyItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.varietyView = view;
    
    WeakSelf(weakSelf);
    [self.varietyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
//        make.height.mas_equalTo(80);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.styleNumberView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*品种:";
    self.varietyView.itemModel = itemModel;
}

- (void)setupSizeView{
    DKYSampleOrderSizeItemView *view = [[DKYSampleOrderSizeItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.sizeView = view;
    
    WeakSelf(weakSelf);
    [self.sizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.varietyView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"尺寸:";
    itemModel.textFieldLeftOffset = 16;
    self.sizeView.itemModel = itemModel;
}

- (void)setupJingSizeItemView{
    DKYSampleOrderJingSizeItemView *view = [[DKYSampleOrderJingSizeItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.jingSizeItemView = view;
    
    WeakSelf(weakSelf);
    [self.jingSizeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.sizeView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"净尺寸:";
    itemModel.textFieldLeftOffset = 5;
    self.jingSizeItemView.itemModel = itemModel;
}

- (void)setupJanTypeView{
    DKYSampleOrderJianTypeItemView *view = [[DKYSampleOrderJianTypeItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.jianTypeView = view;
    
    WeakSelf(weakSelf);
    [self.jianTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.jingSizeItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"肩型:";
    itemModel.textFieldLeftOffset = 16;
    self.jianTypeView.itemModel = itemModel;
}


@end
