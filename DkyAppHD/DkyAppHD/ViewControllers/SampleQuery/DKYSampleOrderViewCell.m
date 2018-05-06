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
#import "DKYSampleOrderXiuTypeItemView.h"
#import "DKYSampleOrderJianTypeItemView.h"
#import "DKYGetSizeDataParameter.h"
#import "DKYGetSizeDataModel.h"
#import "DKYSampleOrderPatternItemView.h"
#import "DKYSampleOrderSLingItemView.h"

static const CGFloat topOffset = 30;
static const CGFloat leftOffset = 20;

static const CGFloat hpadding = 30;
static const CGFloat vpadding = 20;

static const CGFloat basicItemWidth = 265;
static const CGFloat basicItemHeight = 45;

@interface DKYSampleOrderViewCell ()

// 编号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *numberView;
// 客户号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *clientView;

// 手机号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *phoneNumberView;

// 款号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *styleNumberView;

// 数量
@property (nonatomic, weak) DKYCustomOrderTextFieldView *sumView;

// 品种
@property (nonatomic, weak) DKYSampleOrderVarietyItemView *varietyView;

// 式样
@property (nonatomic, weak) DKYSampleOrderPatternItemView *patternItemView;

// 尺寸View
@property (nonatomic, weak) DKYSampleOrderSizeItemView *sizeView;

// 肩型
@property (nonatomic, weak) DKYSampleOrderJianTypeItemView *jianTypeItemView;

// 袖型
@property (nonatomic, weak) DKYSampleOrderXiuTypeItemView *xiuTypeView;

// 领型
@property (nonatomic, weak) DKYSampleOrderSLingItemView *lingItemView;

@property (nonatomic, strong) DKYMadeInfoByProductNameModel *madeInfoByProductName;


@property (nonatomic, strong) DKYGetSizeDataModel *getSizeDataModel;

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

- (void)fetchAddProductApproveInfo{
    [self.patternItemView fetchAddProductApproveInfo];
    [self.lingItemView fetchAddProductApproveInfo];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, self.tw_height - 1)];
    [path addLineToPoint:CGPointMake(self.tw_width - 20, self.tw_height - 1)];
    [[UIColor colorWithHex:0x999999] setStroke];
    
    [path setLineWidth:1];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapButt];
    
    CGFloat lengths[2] = { 1, 1 };
    CGContextSetLineDash(context, 0, lengths, 2);
    [path stroke];
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
    self.xiuTypeView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.sizeView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.jianTypeItemView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.patternItemView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.lingItemView.customOrderDimList = productApproveTitleModel.dimListModel;
    
    self.lingItemView.staticDimListModel = productApproveTitleModel.staticDimListModel;
    
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
    self.jianTypeItemView.addProductApproveParameter = addProductApproveParameter;
    self.xiuTypeView.addProductApproveParameter = addProductApproveParameter;
    self.patternItemView.addProductApproveParameter = addProductApproveParameter;
    self.lingItemView.addProductApproveParameter = addProductApproveParameter;
    
    // 设置默认值
    addProductApproveParameter.mobile = self.phoneNumberView.itemModel.content;
    addProductApproveParameter.customer = self.clientView.itemModel.content;
    addProductApproveParameter.pdt = self.styleNumberView.itemModel.content;
    addProductApproveParameter.no = self.numberView.itemModel.content;
}

#pragma mark - 网络请求

- (void)getMadeInfoByProductNameFromServer{
    if(self.madeInfoByProductName) return;
    
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
            
            if(weakSelf.imageBlock){
                weakSelf.imageBlock(weakSelf.madeInfoByProductName.productMadeInfoView.imgUrlList);
            }
            
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

- (void)getSizeDataFromServer:(NSString*)xwValue{
    [DKYHUDTool show];
    
    WeakSelf(weakSelf);
    DKYGetSizeDataParameter *p = [[DKYGetSizeDataParameter alloc] init];
    p.xwValue = xwValue;
    p.pdt = self.sampleProductInfo.name;
    
    [[DKYHttpRequestManager sharedInstance] getSizeDataWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.getSizeDataModel = [DKYGetSizeDataModel mj_objectWithKeyValues:result.data];
            [weakSelf.sizeView dealWithXwValueSelected:weakSelf.getSizeDataModel];
            [weakSelf.xiuTypeView dealWithXwValueSelected:weakSelf.getSizeDataModel];
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
    self.xiuTypeView.madeInfoByProductName = self.madeInfoByProductName;
    self.sizeView.madeInfoByProductName = self.madeInfoByProductName;
    self.varietyView.madeInfoByProductName = self.madeInfoByProductName;
    self.jianTypeItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.patternItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.lingItemView.madeInfoByProductName = self.madeInfoByProductName;
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
    
    self.addProductApproveParameter.mjkValue = [self.madeInfoByProductName.productMadeInfoView.mjkValue isNotBlank] ? @([self.madeInfoByProductName.productMadeInfoView.mjkValue doubleValue]) : nil;
    self.addProductApproveParameter.hzxcValue = self.madeInfoByProductName.productMadeInfoView.hzxcValue;
    
    // 尺寸
    self.addProductApproveParameter.xwValue = self.madeInfoByProductName.productMadeInfoView.xwValue;
    self.addProductApproveParameter.ycValue = self.madeInfoByProductName.productMadeInfoView.ycValue;
    
    // 肩型
    self.addProductApproveParameter.mDimNew22Id = self.madeInfoByProductName.productMadeInfoView.mDimNew22Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew22Id): nil;
    if([self.madeInfoByProductName.productMadeInfoView.jkValue isNotBlank]){
        self.addProductApproveParameter.jkValue = @([self.madeInfoByProductName.productMadeInfoView.jkValue doubleValue]);
    }
    
    self.addProductApproveParameter.hzxc1Value = self.madeInfoByProductName.productMadeInfoView.hzxcValue;
    
    // 袖型
    self.addProductApproveParameter.mDimNew9Id = self.madeInfoByProductName.productMadeInfoView.mDimNew9Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew9Id): nil;
    self.addProductApproveParameter.mDimNew9Id1 = self.madeInfoByProductName.productMadeInfoView.mDimNew9Id2 ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew9Id2): nil;
    self.addProductApproveParameter.mDimNew9Id2 = self.madeInfoByProductName.productMadeInfoView.mDimNew9Id3 ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew9Id3): nil;
    if([self.madeInfoByProductName.productMadeInfoView.xcValue isNotBlank]){
        self.addProductApproveParameter.xcValue = self.madeInfoByProductName.productMadeInfoView.xcValue;
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
    self.addProductApproveParameter.qtxkValue = self.madeInfoByProductName.productMadeInfoView.xkRemark;
    
    // 加注
    self.addProductApproveParameter.jzValue = self.madeInfoByProductName.productMadeInfoView.jzValue;
    
    self.addProductApproveParameter.mDimNew41Id = self.madeInfoByProductName.productMadeInfoView.mDimNew41Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew41Id): nil;
    
    
    self.addProductApproveParameter.defaultHzxc1Value = self.addProductApproveParameter.hzxc1Value;
    self.addProductApproveParameter.defaultYcValue = @([self.addProductApproveParameter.ycValue doubleValue]);
    self.addProductApproveParameter.defaultXcValue = @([self.madeInfoByProductName.productMadeInfoView.xcLeftValue doubleValue]);
}

- (void)dealwithMDimNew15IdSelected{
    [self.sizeView dealwithMDimNew15IdSelected];
}

- (void)dealwithMDimNew12IdSelected{
    [self.jianTypeItemView dealwithMDimNew12IdSelected];
    [self.xiuTypeView dealwithMDimNew12IdSelected];
    [self.lingItemView dealwithMDimNew12IdSelected];
}

#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 第一行 编号
    [self setupNumberView];
    
    // 第二行 客户，手机号
    [self setupClientView];
    [self setupPhoneNumberView];
    
    // 款号 ，数量
    [self setupStyleNumberView];
    [self setupSumView];

    // 第三大行 品种 4个选择器
    [self setupVarietyView];
    
    // 第四大行， 式样
    [self setupPatternItemView];
    
    // 第五大行，尺寸
    [self setupSizeView];

    // 第六大行，净尺寸
    [self setupJingSizeItemView];

    // 第七大行,肩型
    [self setupJanTypeView];
    
    // 领型
    [self setupLingItemView];
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
    itemModel.zoomed = YES;
    self.numberView.itemModel = itemModel;
}


- (void)setupClientView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.clientView = view;
    
    WeakSelf(weakSelf);
    [self.clientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.numberView);
        make.width.mas_equalTo(weakSelf.numberView);
        make.height.mas_equalTo(weakSelf.numberView);
        
        make.top.mas_equalTo(weakSelf.numberView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*客户:";
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        // 客户号
        weakSelf.addProductApproveParameter.customer = textField.text;
    };
    itemModel.content = @"";
    itemModel.zoomed = YES;
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
        make.top.mas_equalTo(weakSelf.clientView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*款号:";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.enabled = NO;
    itemModel.zoomed = YES;
    
//    itemModel.textFieldDidEndEditing = ^(UITextField *sender){
//        
//    };
    
    self.styleNumberView.itemModel = itemModel;
}

- (void)setupSumView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.sumView = view;
    
    WeakSelf(weakSelf);
    [self.sumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView.mas_right).with.offset(hpadding);
        make.width.mas_equalTo(weakSelf.styleNumberView);
        make.height.mas_equalTo(weakSelf.styleNumberView);
        make.top.mas_equalTo(weakSelf.styleNumberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"数量:";
    itemModel.content = @"1";
    itemModel.keyboardType = UIKeyboardTypePhonePad;
    
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        weakSelf.addProductApproveParameter.sum = textField.text;
    };
    itemModel.zoomed = YES;
    self.sumView.itemModel = itemModel;
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
        make.top.mas_equalTo(weakSelf.clientView);
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
    itemModel.zoomed = YES;
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
        make.height.mas_equalTo(175);
//        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.styleNumberView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*品种:";
    itemModel.zoomed = YES;
    self.varietyView.itemModel = itemModel;
    self.varietyView.mDimNew15IdBlock = ^(id sender, NSInteger type){
        [weakSelf dealwithMDimNew15IdSelected];
    };
}

- (void)setupPatternItemView{
    DKYSampleOrderPatternItemView *view = [[DKYSampleOrderPatternItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.patternItemView = view;
    
    WeakSelf(weakSelf);
    [self.patternItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.varietyView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*式样:";
    itemModel.zoomed = YES;
    self.patternItemView.itemModel = itemModel;
    self.patternItemView.mDimNew12IdBlock = ^(id sender,NSInteger type){
        [weakSelf dealwithMDimNew12IdSelected];
    };
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
        make.top.mas_equalTo(weakSelf.patternItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"尺寸:";
    itemModel.textFieldLeftOffset = 16;
    itemModel.zoomed = YES;
    self.sizeView.itemModel = itemModel;
    
    self.sizeView.xwValueSelectedBlock = ^(id sender, NSString *value) {
        [weakSelf getSizeDataFromServer:value];
    };
}

- (void)setupJingSizeItemView{
    DKYSampleOrderJianTypeItemView *view = [[DKYSampleOrderJianTypeItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.jianTypeItemView = view;
    
    WeakSelf(weakSelf);
    [self.jianTypeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.sizeView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"工艺袖长";
    itemModel.textFieldLeftOffset = 5;
    itemModel.zoomed = YES;
    self.jianTypeItemView.itemModel = itemModel;
}

- (void)setupJanTypeView{
    DKYSampleOrderXiuTypeItemView *view = [[DKYSampleOrderXiuTypeItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.xiuTypeView = view;
    
    WeakSelf(weakSelf);
    [self.xiuTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.jianTypeItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"袖长";
    itemModel.textFieldLeftOffset = 16;
    itemModel.zoomed = YES;
    self.xiuTypeView.itemModel = itemModel;
}

- (void)setupLingItemView{
    DKYSampleOrderSLingItemView *view = [[DKYSampleOrderSLingItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.lingItemView = view;
    
    WeakSelf(weakSelf);
    [self.lingItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(345);
        make.top.mas_equalTo(weakSelf.xiuTypeView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"领";
    itemModel.textFieldLeftOffset = 16;
    itemModel.zoomed = YES;
    self.lingItemView.itemModel = itemModel;
}

@end
