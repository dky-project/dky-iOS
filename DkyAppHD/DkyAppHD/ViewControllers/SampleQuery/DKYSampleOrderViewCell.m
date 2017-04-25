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
}

- (void)setProductApproveTitleModel:(DKYProductApproveTitleModel *)productApproveTitleModel{
    _productApproveTitleModel = productApproveTitleModel;
    
    self.varietyView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.jianTypeView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.sizeView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.jingSizeItemView.customOrderDimList = productApproveTitleModel.dimListModel;
    
    
    DKYCustomOrderItemModel *model = self.numberView.itemModel;
    model.content = productApproveTitleModel.no;
    self.numberView.itemModel = model;
    
    if(productApproveTitleModel){
        [self getMadeInfoByProductNameFromServer];
    }
}

- (void)setAddProductApproveParameter:(DKYAddProductApproveParameter *)addProductApproveParameter{
    _addProductApproveParameter = addProductApproveParameter;
    
    self.varietyView.addProductApproveParameter = addProductApproveParameter;
    self.sizeView.addProductApproveParameter = addProductApproveParameter;
    self.jingSizeItemView.addProductApproveParameter = addProductApproveParameter;
    self.jianTypeView.addProductApproveParameter = addProductApproveParameter;
    
    // 设置默认值
    addProductApproveParameter.mobile = self.phoneNumberView.itemModel.content;
    addProductApproveParameter.customer = self.clientView.itemModel.content;
    addProductApproveParameter.pdt = self.styleNumberView.itemModel.content;
    addProductApproveParameter.no = self.numberView.itemModel.content;
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
    [self updateModelViews];
    
    // 定制订单，默认赋值参数
    [self updateAddProductApproveParameter];
}

- (void)updateModelViews{
    self.jianTypeView.madeInfoByProductName = self.madeInfoByProductName;
    self.sizeView.madeInfoByProductName = self.madeInfoByProductName;
    self.varietyView.madeInfoByProductName = self.madeInfoByProductName;
    self.jingSizeItemView.madeInfoByProductName = self.madeInfoByProductName;
}

// 款号输入之后，有默认回来的参数，先进行赋值
- (void)updateAddProductApproveParameter{
    // 性别
    self.addProductApproveParameter.mDimNew13Id = self.madeInfoByProductName.productMadeInfoView.mDimNew13Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew13Id): nil;
    
    // 品种
    self.addProductApproveParameter.mDimNew14Id = self.madeInfoByProductName.productMadeInfoView.mDimNew14Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew14Id): nil;
    self.addProductApproveParameter.mDimNew15Id = self.madeInfoByProductName.productMadeInfoView.mDimNew15Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew15Id): nil;
    self.addProductApproveParameter.mDimNew16Id = self.madeInfoByProductName.productMadeInfoView.mDimNew16Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew16Id): nil;
    self.addProductApproveParameter.mDimNew17Id = self.madeInfoByProductName.productMadeInfoView.mDimNew17Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew17Id): nil;
    
    //颜色
    for (DKYDahuoOrderColorModel *model in self.madeInfoByProductName.colorViewList) {
        for (NSString *selectColor in self.madeInfoByProductName.productMadeInfoView.clrRangeArray) {
            if([model.colorName isEqualToString:selectColor]){
                model.selected = YES;
                break;
            }
        }
    }
    
    NSMutableArray *selectedColor = [NSMutableArray array];
    for (DKYDahuoOrderColorModel *model in self.madeInfoByProductName.colorViewList) {
        if(model.selected){
            self.addProductApproveParameter.colorValue = @(model.colorId);
            break;
        }
    }
    
    for (DKYDahuoOrderColorModel *model in self.madeInfoByProductName.colorViewList) {
        if(model.selected){
            [selectedColor addObject:model.colorName];
        }
    }
    
    if(selectedColor.count > 0){
        self.addProductApproveParameter.colorArr = [selectedColor componentsJoinedByString:@";"];
    }
    
    // 式样
    self.addProductApproveParameter.mDimNew12Id = self.madeInfoByProductName.productMadeInfoView.mDimNew12Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew12Id): nil;
    self.addProductApproveParameter.dkNumber = self.madeInfoByProductName.productMadeInfoView.dkValue;
    self.addProductApproveParameter.mDimNew4Id = self.madeInfoByProductName.productMadeInfoView.mDimNew4Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew4Id): nil;
    self.addProductApproveParameter.mDimNew6Id = self.madeInfoByProductName.productMadeInfoView.mDimNew6Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew6Id): nil;
    self.addProductApproveParameter.mDimNew7Id = self.madeInfoByProductName.productMadeInfoView.mDimNew7Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew7Id): nil;
    self.addProductApproveParameter.mDimNew37Id = self.madeInfoByProductName.productMadeInfoView.mDimNew37Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew37Id): nil;
    self.addProductApproveParameter.mDimNew38Id = self.madeInfoByProductName.productMadeInfoView.mDimNew38Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew38Id): nil;
    
    self.addProductApproveParameter.mDimNew39Id = self.madeInfoByProductName.productMadeInfoView.mDimNew39Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew39Id): nil;
    self.addProductApproveParameter.mDimNew1Id = self.madeInfoByProductName.productMadeInfoView.mDimNew1Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew1Id): nil;
    self.addProductApproveParameter.mDimNew3Id = self.madeInfoByProductName.productMadeInfoView.mDimNew3Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew3Id): nil;
    self.addProductApproveParameter.mDimNew18Id = self.madeInfoByProductName.productMadeInfoView.mDimNew18Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew18Id): nil;
    self.addProductApproveParameter.mDimNew19Id = self.madeInfoByProductName.productMadeInfoView.mDimNew19Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew19Id): nil;
    
    
    // 尺寸
    self.addProductApproveParameter.xwValue = self.madeInfoByProductName.productMadeInfoView.xwValue;
    self.addProductApproveParameter.ycValue = self.madeInfoByProductName.productMadeInfoView.ycValue;
    
    // 肩型
    self.addProductApproveParameter.mDimNew22Id = self.madeInfoByProductName.productMadeInfoView.mDimNew22Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew22Id): nil;
    if([self.madeInfoByProductName.productMadeInfoView.jkValue isNotBlank]){
        self.addProductApproveParameter.jkValue = @([self.madeInfoByProductName.productMadeInfoView.jkValue doubleValue]);
    }
    
    // 袖型
    self.addProductApproveParameter.mDimNew9Id = self.madeInfoByProductName.productMadeInfoView.mDimNew9Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew9Id): nil;
    self.addProductApproveParameter.mDimNew9Id1 = self.madeInfoByProductName.productMadeInfoView.mDimNew9Id2 ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew9Id2): nil;
    self.addProductApproveParameter.mDimNew9Id2 = self.madeInfoByProductName.productMadeInfoView.mDimNew9Id3 ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew9Id3): nil;
    if([self.madeInfoByProductName.productMadeInfoView.xcValue isNotBlank]){
        self.addProductApproveParameter.xcValue = @([self.madeInfoByProductName.productMadeInfoView.xcValue doubleValue]);
    }
    
    // 袖边
    self.addProductApproveParameter.xbValue = self.madeInfoByProductName.productMadeInfoView.mDimNew45Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew45Id): nil;
    if([self.madeInfoByProductName.productMadeInfoView.xbcValue isNotBlank]){
        self.addProductApproveParameter.xbcValue = @([self.madeInfoByProductName.productMadeInfoView.xbcValue doubleValue]);
    }
    self.addProductApproveParameter.xbzzValue = self.madeInfoByProductName.productMadeInfoView.mDimNew46Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew46Id): nil;
    
    // 领
    if([self.madeInfoByProductName.productMadeInfoView.lbccValue isNotBlank]){
        self.addProductApproveParameter.lingCcValue = @([self.madeInfoByProductName.productMadeInfoView.lbccValue doubleValue]);
    }
    self.addProductApproveParameter.mDimNew28Id = self.madeInfoByProductName.productMadeInfoView.mDimNew28Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew28Id): nil;
    self.addProductApproveParameter.mDimNew26Id = self.madeInfoByProductName.productMadeInfoView.mDimNew26Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew26Id): nil;
    self.addProductApproveParameter.mDimNew25Id = self.madeInfoByProductName.productMadeInfoView.mDimNew25Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew25Id): nil;
    
    
    self.addProductApproveParameter.mDimNew10Id = self.madeInfoByProductName.productMadeInfoView.mDimNew10Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew10Id): nil;
    self.addProductApproveParameter.mDimNew32Id = self.madeInfoByProductName.productMadeInfoView.mDimNew32Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew32Id): nil;
    
    self.addProductApproveParameter.lxsx5Value = self.madeInfoByProductName.productMadeInfoView.lxRemark;
    
    // 下边
    self.addProductApproveParameter.xbccValue = self.madeInfoByProductName.productMadeInfoView.xbccValue ? @(self.madeInfoByProductName.productMadeInfoView.xbccValue): nil;
    self.addProductApproveParameter.mDimNew10Id = self.madeInfoByProductName.productMadeInfoView.mDimNew10Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew10Id): nil;
    self.addProductApproveParameter.qtxbValue = self.madeInfoByProductName.productMadeInfoView.xbRemark;
    
    // 袖口
    if([self.madeInfoByProductName.productMadeInfoView.xkccValue isNotBlank]){
        self.addProductApproveParameter.xkccValue = @([self.madeInfoByProductName.productMadeInfoView.xkccValue doubleValue]);
    }
    self.addProductApproveParameter.mDimNew32Id = self.madeInfoByProductName.productMadeInfoView.mDimNew32Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew32Id): nil;
    
    // 加注
    self.addProductApproveParameter.jzValue = self.madeInfoByProductName.productMadeInfoView.jzValue;
    
    self.addProductApproveParameter.mDimNew41Id = self.madeInfoByProductName.productMadeInfoView.mDimNew41Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew41Id): nil;
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
        weakSelf.addProductApproveParameter.no = textField.text;
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
        weakSelf.addProductApproveParameter.customer = textField.text;
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
    itemModel.enabled = NO;
    
//    itemModel.textFieldDidEndEditing = ^(UITextField *sender){
//        
//    };
    
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
    itemModel.content = @"1";
    itemModel.textFieldDidEndEditing = ^(UITextField *textField){
        
    };
    
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
        weakSelf.addProductApproveParameter.mobile = textField.text;
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
