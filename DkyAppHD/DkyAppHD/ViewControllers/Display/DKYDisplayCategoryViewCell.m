//
//  DKYDisplayCategoryViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayCategoryViewCell.h"
#import "DKYGetProductListByGroupNoModel.h"
#import "DKYDahuoOrderColorModel.h"
#import "DKYGetSizeDataParameter.h"
#import "DKYGetSizeDataModel.h"
#import "DKYDimlistItemModel.h"
#import "DKYGetColorDimListParameter.h"
#import "DKYColorDimListModel.h"
#import "DKYProductCollectParameter.h"
#import "DKYDisplayCollectButton.h"
#import "NSString+Utility.h"
#import "DKYGetProductPriceParameter.h"
#import "DKYGetPzsJsonParameter.h"

@interface DKYDisplayCategoryViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *pinzhongBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhenxingBtn;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *lengthBtn;
@property (weak, nonatomic) IBOutlet QMUITextField *lengthTextFied;
@property (weak, nonatomic) IBOutlet QMUITextField *xcTextField;
@property (weak, nonatomic) IBOutlet QMUITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet QMUITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet DKYDisplayCollectButton *collectBtn;

@property (weak, nonatomic) IBOutlet UIButton *pinleiBtn;

@property (nonatomic, strong) DKYGetSizeDataModel *getSizeDataModel;

@property (nonatomic, strong) dispatch_group_t group;

@end

@implementation DKYDisplayCategoryViewCell

+ (instancetype)displayCategoryViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYDisplayCategoryViewCell";
    DKYDisplayCategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DKYDisplayCategoryViewCell class]) owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self commonInit];
}

- (void)setGetProductListByGroupNoModel:(DKYGetProductListByGroupNoModel *)getProductListByGroupNoModel{
    _getProductListByGroupNoModel = getProductListByGroupNoModel;
    
    self.titleLabel.text = getProductListByGroupNoModel.productName;
    // 大，长
    [self.sizeBtn setTitle:getProductListByGroupNoModel.addDpGroupApproveParam.xwValue forState:UIControlStateNormal];
    self.lengthTextFied.text = getProductListByGroupNoModel.addDpGroupApproveParam.ycValue;
    
    self.xcTextField.text = getProductListByGroupNoModel.addDpGroupApproveParam.xcValue;
    
    // 数量
    self.amountTextField.text = getProductListByGroupNoModel.sumText;
    
    if(getProductListByGroupNoModel.sum > 0){
        double sum = getProductListByGroupNoModel.sum * [getProductListByGroupNoModel.price doubleValue];
        NSString *sumMoney = [NSString formatRateStringWithRate:sum];
        
        self.moneyLabel.text = sumMoney;
    }else{
        self.moneyLabel.text = @"金额";
    }
    
    // 品种
    for (DKYDimlistItemModel *model in self.getProductListByGroupNoModel.pzJsonstr) {
        if([getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew14Id isEqualToString:model.ID]){
            [self.pinzhongBtn setTitle:model.attribname forState:UIControlStateNormal];
        }
    }
    
    // 针型
    for (DKYDimlistItemModel *model in self.getProductListByGroupNoModel.zxJsonstr) {
        if([getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew16Id isEqualToNumber:@([model.ID integerValue])]){
            [self.zhenxingBtn setTitle:model.attribname forState:UIControlStateNormal];
        }
    }
    
    if([getProductListByGroupNoModel.isYcAffix caseInsensitiveCompare:@"Y"] == NSOrderedSame){
        self.lengthTextFied.enabled = NO;
    }else{
        self.lengthTextFied.enabled = YES;
    }
    
    self.collectBtn.selected = getProductListByGroupNoModel.isCollected;
    
    // 袖长
    self.xcTextField.text = getProductListByGroupNoModel.xcValue;
    
    [self updateWhenSumChanged];
}

#pragma mark - 网络请求
- (void)getSizeDataFromServer:(NSString*)xwValue{
    [DKYHUDTool show];
    
    WeakSelf(weakSelf);
    DKYGetSizeDataParameter *p = [[DKYGetSizeDataParameter alloc] init];
    p.xwValue = xwValue;
    p.pdt = self.getProductListByGroupNoModel.productName;
    
    [[DKYHttpRequestManager sharedInstance] getSizeDataWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.getSizeDataModel = [DKYGetSizeDataModel mj_objectWithKeyValues:result.data];
            
            weakSelf.lengthTextFied.text = weakSelf.getSizeDataModel.yc;
            weakSelf.xcTextField.text = weakSelf.getSizeDataModel.xc;
            
            weakSelf.getProductListByGroupNoModel.addDpGroupApproveParam.ycValue = weakSelf.getSizeDataModel.yc;
            weakSelf.getProductListByGroupNoModel.addDpGroupApproveParam.xcValue = weakSelf.getSizeDataModel.xc;
            
            weakSelf.getProductListByGroupNoModel.defaultXcValue = weakSelf.getSizeDataModel.xc;
            
            [weakSelf getProductPriceFromServer];
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

- (void)getColorDimListFromServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    DKYGetColorDimListParameter *p = [[DKYGetColorDimListParameter alloc] init];
    p.mProductId = weakSelf.getProductListByGroupNoModel.mProductId;
    p.mDimNew14Id = self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew14Id;
    
    [[DKYHttpRequestManager sharedInstance] getColorDimListWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            NSArray *array = [DKYDahuoOrderColorModel mj_objectArrayWithKeyValuesArray:result.data];
            weakSelf.getProductListByGroupNoModel.colorViewList = array;
            
            if([weakSelf.getProductListByGroupNoModel.addDpGroupApproveParam.colorArr isNotBlank]){
                bool mached = NO;
                for(DKYDahuoOrderColorModel *color in array){
                    if([color.colorName isEqualToString:weakSelf.getProductListByGroupNoModel.addDpGroupApproveParam.colorArr]){
                        mached = YES;
                        break;
                    }
                }
                if(!mached){
                    weakSelf.getProductListByGroupNoModel.addDpGroupApproveParam.colorArr = nil;
                    [weakSelf.colorBtn setTitle:weakSelf.colorBtn.originalTitle forState:UIControlStateNormal];
                }
            }
            
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [DKYHUDTool dismiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            [DKYHUDTool dismiss];
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
    } failure:^(NSError *error) {
        [DKYHUDTool dismiss];
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

- (void)delProductCollectToServer{
    [DKYHUDTool show];
    
    DKYProductCollectParameter *p = [[DKYProductCollectParameter alloc] init];
    p.productId = self.getProductListByGroupNoModel.mProductId;
    
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] delProductCollectWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            // 生成订单成功
            [DKYHUDTool showSuccessWithStatus:@"取消收藏成功!"];
            
            weakSelf.getProductListByGroupNoModel.isCollected = !weakSelf.getProductListByGroupNoModel.isCollected;
            weakSelf.collectBtn.selected = NO;
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

- (void)addProductCollectToServer{
    [DKYHUDTool show];
    
    DKYProductCollectParameter *p = [[DKYProductCollectParameter alloc] init];
    p.productId = self.getProductListByGroupNoModel.mProductId;
    
    WeakSelf(weakSelf);
    [[DKYHttpRequestManager sharedInstance] addProductCollectWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            // 生成订单成功
            [DKYHUDTool showSuccessWithStatus:@"收藏成功!"];
            
            weakSelf.getProductListByGroupNoModel.isCollected = !weakSelf.getProductListByGroupNoModel.isCollected;
            weakSelf.collectBtn.selected = YES;
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

- (void)getProductPriceFromServer{
    [DKYHUDTool show];
    
    WeakSelf(weakSelf);
    
    DKYGetProductPriceParameter *p = [[DKYGetProductPriceParameter alloc] init];
    
    p.pdt = self.getProductListByGroupNoModel.productName;
    p.pdtId = self.getProductListByGroupNoModel.mProductId;
    p.mptbelongtype = self.getProductListByGroupNoModel.mptbelongtype;
    p.mDimNew14Id = @([self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew14Id integerValue]);
    p.mDimNew16Id = self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew16Id;
    p.xwValue = self.getProductListByGroupNoModel.addDpGroupApproveParam.xwValue;
    p.xcValue = self.getProductListByGroupNoModel.addDpGroupApproveParam.xcValue;
    p.ycValue = self.getProductListByGroupNoModel.addDpGroupApproveParam.ycValue;
    
    [[DKYHttpRequestManager sharedInstance] getProductPriceWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.getProductListByGroupNoModel.price = result.data;
            [weakSelf updateWhenSumChanged];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kDisplayAmountChangedNotification object:nil userInfo:nil];
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

- (void)getPzsJsonFromServer{
    WeakSelf(weakSelf);
    
    DKYGetPzsJsonParameter *p = [[DKYGetPzsJsonParameter alloc] init];
    p.flag = [NSString stringWithFormat:@"%@",@(2)];
    p.productId = self.getProductListByGroupNoModel.mProductId;
    
    
    p.mDimNew14Id = @([self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew14Id integerValue]);
    
//    p.mDimNew16Id = @([self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew16Id integerValue]);
    
    [[DKYHttpRequestManager sharedInstance] getPzsJsonWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            NSDictionary *dict = (NSDictionary*)result.data;
            
            NSArray *value = [dict objectForKey:@"zxJson"];
            weakSelf.getProductListByGroupNoModel.zxJsonstr = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:value];
            
            [weakSelf dealWithgetPzsJsonFromServer:2 value:nil];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

- (void)pinzhongChanged{
    [DKYHUDTool show];
    
    [self getColorDimListFromServer];
    [self getProductPriceFromServer];
    [self getPzsJsonFromServer];
    
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        [DKYHUDTool dismiss];
        
    });
}

#pragma mark - action method
- (void)dealWithgetPzsJsonFromServer:(NSInteger)flag value:(NSArray*)value{
    [self updateActionSheetAfterGetPzsJsonFromServer:flag];
}

- (void)updateActionSheetAfterGetPzsJsonFromServer:(NSInteger)flag{
    BOOL exist = NO;
    
    for (DKYDimlistItemModel *model in self.getProductListByGroupNoModel.zxJsonstr) {
        if([model.ID integerValue] == [self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew16Id integerValue]){
            exist = YES;
            break;
        }
    }
    
    if(!exist){
        // 不存在，则刷新
        [self.zhenxingBtn setTitle:self.zhenxingBtn.originalTitle forState:UIControlStateNormal];
        self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew16Id = nil;
        
    }
}

- (void)optionsBtnClicked:(UIButton*)sender{
    
}

#pragma mark - private method
- (void)showOptionsPicker:(UIButton *)sender{
    [self.superview endEditing:YES];
    
    NSMutableArray *item = @[].mutableCopy;

    switch (sender.tag) {
        case 0:{
            // 品种
            for (DKYDimlistItemModel *model in self.getProductListByGroupNoModel.pzJsonstr) {
                [item addObject:model.attribname];
            }
        }
            break;
        case 1:{
            // 颜色
            for (DKYDahuoOrderColorModel *model in self.getProductListByGroupNoModel.colorViewList) {
                [item addObject:model.colorName];
            }
        }
            break;
        case 2:{
            // 大
            for(NSDictionary *dic in self.getProductListByGroupNoModel.xwArrayJson){
                [item addObject:[dic objectForKey:@"value"]];
            }
        }
            break;
        case 3:{
            // 针型
            for (DKYDimlistItemModel *model in self.getProductListByGroupNoModel.zxJsonstr) {
                [item addObject:model.attribname];
            }
        }
            break;
        case 4:{
            // 品类
            for (DKYDimlistItemModel *model in self.getProductListByGroupNoModel.pinList) {
                [item addObject:model.attribname];
            }
        }
            break;
          default:
            break;
    }

    WeakSelf(weakSelf);
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:sender.extraInfo
                                             cancelButtonTitle:kDeleteTitle
                                                       clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
                                                           DLog(@"buttonIndex = %@ clicked",@(buttonIndex));
                                                           if(buttonIndex != 0){
                                                               [sender setTitle:[item objectOrNilAtIndex:buttonIndex - 1] forState:UIControlStateNormal];
                                                           }else{
                                                               [sender setTitle:sender.originalTitle forState:UIControlStateNormal];
                                                           }
                                                           [weakSelf actionSheetSelected:sender.tag index:buttonIndex];
                                                       }
                                         otherButtonTitleArray:item];
    actionSheet.scrolling = item.count > 10;
    actionSheet.visibleButtonCount = 10;
    actionSheet.destructiveButtonIndexSet = [NSIndexSet indexSetWithIndex:0];
    [actionSheet show];
}

- (void)actionSheetSelected:(NSInteger)tag index:(NSInteger)index{
    NSArray *models = nil;
    
    switch (tag) {
        case 0:{
            // 品种
            if(index == 0){
                self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew14Id = nil;
                return;
            }
            
            
            models = self.getProductListByGroupNoModel.pzJsonstr;
            DKYDimlistItemModel *model = [models objectOrNilAtIndex:index - 1];
            
            self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew14Id = model.ID;
            
            [self pinzhongChanged];
        }
            break;
        case 1:{
            // 颜色
            if(index == 0){
                self.getProductListByGroupNoModel.addDpGroupApproveParam.colorArr = nil;
                return;
            }
            
            DKYDahuoOrderColorModel *model =  [self.getProductListByGroupNoModel.colorViewList objectOrNilAtIndex:index - 1];
            self.getProductListByGroupNoModel.addDpGroupApproveParam.colorArr = model.colorName;
        }
            break;
        case 2:{
            // 大
            if(index == 0){
                self.getProductListByGroupNoModel.addDpGroupApproveParam.xwValue = nil;
                return;
            }
            
            models = self.getProductListByGroupNoModel.xwArrayJson;
            NSDictionary *dic = [self.getProductListByGroupNoModel.xwArrayJson objectOrNilAtIndex:index - 1];
            self.getProductListByGroupNoModel.addDpGroupApproveParam.xwValue = [dic objectForKey:@"value"];
            
            [self getSizeDataFromServer:[dic objectForKey:@"value"]];
        }
            break;
        case 3:{
            // 针型
            if(index == 0){
                self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew16Id = nil;
                return;
            }
            
            
            models = self.getProductListByGroupNoModel.zxJsonstr;
            DKYDimlistItemModel *model = [models objectOrNilAtIndex:index - 1];
            
            self.getProductListByGroupNoModel.addDpGroupApproveParam.mDimNew16Id = @([model.ID integerValue]);
            
            [self getProductPriceFromServer];
        }
            break;
        case 4:{
            // 品类
            if(index == 0){
                self.getProductListByGroupNoModel.addDpGroupApproveParam.mDim16Id = nil;
                return;
            }
            
            models = self.getProductListByGroupNoModel.pinList;
            DKYDimlistItemModel *model = [models objectOrNilAtIndex:index - 1];
            
            self.getProductListByGroupNoModel.addDpGroupApproveParam.mDim16Id = @([model.ID integerValue]);
        }
            break;
        default:
            break;
    }
}

- (void)updateWhenSumChanged{
    if(self.getProductListByGroupNoModel.sum > 0){
        double sum = self.getProductListByGroupNoModel.sum * [self.getProductListByGroupNoModel.price doubleValue];
        NSString *sumMoney = [NSString formatRateStringWithRate:sum];
        sumMoney = [NSString stringWithFormat:@"%@元",sumMoney];
        
        self.moneyLabel.text = sumMoney;
    }else{
        self.moneyLabel.text = @"金额";
    }
}

#pragma mark - UI

- (void)commonInit{
    WeakSelf(weakSelf);
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self p_customSunview:self.titleLabel];
    
    self.group = dispatch_group_create();
    
    // 品类
    [self p_customSunview:self.pinleiBtn];
    self.pinleiBtn.originalTitle = [self.pinleiBtn currentTitle];
    self.pinleiBtn.extraInfo = [self.pinleiBtn currentTitle];
    self.pinleiBtn.tag = 4;
    [self.pinleiBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf showOptionsPicker:weakSelf.pinleiBtn];
    }];
    
    // 品种
    [self p_customSunview:self.pinzhongBtn];
    self.pinzhongBtn.originalTitle = [self.pinzhongBtn currentTitle];
    self.pinzhongBtn.extraInfo = [self.pinzhongBtn currentTitle];
    self.pinzhongBtn.tag = 0;
    [self.pinzhongBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf showOptionsPicker:weakSelf.pinzhongBtn];
    }];
    
    // 针型
    [self p_customSunview:self.zhenxingBtn];
    self.zhenxingBtn.originalTitle = [self.zhenxingBtn currentTitle];
    self.zhenxingBtn.extraInfo = [self.zhenxingBtn currentTitle];
    self.zhenxingBtn.tag = 3;
    [self.zhenxingBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf showOptionsPicker:weakSelf.zhenxingBtn];
    }];
    
    // 颜色
    [self p_customSunview:self.colorBtn];
    self.colorBtn.originalTitle = [self.colorBtn currentTitle];
    self.colorBtn.extraInfo = [self.colorBtn currentTitle];
    self.colorBtn.tag = 1;
    [self.colorBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf showOptionsPicker:weakSelf.colorBtn];
    }];
    
    // 大
    [self p_customSunview:self.sizeBtn];
    self.sizeBtn.originalTitle = [self.sizeBtn currentTitle];
    self.sizeBtn.extraInfo = [self.sizeBtn currentTitle];
    self.sizeBtn.tag = 2;
    [self.sizeBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf showOptionsPicker:weakSelf.sizeBtn];
    }];
    
    // 长
    [self p_customSunview:self.lengthTextFied];
    [self.lengthTextFied addBlockForControlEvents:UIControlEventEditingChanged block:^(UITextField*  _Nonnull sender) {
        weakSelf.getProductListByGroupNoModel.addDpGroupApproveParam.ycValue = sender.text;
        [weakSelf getProductPriceFromServer];
    }];
    
    // 袖长
    [self p_customSunview:self.xcTextField];
    [self.xcTextField addBlockForControlEvents:UIControlEventEditingChanged block:^(UITextField*  _Nonnull sender) {
        weakSelf.getProductListByGroupNoModel.addDpGroupApproveParam.xcValue = sender.text;
        [weakSelf getProductPriceFromServer];
    }];
    
    // 数量
    [self p_customSunview:self.amountTextField];
    [self.amountTextField addBlockForControlEvents:UIControlEventEditingChanged block:^(UITextField*  _Nonnull sender) {
        weakSelf.getProductListByGroupNoModel.sum = [sender.text integerValue];
        
        [weakSelf updateWhenSumChanged];
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:kDisplayAmountChangedNotification object:nil userInfo:@{@"amount" : sender.text}];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDisplayAmountChangedNotification object:nil userInfo:nil];
    }];
    
    [self p_customSunview:self.moneyLabel];
    
    // 收藏
    [self p_customSunview:self.collectBtn];
    [self.collectBtn customButtonWithTypeEx:UIButtonCustomType_Thirteen];
    [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.collectBtn setTitle:@"取消收藏" forState:UIControlStateSelected];
    [self.collectBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.getProductListByGroupNoModel.isCollected){
            // 已经是收藏状态
            [weakSelf delProductCollectToServer];
        }else{
            [weakSelf addProductCollectToServer];
        }
    }];
}

- (void)p_customSunview:(UIView*)view{
    view.qmui_borderPosition = QMUIBorderViewPositionTop | QMUIBorderViewPositionLeft | QMUIBorderViewPositionBottom | QMUIBorderViewPositionRight;
    view.qmui_borderWidth = 1;
    view.qmui_borderColor = [UIColor colorWithHex:0x686868];
    
    if([view isMemberOfClass:[UILabel class]]){
        UILabel *label = (UILabel*)view;
        label.adjustsFontSizeToFitWidth = YES;
    }
    
    if([view isMemberOfClass:[UIButton class]]){
        UIButton *btn = (UIButton*)view;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    if([view isMemberOfClass:[QMUITextField class]]){
        QMUITextField *textField = (QMUITextField*)view;
        textField.textInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        textField.disabledBackground = [UIImage imageWithColor:[UIColor colorWithHex:0xF0F0F0]];
        textField.shouldResponseToProgrammaticallyTextChanges = NO;
    }
}
@end
