//
//  DKYTongkuanFiveViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/5/18.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYTongkuanFiveViewCell.h"
#import "UIButton+Custom.h"
#import "MMPopupItem.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#import "DKYCustomOrderTextFieldView.h"
#import "DKYCustomOrderTextFieldView.h"
#import "DKYCustomOrderItemModel.h"
#import "DKYCustomOrderGenderItemView.h"
#import "DKYTongkuan5VarietyItemView.h"
#import "DKYTongkuan5PatternItemView.h"
#import "DKYTongkuan5SizeItemView.h"
#import "DKYTongkuan5JingSizeItemView.h"
#import "DKYTongkuan5JianTypeItemView.h"
#import "DKYTongkuan5XiuTypeItemView.h"
#import "DKYTongkuan5XiuBianItemView.h"
#import "DKYTongkuan5LingItemView.h"


#import "DKYCustomOrderSpecialCraftItemView.h"
#import "DKYCustomOrderXiabianItemView.h"
#import "DKYCustomOrderXiukouItemView.h"
#import "DKYCustomOrderMatchItemView.h"
#import "DKYCustomOrderFlowerTypeItemView.h"
#import "DKYCustomOrderTangzhuItemView.h"
#import "DKYCustomOrderKoudaiItemView.h"
#import "DKYCustomOrderAttachmentItemView.h"
#import "DKYProductApproveTitleModel.h"
#import "DKYDahuoPopupView.h"
#import "DKYMadeInfoByProductNameParameter.h"
#import "DKYMadeInfoByProductNameModel.h"
#import "DKYCustomOrderAddMarkItemView.h"
#import "DKYVipNameParameter.h"
#import "DKYMptApproveSaveParameter.h"
#import "DKYAddProductApproveParameter.h"
#import "DKYDahuoOrderColorModel.h"
#import "NSString+STRegex.h"
#import "DKYGetSizeDataParameter.h"
#import "DKYGetSizeDataModel.h"

static const CGFloat topOffset = 30;
static const CGFloat leftOffset = 53;

static const CGFloat hpadding = 37;
static const CGFloat vpadding = 20;

static const CGFloat basicItemWidth = 196;
static const CGFloat basicItemHeight = 30;

@interface DKYTongkuanFiveViewCell ()

@property (nonatomic, copy) NSString *productName;

// 请求参数
// 大货订单参数
@property (nonatomic, strong) DKYMptApproveSaveParameter *mptApproveSaveParameter;

@property (nonatomic, strong) DKYGetSizeDataModel *getSizeDataModel;

// 编号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *numberView;

// 客户号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *clientView;

// 手机号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *phoneNumberView;

// 款号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *styleNumberView;

// 性别
@property (nonatomic, weak) DKYCustomOrderGenderItemView *genderItemView;

// 品种
@property (nonatomic, weak) DKYTongkuan5VarietyItemView *varietyView;

// 式样
@property (nonatomic, weak) DKYTongkuan5PatternItemView *patternItemView;

// 尺寸View
@property (nonatomic, weak) DKYTongkuan5SizeItemView *sizeView;

// 净尺寸
@property (nonatomic, weak) DKYTongkuan5JingSizeItemView *jingSizeItemView;

// 肩型
@property (nonatomic, weak) DKYTongkuan5JianTypeItemView *jianTypeView;

// 袖型
@property (nonatomic, weak) DKYTongkuan5XiuTypeItemView *xiuTypeView;

// 袖边
@property (nonatomic, weak) DKYTongkuan5XiuBianItemView *xiuBianView;

// 领
@property (nonatomic, weak) DKYTongkuan5LingItemView *lingView;

// 花型
@property (nonatomic, weak) DKYCustomOrderFlowerTypeItemView *flowerTypeItemView;

// 烫珠
@property (nonatomic, weak) DKYCustomOrderTangzhuItemView *tangzhuItemView;

// 口袋
@property (nonatomic, weak) DKYCustomOrderKoudaiItemView *koudaiItemView;

// 附件
@property (nonatomic, weak) DKYCustomOrderAttachmentItemView *attachmentItemView;

// 特殊工艺
@property (nonatomic, weak) DKYCustomOrderSpecialCraftItemView *specialCraftItemView;

// 下边
@property (nonatomic, weak) DKYCustomOrderXiabianItemView *xiabianItemView;

// 袖口
@property (nonatomic, weak) DKYCustomOrderXiukouItemView *xiukouItemView;

// 加注
@property (nonatomic, weak) DKYCustomOrderAddMarkItemView *addMarkView;

// 配套
@property (nonatomic, weak) DKYCustomOrderMatchItemView *matchItemView;

// 图片
@property (nonatomic, weak) UIImageView *displayImageView;
//@property (nonatomic, weak) UILabel *titleLabel;


@end

@implementation DKYTongkuanFiveViewCell

+ (instancetype)tongkuanFiveViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYTongkuanFiveViewCell";
    DKYTongkuanFiveViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYTongkuanFiveViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    [self.flowerTypeItemView fetchAddProductApproveInfo];
    [self.koudaiItemView fetchAddProductApproveInfo];
    [self.attachmentItemView fetchAddProductApproveInfo];
    [self.specialCraftItemView fetchAddProductApproveInfo];
    [self.tangzhuItemView fetchAddProductApproveInfo];
    [self.lingView fetchAddProductApproveInfo];
    [self.patternItemView fetchAddProductApproveInfo];
}

- (void)reset{
    // 结束编辑
    [self endEditing:YES];
    // 逻辑成员变量
    self.productName = nil;
    self.mptApproveSaveParameter = nil;
    self.madeInfoByProductName = nil;
    
    [self updateModelViews];
    
    // UI 属性
    // 第一行 款号，客户，手机号
    [self.numberView clear];
//    [self.clientView clear];
    [self.phoneNumberView clear];
    
    // 第二行 款号，性别
    [self.styleNumberView clear];
    [self.genderItemView clear];
    
    // 第三大行 品种 4个选择器
    [self.varietyView clear];
    
    // 第四大行， 式样
    [self.patternItemView clear];
    
    // 第五大行，尺寸
    [self.sizeView clear];
    
    // 第六大行，净尺寸
    [self.jingSizeItemView clear];
    
    // 第七大行,肩型
    [self.jianTypeView clear];
    
    // 第八大行，袖型
    [self.xiuTypeView clear];
    
    // 第九大行，袖边
    [self.xiuBianView clear];
    
    // 第十大行，领
    [self.lingView clear];
    
    // 第十一大行，花型
    [self.flowerTypeItemView clear];
    
    // 第十二大行，烫珠
    [self.tangzhuItemView clear];
    
    // 第十三大行，口袋
    [self.koudaiItemView clear];
    
    // 第十四大行,附件
    [self.attachmentItemView clear];
    
    // 第十五大行，特殊工艺
    [self.specialCraftItemView clear];
    
    // 第十六行，下边
    [self.xiabianItemView clear];
    
    // 第十七行，袖口
    [self.xiukouItemView clear];
    
    // 第十八大行,加注
    [self.addMarkView clear];
    
    // 第十九行，配套
    [self.matchItemView clear];
    
    // 图片
    self.displayImageView.image = nil;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(72, self.tw_height - 1)];
    [path addLineToPoint:CGPointMake(self.tw_width - 72, self.tw_height - 1)];
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
    
    self.genderItemView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.varietyView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.patternItemView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.jianTypeView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.xiuBianView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.lingView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.xiabianItemView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.xiukouItemView.customOrderDimList = productApproveTitleModel.dimListModel;
    self.matchItemView.customOrderDimList = productApproveTitleModel.dimListModel;
    
    self.xiuTypeView.staticDimListModel = productApproveTitleModel.staticDimListModel;
    self.lingView.staticDimListModel = productApproveTitleModel.staticDimListModel;
}

- (void)setAddProductApproveParameter:(DKYAddProductApproveParameter *)addProductApproveParameter{
    _addProductApproveParameter = addProductApproveParameter;
    
    self.genderItemView.addProductApproveParameter = addProductApproveParameter;
    self.varietyView.addProductApproveParameter = addProductApproveParameter;
    self.patternItemView.addProductApproveParameter = addProductApproveParameter;
    self.sizeView.addProductApproveParameter = addProductApproveParameter;
    self.jingSizeItemView.addProductApproveParameter = addProductApproveParameter;
    self.jianTypeView.addProductApproveParameter = addProductApproveParameter;
    self.xiuTypeView.addProductApproveParameter = addProductApproveParameter;
    self.xiuBianView.addProductApproveParameter = addProductApproveParameter;
    self.lingView.addProductApproveParameter = addProductApproveParameter;
    self.flowerTypeItemView.addProductApproveParameter = addProductApproveParameter;
    
    self.tangzhuItemView.addProductApproveParameter = addProductApproveParameter;
    self.koudaiItemView.addProductApproveParameter = addProductApproveParameter;
    self.attachmentItemView.addProductApproveParameter = addProductApproveParameter;
    self.specialCraftItemView.addProductApproveParameter = addProductApproveParameter;
    self.xiabianItemView.addProductApproveParameter = addProductApproveParameter;
    
    self.xiukouItemView.addProductApproveParameter = addProductApproveParameter;
    self.addMarkView.addProductApproveParameter = addProductApproveParameter;
    self.matchItemView.addProductApproveParameter = addProductApproveParameter;
}

- (void)updateModelViews{
    //    WeakSelf(weakSelf);
    self.xiuBianView.madeInfoByProductName = self.madeInfoByProductName;
    self.jianTypeView.madeInfoByProductName = self.madeInfoByProductName;
    self.flowerTypeItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.tangzhuItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.koudaiItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.attachmentItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.specialCraftItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.sizeView.madeInfoByProductName = self.madeInfoByProductName;
    self.xiuTypeView.madeInfoByProductName = self.madeInfoByProductName;
    self.varietyView.madeInfoByProductName = self.madeInfoByProductName;
    self.lingView.madeInfoByProductName = self.madeInfoByProductName;
    self.patternItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.xiukouItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.xiabianItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.genderItemView.madeInfoByProductName = self.madeInfoByProductName;
    self.addMarkView.madeInfoByProductName = self.madeInfoByProductName;
    self.matchItemView.madeInfoByProductName = self.madeInfoByProductName;
    
    if(self.madeInfoByProductName){
        NSURL *url = [NSURL URLWithString:self.madeInfoByProductName.productMadeInfoView.imgUrl];
        [self.displayImageView sd_setImageWithURL:url];
    }
    
    //    WeakSelf(weakSelf);
    //    if([self needHideKoudai]){
    //        self.koudaiItemView.hidden = YES;
    //        [self.koudaiItemView mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(0);
    //            make.top.mas_equalTo(weakSelf.tangzhuItemView.mas_bottom).with.offset(0);
    //        }];
    //    }else{
    //        self.koudaiItemView.hidden = NO;
    //        [self.koudaiItemView mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(80);
    //            make.top.mas_equalTo(weakSelf.tangzhuItemView.mas_bottom).with.offset(vpadding);
    //        }];
    //    }
}

#pragma mark - 网络请你去
- (void)getMadeInfoByProductNameFromServer{
    [DKYHUDTool show];
    DKYMadeInfoByProductNameParameter *p = [[DKYMadeInfoByProductNameParameter alloc] init];
    p.productName = self.productName;
    
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] getMadeInfoByProductNameWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.madeInfoByProductName = [DKYMadeInfoByProductNameModel mj_objectWithKeyValues:result.data];
            //            weakSelf.madeInfoByProductName.productMadeInfoView.mDimNew13Id = 364;
            //            weakSelf.madeInfoByProductName.productMadeInfoView.mDimNew12Id = 367;
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

- (void)getVipInfoFromServer:(NSString*)phone{
    //    [DKYHUDTool show];
    
    WeakSelf(weakSelf);
    DKYVipNameParameter *p = [[DKYVipNameParameter alloc] init];
    p.phone = phone;
    [[DKYHttpRequestManager sharedInstance] getVipInfoWithParameter:p Success:^(NSInteger statusCode, id data) {
        //        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            NSString *info = result.data;
            if([info isNotBlank]){
                info = [NSString stringWithFormat:@"%@(%@)",self.addProductApproveParameter.mobile,info];
                weakSelf.phoneNumberView.itemModel.content = info;
                weakSelf.phoneNumberView.itemModel = weakSelf.phoneNumberView.itemModel;
            }
        }
        //        else if (retCode == DkyHttpResponseCode_NotLogin) {
        //            // 用户未登录,弹出登录页面
        //            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
        //            [DKYHUDTool showErrorWithStatus:result.msg];
        //        }else{
        //            NSString *retMsg = result.msg;
        //            [DKYHUDTool showErrorWithStatus:retMsg];
        //        }
    } failure:^(NSError *error) {
        //        [DKYHUDTool dismiss];
        //        DLog(@"Error = %@",error.description);
        //        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

- (void)mptApproveSaveToServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    self.mptApproveSaveParameter.jgNo = self.productApproveTitleModel.code;
    self.mptApproveSaveParameter.productName = self.productName;
    
    [[DKYHttpRequestManager sharedInstance] mptApproveSaveWithParameter:self.mptApproveSaveParameter Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            // 下单成功
            [DKYHUDTool showSuccessWithStatus:@"下单成功!"];
            
            // 清空数据
            [weakSelf reset];
            
            // 重新刷新页面
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if(weakSelf.refreshBlock){
                    weakSelf.refreshBlock(nil);
                }
            });
            return;
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        [DKYHUDTool dismiss];
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool dismiss];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

- (void)getSizeDataFromServer:(NSString*)xwValue{
    [DKYHUDTool show];
    
    WeakSelf(weakSelf);
    DKYGetSizeDataParameter *p = [[DKYGetSizeDataParameter alloc] init];
    p.xwValue = xwValue;
    p.pdt = self.productName;
    
    [[DKYHttpRequestManager sharedInstance] getSizeDataWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.getSizeDataModel = [DKYGetSizeDataModel mj_objectWithKeyValues:result.data];
            [weakSelf.sizeView dealWithXwValueSelected:weakSelf.getSizeDataModel];
            [weakSelf.xiuTypeView dealWithXwValueSelected:weakSelf.getSizeDataModel];
            [weakSelf.jianTypeView dealWithXwValueSelected:weakSelf.getSizeDataModel];
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

#pragma mark - mark - private method
- (void)styleNumberViewDidEndEditing:(NSString *)text{
    self.productName = text;
    self.addProductApproveParameter.pdt = self.productName;
    if(![text isNotBlank]){
        [DKYHUDTool showInfoWithStatus:@"款号不能为空！"];
        self.madeInfoByProductName = nil;
        [self updateModelViews];
        return;
    }else{
        
        [self getMadeInfoByProductNameFromServer];
    }
}

- (void)dealWithstyleNumber{
    if(self.madeInfoByProductName.isBigOrder){
        [self showDahuoPopupView];
        return;
    }
    
    [self updateModelViews];
    
    // 定制订单，默认赋值参数
    [self updateAddProductApproveParameter];
}

- (BOOL)needHideKoudai{
    NSInteger mDimNew12Id = self.madeInfoByProductName.productMadeInfoView.mDimNew12Id;
    if(mDimNew12Id == 68 ||
       mDimNew12Id == 61 ||
       mDimNew12Id == 307 ||
       mDimNew12Id == 308 ||
       mDimNew12Id == 309){
        return YES;
    }
    
    return NO;
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
    
    self.addProductApproveParameter.mjkValue = [self.madeInfoByProductName.productMadeInfoView.mjkValue isNotBlank] ? @([self.madeInfoByProductName.productMadeInfoView.mjkValue doubleValue]) : nil;
    
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
    self.addProductApproveParameter.qtxkValue = self.madeInfoByProductName.productMadeInfoView.xkRemark;
    
    // 加注
    self.addProductApproveParameter.jzValue = self.madeInfoByProductName.productMadeInfoView.jzValue;
    
    self.addProductApproveParameter.mDimNew41Id = self.madeInfoByProductName.productMadeInfoView.mDimNew41Id ? @(self.madeInfoByProductName.productMadeInfoView.mDimNew41Id): nil;
    
    self.addProductApproveParameter.defaultHzxc1Value = self.addProductApproveParameter.hzxc1Value;
    self.addProductApproveParameter.defaultYcValue = @([self.addProductApproveParameter.ycValue doubleValue]);
    self.addProductApproveParameter.defaultXcValue = self.addProductApproveParameter.xcValue;
}

- (void)dealwithMDimNew12IdSelected{
    [self.genderItemView dealwithMDimNew12IdSelected];
    [self.varietyView dealwithMDimNew12IdSelected];
    [self.patternItemView dealwithMDimNew12IdSelected];
    [self.sizeView dealwithMDimNew12IdSelected];
    [self.jingSizeItemView dealwithMDimNew12IdSelected];
    [self.jianTypeView dealwithMDimNew12IdSelected];
    [self.xiuTypeView dealwithMDimNew12IdSelected];
    
    [self.xiuBianView dealwithMDimNew12IdSelected];
    [self.lingView dealwithMDimNew12IdSelected];
    [self.flowerTypeItemView dealwithMDimNew12IdSelected];
    [self.tangzhuItemView dealwithMDimNew12IdSelected];
    [self.koudaiItemView dealwithMDimNew12IdSelected];
    
    [self.attachmentItemView dealwithMDimNew12IdSelected];
    [self.specialCraftItemView dealwithMDimNew12IdSelected];
    [self.xiabianItemView dealwithMDimNew12IdSelected];
    [self.xiukouItemView dealwithMDimNew12IdSelected];
    [self.addMarkView dealwithMDimNew12IdSelected];
    
    [self.matchItemView dealwithMDimNew12IdSelected];
}

- (void)dealwithMDimNew22IdSelected{
    [self.xiuTypeView dealwithMDimNew22IdSelected];
    [self.sizeView dealwithMDimNew22IdSelected];
}

- (void)dealwithMDimNew13IdSelected{
    [self.genderItemView dealwithMDimNew13IdSelected];
    [self.patternItemView dealwithMDimNew13IdSelected];
    [self.sizeView dealwithMDimNew13IdSelected];
    [self.jingSizeItemView dealwithMDimNew13IdSelected];
    [self.jianTypeView dealwithMDimNew13IdSelected];
    [self.xiuTypeView dealwithMDimNew13IdSelected];
    
    [self.xiuBianView dealwithMDimNew13IdSelected];
    [self.lingView dealwithMDimNew13IdSelected];
    [self.flowerTypeItemView dealwithMDimNew13IdSelected];
    [self.tangzhuItemView dealwithMDimNew13IdSelected];
    [self.koudaiItemView dealwithMDimNew13IdSelected];
    
    [self.attachmentItemView dealwithMDimNew13IdSelected];
    [self.specialCraftItemView dealwithMDimNew13IdSelected];
    [self.xiabianItemView dealwithMDimNew13IdSelected];
    [self.xiukouItemView dealwithMDimNew13IdSelected];
    [self.addMarkView dealwithMDimNew13IdSelected];
    
    [self.matchItemView dealwithMDimNew13IdSelected];
}

- (void)dealwithMDimNew15IdSelected{
    [self.sizeView dealwithMDimNew15IdSelected];
}

#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    //    if(self.optionsBtnClicked){
    //        self.optionsBtnClicked(sender,sender.tag);
    //    }
    [self showOptionsPicker];
}

#pragma mark - help method
- (void)showOptionsPicker{
    [self.superview endEditing:YES];
    MMPopupItemHandler block = ^(NSInteger index){
        DLog(@"++++++++ index = %@",@(index));
    };
    
    NSArray *item = @[@"1",@"2",@"3",@"4",@"5"];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:item.count + 1];
    for (NSString *str in item) {
        [items addObject:MMItemMake(str, MMItemTypeNormal, block)];
    }
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"点击选择内容"
                                                          items:[items copy]];
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [sheetView show];
}

- (void)showDahuoPopupView{
    WeakSelf(weakSelf);
    DKYDahuoPopupView *popup = [DKYDahuoPopupView show];
    popup.madeInfoByProductNameModel = self.madeInfoByProductName;
    popup.mptApproveSaveParameter = self.mptApproveSaveParameter;
    popup.productName = self.productName;
    popup.cancelBtnClicked = ^(UIButton *sender){
        [weakSelf.styleNumberView clear];
    };
    
    popup.confirmBtnClicked = ^(DKYDahuoPopupView *popup){
        if(weakSelf.mptApproveSaveParameter.sizeId == nil){
            [DKYHUDTool showErrorWithStatus:@"请选择尺寸"];
            return ;
        }
        
        if(weakSelf.mptApproveSaveParameter.colorId == nil){
            [DKYHUDTool showErrorWithStatus:@"请选择颜色"];
            return ;
        }
        
        [popup dismiss];
        [weakSelf mptApproveSaveToServer];
    };
}

#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 第一行 款号，客户，手机号
    [self setupNumberView];
    [self setupClientView];
    [self setupGenderItemView];
    // 第二行 款号，性别
    [self setupStyleNumberView];
    [self setupPhoneNumberView];
    
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
    
    // 第八大行，袖型
    [self setupXiuTypeView];
    
    // 第九大行，袖边
    [self setupXiuBianView];
    
    // 第十大行，领
    [self setupLingView];
    
    // 第十一大行，花型
    [self setupFlowerTypeItemView];
    
    // 第十二大行，烫珠
    [self setupTangzhuItemView];
    
    // 第十三大行，口袋
    [self setupKoudaiItemView];
    
    // 第十四大行,附件
    [self setupAttachmentItemView];
    
    // 第十五大行，特殊工艺
    [self setupSpecialCraftItemView];
    
    // 第十六行，下边
    [self setupXiabianItemView];
    
    // 第十七行，袖口
    [self setupXiukouItemView];
    
    // 第十八大行,加注
    [self setupAddMarkView];
    
    // 第十九行，配套
    [self setupMatchItemView];
    
    // 图片
    [self setupDisplayImageView];
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
    itemModel.content = @"同款五";
    itemModel.enabled = NO;
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        // 客户号
        weakSelf.addProductApproveParameter.customer = textField.text;
    };
    self.clientView.itemModel = itemModel;
}

- (void)setupGenderItemView{
    DKYCustomOrderGenderItemView *view = [[DKYCustomOrderGenderItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.genderItemView = view;
    
    WeakSelf(weakSelf);
    [self.genderItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.clientView.mas_right).with.offset(hpadding);
        make.width.mas_equalTo(weakSelf.numberView);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.numberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*性别:";
    self.genderItemView.itemModel = itemModel;
    self.genderItemView.mDimNew13IdBlock = ^(id sender, NSInteger type){
        [weakSelf dealwithMDimNew13IdSelected];
    };
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
    
    
    itemModel.textFieldDidEndEditing = ^(UITextField *sender){
        [weakSelf styleNumberViewDidEndEditing:sender.text];
    };
    
    self.styleNumberView.itemModel = itemModel;
}

- (void)setupPhoneNumberView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.phoneNumberView = view;
    
    WeakSelf(weakSelf);
    [self.phoneNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.clientView);
        make.height.mas_equalTo(weakSelf.numberView);
        make.right.mas_equalTo(weakSelf.genderItemView);
        make.top.mas_equalTo(weakSelf.styleNumberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*手机号:";
    itemModel.keyboardType = UIKeyboardTypePhonePad;
    itemModel.textFieldDidEndEditing = ^(UITextField *textField){
        //        if(![textField.text isValidPhoneNum]){
        //            [DKYHUDTool showInfoWithStatus:@"请输入有效的手机号！"];
        //            return;
        //        }
        [weakSelf getVipInfoFromServer:textField.text];
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
    DKYTongkuan5VarietyItemView *view = [[DKYTongkuan5VarietyItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.varietyView = view;
    
    WeakSelf(weakSelf);
    [self.varietyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(80);
        make.top.mas_equalTo(weakSelf.styleNumberView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*品种:";
    self.varietyView.itemModel = itemModel;
//    self.varietyView.mDimNew15IdBlock = ^(id sender, NSInteger type){
//        [weakSelf dealwithMDimNew15IdSelected];
//    };
}

- (void)setupPatternItemView{
    DKYTongkuan5PatternItemView *view = [[DKYTongkuan5PatternItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.patternItemView = view;
    
    WeakSelf(weakSelf);
    [self.patternItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(230);
        make.top.mas_equalTo(weakSelf.varietyView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*式样:";
    self.patternItemView.itemModel = itemModel;
    self.patternItemView.userInteractionEnabled = NO;
//    self.patternItemView.mDimNew12IdBlock = ^(id sender,NSInteger type){
//        [weakSelf dealwithMDimNew12IdSelected];
//    };
}

- (void)setupSizeView{
    DKYTongkuan5SizeItemView *view = [[DKYTongkuan5SizeItemView alloc] initWithFrame:CGRectZero];
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
    
    self.sizeView.xwValueSelectedBlock = ^(id sender, NSString *value) {
        [weakSelf getSizeDataFromServer:value];
    };
    
    self.sizeView.itemModel = itemModel;
}

- (void)setupJingSizeItemView{
    DKYTongkuan5JingSizeItemView *view = [[DKYTongkuan5JingSizeItemView alloc] initWithFrame:CGRectZero];
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
    //DKYCustomOrderJianTypeItemView
    DKYTongkuan5JianTypeItemView *view = [[DKYTongkuan5JianTypeItemView alloc] initWithFrame:CGRectZero];
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
//    self.jianTypeView.mDimNew22IdBlock = ^(id sender,NSInteger type){
//        [weakSelf dealwithMDimNew22IdSelected];
//    };
}

- (void)setupXiuTypeView{
    //DKYCustomOrderXiuTypeItemView
    DKYTongkuan5XiuTypeItemView *view = [[DKYTongkuan5XiuTypeItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.xiuTypeView = view;
    
    WeakSelf(weakSelf);
    [self.xiuTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(80);
        make.top.mas_equalTo(weakSelf.jianTypeView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"袖型:";
    itemModel.textFieldLeftOffset = 16;
    self.xiuTypeView.itemModel = itemModel;
}

- (void)setupXiuBianView{
    //DKYCustomOrderXiuBianItemView
    DKYTongkuan5XiuBianItemView *view = [[DKYTongkuan5XiuBianItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.xiuBianView = view;
    
    WeakSelf(weakSelf);
    [self.xiuBianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.xiuTypeView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"袖边:";
    itemModel.textFieldLeftOffset = 16;
    self.xiuBianView.itemModel = itemModel;
}

- (void)setupLingView{
    DKYTongkuan5LingItemView *view = [[DKYTongkuan5LingItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.lingView = view;
    
    WeakSelf(weakSelf);
    [self.lingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(130);
        make.top.mas_equalTo(weakSelf.xiuBianView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"领:";
    itemModel.textFieldLeftOffset = 28;
    self.lingView.itemModel = itemModel;
}

- (void)setupFlowerTypeItemView{
    DKYCustomOrderFlowerTypeItemView *view = [[DKYCustomOrderFlowerTypeItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.flowerTypeItemView = view;
    
    WeakSelf(weakSelf);
    [self.flowerTypeItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(230);
        make.top.mas_equalTo(weakSelf.lingView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"花型:";
    itemModel.textFieldLeftOffset = 0;
    itemModel.textFieldLeftOffset = 16;
    self.flowerTypeItemView.itemModel = itemModel;
    
    self.flowerTypeItemView.userInteractionEnabled = NO;
}

- (void)setupTangzhuItemView{
    DKYCustomOrderTangzhuItemView *view = [[DKYCustomOrderTangzhuItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.tangzhuItemView = view;
    
    WeakSelf(weakSelf);
    [self.tangzhuItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(130);
        make.top.mas_equalTo(weakSelf.flowerTypeItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"烫珠:";
    itemModel.textFieldLeftOffset = 0;
    itemModel.textFieldLeftOffset = 16;
    self.tangzhuItemView.itemModel = itemModel;
    
    self.tangzhuItemView.userInteractionEnabled = NO;
}

- (void)setupKoudaiItemView{
    DKYCustomOrderKoudaiItemView *view = [[DKYCustomOrderKoudaiItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.koudaiItemView = view;
    
    WeakSelf(weakSelf);
    [self.koudaiItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(80);
        make.top.mas_equalTo(weakSelf.tangzhuItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"口袋:";
    itemModel.textFieldLeftOffset = 0;
    itemModel.textFieldLeftOffset = 16;
    self.koudaiItemView.itemModel = itemModel;
    
    self.koudaiItemView.userInteractionEnabled = NO;
}

- (void)setupAttachmentItemView{
    DKYCustomOrderAttachmentItemView *view = [[DKYCustomOrderAttachmentItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.attachmentItemView = view;
    
    WeakSelf(weakSelf);
    [self.attachmentItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(80);
        make.top.mas_equalTo(weakSelf.koudaiItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"附件:";
    itemModel.textFieldLeftOffset = 0;
    itemModel.textFieldLeftOffset = 16;
    self.attachmentItemView.itemModel = itemModel;
    
    self.attachmentItemView.userInteractionEnabled = NO;
}

- (void)setupSpecialCraftItemView{
    DKYCustomOrderSpecialCraftItemView *view = [[DKYCustomOrderSpecialCraftItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.specialCraftItemView = view;
    
    WeakSelf(weakSelf);
    [self.specialCraftItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(80);
        make.top.mas_equalTo(weakSelf.attachmentItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"特殊工艺:";
    itemModel.textFieldLeftOffset = 0;
    self.specialCraftItemView.itemModel = itemModel;
    
    self.specialCraftItemView.userInteractionEnabled = NO;
}

- (void)setupXiabianItemView{
    DKYCustomOrderXiabianItemView *view = [[DKYCustomOrderXiabianItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.xiabianItemView = view;
    
    WeakSelf(weakSelf);
    [self.xiabianItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.specialCraftItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"下边:";
    itemModel.textFieldLeftOffset = 16;
    self.xiabianItemView.itemModel = itemModel;
    
    self.xiabianItemView.userInteractionEnabled = NO;
}

- (void)setupXiukouItemView{
    DKYCustomOrderXiukouItemView *view = [[DKYCustomOrderXiukouItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.xiukouItemView = view;
    
    WeakSelf(weakSelf);
    [self.xiukouItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.xiabianItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"袖口:";
    itemModel.textFieldLeftOffset = 16;
    self.xiukouItemView.itemModel = itemModel;
    
    self.xiukouItemView.userInteractionEnabled = NO;
}

- (void)setupAddMarkView{
    DKYCustomOrderAddMarkItemView *view = [[DKYCustomOrderAddMarkItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.addMarkView = view;
    
    WeakSelf(weakSelf);
    [self.addMarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.xiukouItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"加注:";
    itemModel.textFieldLeftOffset = 16;
    self.addMarkView.itemModel = itemModel;
    
    self.addMarkView.userInteractionEnabled = NO;
}

- (void)setupMatchItemView{
    DKYCustomOrderMatchItemView *view = [[DKYCustomOrderMatchItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.matchItemView = view;
    
    WeakSelf(weakSelf);
    [self.matchItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.addMarkView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"配套:";
    itemModel.textFieldLeftOffset = 16;
    self.matchItemView.itemModel = itemModel;
    
    self.matchItemView.userInteractionEnabled = NO;
}

- (void)setupDisplayImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    //    imageView.image = [UIImage imageNamed:@"login_placeholder"];
    [self.contentView addSubview:imageView];
    self.displayImageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    WeakSelf(weakSelf);
    [self.displayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 380));
        make.top.mas_equalTo(weakSelf.matchItemView.mas_bottom).with.offset(vpadding);
        make.centerX.mas_equalTo(weakSelf.contentView);
    }];
}


#pragma mark - get & set method

- (DKYMptApproveSaveParameter*)mptApproveSaveParameter{
    if(_mptApproveSaveParameter == nil){
        _mptApproveSaveParameter = [[DKYMptApproveSaveParameter alloc] init];
    }
    return _mptApproveSaveParameter;
}

@end
