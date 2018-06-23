//
//  DKYDisplayCategoryDahuoViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayCategoryDahuoViewCell.h"
#import "DKYGetProductListByGroupNoModel.h"
#import "DKYDahuoOrderColorModel.h"
#import "DKYSizeViewListItemModel.h"
#import "DKYDisplayCollectButton.h"
#import "DKYProductCollectParameter.h"
#import "DKYDimlistItemModel.h"

@interface DKYDisplayCategoryDahuoViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *lengthBtn;
@property (weak, nonatomic) IBOutlet QMUITextField *xcTextField;
@property (weak, nonatomic) IBOutlet QMUITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet QMUITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet DKYDisplayCollectButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *rectImageView;
@property (weak, nonatomic) IBOutlet UIButton *pinleiBtn;

// image
@property (nonatomic, strong) UIImage *normalImage;

@property (nonatomic, copy) UIImage *selectedImage;

@end

@implementation DKYDisplayCategoryDahuoViewCell

+ (instancetype)displayCategoryDahuoViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYDisplayCategoryDahuoViewCell";
    DKYDisplayCategoryDahuoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DKYDisplayCategoryDahuoViewCell class]) owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)selectStatusChanged{
    self.getProductListByGroupNoModel.choosed = !self.getProductListByGroupNoModel.isChoosed;
    
    self.rectImageView.image = self.getProductListByGroupNoModel.isChoosed ? self.selectedImage : self.normalImage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self commonInit];
}

- (void)setGetProductListByGroupNoModel:(DKYGetProductListByGroupNoModel *)getProductListByGroupNoModel{
    _getProductListByGroupNoModel = getProductListByGroupNoModel;
    
    self.titleLabel.text = getProductListByGroupNoModel.productName;
    
    // 颜色
    if(self.getProductListByGroupNoModel.addDpGroupBmptParam.colorId){
        for (DKYDahuoOrderColorModel *model in self.getProductListByGroupNoModel.colorViewList) {
            if([self.getProductListByGroupNoModel.addDpGroupBmptParam.colorId isEqualToNumber:@(model.colorId)]){
                [self.colorBtn setTitle:model.colorName forState:UIControlStateNormal];
            }
        }
    }
    
    // 尺寸
    if(self.getProductListByGroupNoModel.addDpGroupBmptParam.sizeId){
        for (DKYSizeViewListItemModel *model in self.getProductListByGroupNoModel.sizeViewList) {
            if([model.sizeId isEqualToNumber:self.getProductListByGroupNoModel.addDpGroupBmptParam.sizeId]){
                [self.sizeBtn setTitle:model.sizeName forState:UIControlStateNormal];
            }
        }
    }
    
    self.amountTextField.text = getProductListByGroupNoModel.sumText;
    
    DKYDahuoOrderColorModel *defaultColor;
    for(DKYDahuoOrderColorModel *color in getProductListByGroupNoModel.colorViewList){
        if(color.isDefault != nil && [color.isDefault caseInsensitiveCompare:@"Y"] == NSOrderedSame){
            defaultColor = color;
            break;
        }
    }
    
    [self.colorBtn setTitle:defaultColor.colorName forState:UIControlStateNormal];
    self.getProductListByGroupNoModel.addDpGroupBmptParam.colorId = @(defaultColor.colorId);

    self.rectImageView.image = self.getProductListByGroupNoModel.isChoosed ? self.selectedImage : self.normalImage;
    
    // 品类
    NSInteger mDim16Id = [self.getProductListByGroupNoModel.mDim16Id integerValue];
    
    for(DKYDimlistItemModel *item in self.getProductListByGroupNoModel.pinList){
        if(mDim16Id == [item.ID integerValue]){
            [self.pinleiBtn setTitle:item.attribname forState:UIControlStateNormal];
            self.getProductListByGroupNoModel.addDpGroupBmptParam.mDim16Id = @(mDim16Id);
            break;
        }
    }
    
    [self updateWhenSumChanged];
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
            // 尺寸
            for (DKYSizeViewListItemModel *model in self.getProductListByGroupNoModel.sizeViewList) {
                [item addObject:model.sizeName];
            }
        }
            break;
        case 3:{
            
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
    switch (tag) {
        case 0:{

        }
            break;
        case 1:{
            // 颜色
            if(index == 0){
                self.getProductListByGroupNoModel.addDpGroupBmptParam.colorId = nil;
                return;
            }
            
            DKYDahuoOrderColorModel *model =  [self.getProductListByGroupNoModel.colorViewList objectOrNilAtIndex:index - 1];
            self.getProductListByGroupNoModel.addDpGroupBmptParam.colorId = @(model.colorId);
        }
            break;
        case 2:{
            // 尺寸
            if(index == 0){
                self.getProductListByGroupNoModel.addDpGroupBmptParam.sizeId = nil;
                return;
            }

            DKYSizeViewListItemModel *model = [self.getProductListByGroupNoModel.sizeViewList objectOrNilAtIndex:index - 1];
            self.getProductListByGroupNoModel.addDpGroupBmptParam.sizeId = model.sizeId;
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
    
    // 品类
    [self p_customSunview:self.pinleiBtn];
    self.pinleiBtn.originalTitle = [self.pinleiBtn currentTitle];
    self.pinleiBtn.extraInfo = [self.pinleiBtn currentTitle];
    self.pinleiBtn.tag = 4;
    self.pinleiBtn.enabled = NO;
    
    // 颜色
    [self p_customSunview:self.colorBtn];
    self.colorBtn.originalTitle = [self.colorBtn currentTitle];
    self.colorBtn.extraInfo = [self.colorBtn currentTitle];
    self.colorBtn.tag = 1;
    [self.colorBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf showOptionsPicker:weakSelf.colorBtn];
    }];
    
    // 尺寸
    [self p_customSunview:self.sizeBtn];
    self.sizeBtn.originalTitle = [self.sizeBtn currentTitle];
    self.sizeBtn.extraInfo = [self.sizeBtn currentTitle];
    self.sizeBtn.tag = 2;
    [self.sizeBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf showOptionsPicker:weakSelf.sizeBtn];
    }];

    // 数量
    [self p_customSunview:self.amountTextField];
    [self.amountTextField addBlockForControlEvents:UIControlEventEditingChanged block:^(UITextField*  _Nonnull sender) {
        weakSelf.getProductListByGroupNoModel.sum = [sender.text integerValue];
        
        [weakSelf updateWhenSumChanged];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kDisplayAmountChangedNotification object:nil userInfo:@{@"amount":sender.text}];
    }];
    
    [self p_customSunview:self.moneyLabel];
    
    // 收藏
    [self p_customSunview:self.collectBtn];
    [self.collectBtn customButtonWithTypeEx:UIButtonCustomType_Thirteen];
    self.collectBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
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
    
    UIImage *image = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(11, 11)];
    self.normalImage = [image imageByRoundCornerRadius:0 borderWidth:0.5 borderColor:[UIColor blackColor]];
//    self.selectedImage = [UIImage imageWithColor:[UIColor colorWithHex:0x3c3562] size:CGSizeMake(11, 11)];
    self.selectedImage = [UIImage imageNamed:@"select_icon"];
    self.rectImageView.image = self.selectedImage;
    self.rectImageView.contentMode = UIViewContentModeCenter;
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
