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

@interface DKYDisplayCategoryViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *pinzhongBtn;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *lengthBtn;
@property (weak, nonatomic) IBOutlet QMUITextField *lengthTextFied;
@property (weak, nonatomic) IBOutlet QMUITextField *xcTextField;
@property (weak, nonatomic) IBOutlet QMUITextField *amountTextField;
@property (weak, nonatomic) IBOutlet QMUITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet DKYDisplayCollectButton *collectBtn;


@property (nonatomic, strong) DKYGetSizeDataModel *getSizeDataModel;

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
    
    [self.sizeBtn setTitle:getProductListByGroupNoModel.xwValue forState:UIControlStateNormal];
    self.lengthTextFied.text = getProductListByGroupNoModel.ycValue;
    
    for (DKYDimlistItemModel *model in self.getProductListByGroupNoModel.pzJsonstr) {
        if([getProductListByGroupNoModel.mDimNew14Id isEqualToString:model.ID]){
            [self.pinzhongBtn setTitle:model.attribname forState:UIControlStateNormal];
        }
    }
    
    if([getProductListByGroupNoModel.isYcAffix caseInsensitiveCompare:@"Y"] == NSOrderedSame){
        self.lengthTextFied.enabled = NO;
    }else{
        self.lengthTextFied.enabled = YES;
    }
    
    self.collectBtn.selected = getProductListByGroupNoModel.isCollected;
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

- (void)getColorDimListFromServer:(NSString*)mDimNew14Id{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    DKYGetColorDimListParameter *p = [[DKYGetColorDimListParameter alloc] init];
    p.mProductId = weakSelf.getProductListByGroupNoModel.mProductId;
    p.mDimNew14Id = mDimNew14Id;
    
    [[DKYHttpRequestManager sharedInstance] getColorDimListWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            NSArray *array = [DKYDahuoOrderColorModel mj_objectArrayWithKeyValuesArray:result.data];
            weakSelf.getProductListByGroupNoModel.colorViewList = array;
            
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



#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    
}

#pragma mark - private method
- (void)showOptionsPicker:(UIButton *)sender{
    [self.superview endEditing:YES];
    
    NSMutableArray *item = @[].mutableCopy;

    switch (sender.tag) {
        case 0:{
            for (DKYDimlistItemModel *model in self.getProductListByGroupNoModel.pzJsonstr) {
                [item addObject:model.attribname];
            }
        }
            break;
        case 1:{
            for (DKYDahuoOrderColorModel *model in self.getProductListByGroupNoModel.colorViewList) {
                [item addObject:model.colorName];
            }
        }
            break;
        case 2:{
            for(NSDictionary *dic in self.getProductListByGroupNoModel.xwArrayJson){
                [item addObject:[dic objectForKey:@"value"]];
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
    actionSheet.destructiveButtonIndexSet = [NSSet setWithObjects:@0, nil];
    [actionSheet show];
}

- (void)actionSheetSelected:(NSInteger)tag index:(NSInteger)index{
    NSArray *models = nil;
    
    switch (tag) {
        case 0:{
            // 清除
            if(index == 0){
                return;
            }
            
            
            models = self.getProductListByGroupNoModel.pzJsonstr;
            DKYDimlistItemModel *model = [models objectOrNilAtIndex:index - 1];
            
            [self getColorDimListFromServer:model.ID];
        }
            break;
        case 1:{

        }
            break;
        case 2:{
            // 清除
            if(index == 0){
                return;
            }
            
            models = self.getProductListByGroupNoModel.xwArrayJson;
        
//            NSString *oldValue = self.addProductApproveParameter.xwValue;
        
//            self.addProductApproveParameter.xwValue = [models objectOrNilAtIndex:index - 1];
        
//            if(![self.addProductApproveParameter.xwValue isEqualToString:oldValue]){

//            }
            NSDictionary *dic = [self.getProductListByGroupNoModel.xwArrayJson objectOrNilAtIndex:index - 1];
            
            [self getSizeDataFromServer:[dic objectForKey:@"value"]];
        }
            break;
        default:
            break;
    }
}


#pragma mark - UI

- (void)commonInit{
    WeakSelf(weakSelf);
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self p_customSunview:self.titleLabel];
    
    // 品种
    [self p_customSunview:self.pinzhongBtn];
    self.pinzhongBtn.originalTitle = [self.pinzhongBtn currentTitle];
    self.pinzhongBtn.extraInfo = [self.pinzhongBtn currentTitle];
    self.pinzhongBtn.tag = 0;
    [self.pinzhongBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf showOptionsPicker:weakSelf.pinzhongBtn];
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
    
    [self p_customSunview:self.xcTextField];
    
    [self p_customSunview:self.amountTextField];
    
    [self p_customSunview:self.moneyTextField];
    
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
    }
}
@end
