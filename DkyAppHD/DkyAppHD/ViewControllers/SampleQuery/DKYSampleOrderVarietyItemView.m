//
//  DKYSampleOrderVarietyItemView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleOrderVarietyItemView.h"
#import "DKYMultipleSelectPopupView.h"
#import "DKYGetPzsJsonParameter.h"
#import "DKYDahuoOrderColorModel.h"
#import "DKYGetColorListRequestParameter.h"
#import <YYText/YYText.h>
#import "UIColor+RandomColor.h"

@interface DKYSampleOrderVarietyItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *optionsBtn;

@property (nonatomic, weak) UIButton *secondBtn;

@property (nonatomic, weak) UIButton *thirdBtn;

@property (nonatomic, weak) UIButton *fourthBtn;

@property (nonatomic, strong) DKYGetPzsJsonParameter *getPzsJsonParameter;
@property (nonatomic, strong) DKYGetColorListRequestParameter *getColorListRequestParameter;

@property (nonatomic, weak) UIButton *colorBtn;
@property (nonatomic, weak) YYTextView *selectedColorView;

@property (nonatomic, weak) UIButton *colorGroupBtn;

// 调用另外的接口返回的选项数组
@property (nonatomic, copy) NSArray *zbJsonArray;
@property (nonatomic, copy) NSArray *zxJsonArray;
@property (nonatomic, copy) NSArray *zzJsonArray;

@end

@implementation DKYSampleOrderVarietyItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setItemModel:(DKYCustomOrderItemModel *)itemModel{
    [super setItemModel:itemModel];
    
    if(itemModel.title.length > 0){
        self.titleLabel.text = itemModel.title;
    }
    
    if(itemModel.content.length > 0){
        [self.optionsBtn setTitle:itemModel.content forState:UIControlStateNormal];
    }
    
    if(itemModel.title.length >0 && [itemModel.title hasPrefix:@"*"]){
        NSDictionary *dict = @{NSForegroundColorAttributeName : self.titleLabel.textColor,
                               NSFontAttributeName : self.titleLabel.font};
        NSMutableAttributedString *atitle = [[NSMutableAttributedString alloc] initWithString:itemModel.title attributes:dict];
        
        [atitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        self.titleLabel.attributedText = atitle;
    }
    
    
    UIFont *font = self.titleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    UIColor *foregroundColor = self.titleLabel.textColor;
    
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSForegroundColorAttributeName: foregroundColor};
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect textFrame = [itemModel.title boundingRectWithSize:size
                                                     options:options
                                                  attributes:attributes
                                                     context:nil];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textFrame.size.width + 10);
    }];
    
    if(itemModel.zoomed){
        self.titleLabel.font = [UIFont systemFontOfSize:24];

        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
        }];
    }
}

- (void)setMadeInfoByProductName:(DKYMadeInfoByProductNameModel *)madeInfoByProductName{
    [super setMadeInfoByProductName:madeInfoByProductName];
    
    [self clear];
    
    if(!madeInfoByProductName) return;
    
    if(self.madeInfoByProductName){
        for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.pzJsonArray) {
            if([model.ID integerValue] == self.madeInfoByProductName.productMadeInfoView.mDimNew14Id){
                [self.optionsBtn setTitle:model.attribname forState:UIControlStateNormal];
                break;
            }
        }
        
        for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.zzJsonArray) {
            if([model.ID integerValue] == self.madeInfoByProductName.productMadeInfoView.mDimNew15Id){
                [self.secondBtn setTitle:model.attribname forState:UIControlStateNormal];
                break;
            }
        }
        
        for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.zxJsonArray) {
            if([model.ID integerValue] == self.madeInfoByProductName.productMadeInfoView.mDimNew16Id){
                [self.thirdBtn setTitle:model.attribname forState:UIControlStateNormal];
                break;
            }
        }
        
        for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.zbJsonArray) {
            if([model.ID integerValue] == self.madeInfoByProductName.productMadeInfoView.mDimNew17Id){
                [self.fourthBtn setTitle:model.attribname forState:UIControlStateNormal];
                break;
            }
        }
    }
    
    if(self.madeInfoByProductName.colorRangeViewList.count > 0){
        NSDictionary *model =[self.madeInfoByProductName.colorRangeViewList firstObject];
        NSString *color = [model objectForKey:@"colorName"];
        
        // 解析选中颜色，取出()前面
        NSArray *temp = [color componentsSeparatedByString:@","];
        
        NSMutableArray *colors = [NSMutableArray arrayWithCapacity:temp.count];
        
        for (NSString *item in temp) {
            NSRange range = [item rangeOfString:@"("];
            NSString *colorName = nil;
            if(range.location != NSNotFound){
                colorName = [item substringToIndex:range.location];
            }else{
                colorName = item;
            }
            
            [colors addObject:colorName];
        }
        
        [self colorGroupSelected:colors.copy];
        
        DLog(@"colors = %@",colors);
        
    }else{
        for (DKYDahuoOrderColorModel *model in self.madeInfoByProductName.colorViewList) {
            for (NSString *selectColor in self.madeInfoByProductName.productMadeInfoView.clrRangeArray) {
                if([model.colorName isEqualToString:selectColor]){
                    model.selected = YES;
                    break;
                }
            }
        }
        
        NSMutableArray *selectedModel = [NSMutableArray array];
        
        for (NSString *selectColor in self.madeInfoByProductName.productMadeInfoView.clrRangeArray) {
            for (DKYDahuoOrderColorModel *model in self.madeInfoByProductName.colorViewList) {
                if([model.colorName isEqualToString:selectColor]){
                    model.selected = YES;
                    [selectedModel addObject:model];
                    break;
                }
            }
        }
        
        NSMutableString *selectedColor = [NSMutableString string];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@""];
        for (DKYDahuoOrderColorModel *color in selectedModel) {
            NSString *oneColor = [NSString stringWithFormat:@"%@(%@); ",color.colorName,color.colorDesc];
            [selectedColor appendString:oneColor];
            
            NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] initWithString:oneColor];
            tagText.yy_color = [UIColor colorWithHex:0x333333];
            tagText.yy_font = [UIFont systemFontOfSize:18];
            
            //        YYTextBorder *border = [[YYTextBorder alloc] init];
            //        border.fillColor = [UIColor randomColor];
            //        border.lineStyle = YYTextLineStyleSingle;
            //        [tagText setYy_textBackgroundBorder:border];
            
            [text appendAttributedString:tagText];
            
            NSMutableAttributedString *blank = [[NSMutableAttributedString alloc] initWithString:@"   "];
            blank.yy_font = [UIFont systemFontOfSize:12];
            YYTextBorder *blank_border = [[YYTextBorder alloc] init];
            blank_border.fillColor = [UIColor clearColor];
            blank_border.lineStyle = YYTextLineStyleSingle;
            [blank setYy_textBackgroundBorder:blank_border];
            [text appendAttributedString:blank];
        }
        
        if([selectedColor isNotBlank]){
            self.selectedColorView.attributedText = text;
        }
        
        if(selectedModel.count > 0){
            self.addProductApproveParameter.colorSource = DKYDetailOrderSelectedColorType_MulSelected;
            self.colorGroupBtn.enabled = NO;
        }else{
            self.addProductApproveParameter.colorSource = DKYDetailOrderSelectedColorType_Unset;
            self.colorGroupBtn.enabled = YES;
        }
    }
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    [self.secondBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    [self.thirdBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    [self.fourthBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    self.selectedColorView.text = nil;
}

#pragma mark - 网络请求
- (void)getPzsJsonFromServer{
    [DKYHUDTool show];
    
    WeakSelf(weakSelf);
    //    self.getPzsJsonParameter = nil;
    NSInteger flag = [self.getPzsJsonParameter.flag integerValue];
    [[DKYHttpRequestManager sharedInstance] getPzsJsonWithParameter:self.getPzsJsonParameter Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            NSDictionary *dict = (NSDictionary*)result.data;
            NSArray *value = [dict objectForKey:@"zbJson"];
            weakSelf.zbJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:value];
            
            value = [dict objectForKey:@"zxJson"];
            weakSelf.zxJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:value];
            
            value = [dict objectForKey:@"zzJson"];
            weakSelf.zzJsonArray = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:value];
            
            [weakSelf dealWithgetPzsJsonFromServer:flag value:nil];
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

- (void)getColorListFromServer{
    [DKYHUDTool show];
    
    WeakSelf(weakSelf);
    
    [[DKYHttpRequestManager sharedInstance] getColorListWithParameter:self.getColorListRequestParameter Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            NSArray *colorArray = [DKYDahuoOrderColorModel mj_objectArrayWithKeyValuesArray:result.data];
            weakSelf.madeInfoByProductName.displayColorViewList = colorArray;
            
            // 刷新UI
            for (DKYDahuoOrderColorModel *model in colorArray) {
                for (NSString *selectColor in self.madeInfoByProductName.productMadeInfoView.clrRangeArray) {
                    if([model.colorName isEqualToString:selectColor]){
                        ++model.selectedCount;
                    }
                }
            }
            
            NSMutableString *selectedColor = [NSMutableString string];
            for (DKYDahuoOrderColorModel *color in colorArray) {
                if(color.selected){
                    NSString *oneColor = [NSString stringWithFormat:@"%@(%@); ",color.colorName,color.colorDesc];
                    [selectedColor appendString:oneColor];
                }
            }
            
            self.selectedColorView.text = selectedColor;
            
            // 刷新参数
            self.addProductApproveParameter.colorValue = nil;
            self.addProductApproveParameter.colorArr = nil;
            
            NSMutableArray *selectedColorId = [NSMutableArray array];
            for (DKYDahuoOrderColorModel *model in colorArray) {
                if(model.selected){
                    self.addProductApproveParameter.colorValue = @(model.colorId);
                    break;
                }
            }
            
            for (DKYDahuoOrderColorModel *model in colorArray) {
                if(model.selected){
                    [selectedColorId addObject:model.colorName];
                }
            }
            
            if(selectedColorId.count > 0){
                self.addProductApproveParameter.colorArr = [selectedColorId componentsJoinedByString:@";"];
            }
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

- (void)dealWithgetPzsJsonFromServer:(NSInteger)flag value:(NSArray*)value{
    switch (flag) {
        case 2:
            self.madeInfoByProductName.productMadeInfoView.zzJsonArray = self.zzJsonArray;
            self.madeInfoByProductName.productMadeInfoView.zxJsonArray = self.zxJsonArray;
            self.madeInfoByProductName.productMadeInfoView.zbJsonArray = self.zbJsonArray;
            break;
        case 3:
            self.madeInfoByProductName.productMadeInfoView.zxJsonArray = self.zxJsonArray;
            self.madeInfoByProductName.productMadeInfoView.zbJsonArray = self.zbJsonArray;
            break;
        case 4:
            self.madeInfoByProductName.productMadeInfoView.zbJsonArray = self.zbJsonArray;
            break;
        case 5:
            
            break;
        default:
            break;
    }
    [self updateActionSheetAfterGetPzsJsonFromServer:flag];
}

- (void)updateActionSheetAfterGetPzsJsonFromServer:(NSInteger)flag{
    switch (flag) {
        case 2:{
            BOOL exist = NO;
            for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.zzJsonArray) {
                if([model.ID integerValue] == [self.addProductApproveParameter.mDimNew15Id integerValue]){
                    exist = YES;
                    break;
                }
            }
            if(!exist){
                // 不存在，则刷新
                [self.secondBtn setTitle:self.secondBtn.originalTitle forState:UIControlStateNormal];
                self.addProductApproveParameter.mDimNew15Id = nil;
            }
            
            exist = NO;
            for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.zxJsonArray) {
                if([model.ID integerValue] == [self.addProductApproveParameter.mDimNew16Id integerValue]){
                    exist = YES;
                    break;
                }
            }
            if(!exist){
                // 不存在，则刷新
                [self.thirdBtn setTitle:self.thirdBtn.originalTitle forState:UIControlStateNormal];
                self.addProductApproveParameter.mDimNew16Id = nil;

            }
            
            exist = NO;
            for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.zbJsonArray) {
                if([model.ID integerValue] == [self.addProductApproveParameter.mDimNew17Id integerValue]){
                    exist = YES;
                    break;
                }
            }
            if(!exist){
                if(self.madeInfoByProductName.productMadeInfoView.zbJsonArray.count == 0){
                    // 不存在，则刷新
                    [self.fourthBtn setTitle:self.fourthBtn.originalTitle forState:UIControlStateNormal];
                    self.addProductApproveParameter.mDimNew17Id = nil;
                    return;
                }
                
                // 不存在，则取新的选项的第一项值
                DKYDimlistItemModel *firstModel = [self.madeInfoByProductName.productMadeInfoView.zbJsonArray firstObject];
                [self.fourthBtn setTitle:firstModel.attribname forState:UIControlStateNormal];
                self.addProductApproveParameter.mDimNew17Id = @([firstModel.ID integerValue]);
            }
        }
            break;
        case 3:{
            BOOL exist = NO;
            for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.zxJsonArray) {
                if([model.ID integerValue] == [self.addProductApproveParameter.mDimNew16Id integerValue]){
                    exist = YES;
                    break;
                }
            }
            if(!exist){
                // 不存在，则刷新
                [self.thirdBtn setTitle:self.thirdBtn.originalTitle forState:UIControlStateNormal];
                self.addProductApproveParameter.mDimNew16Id = nil;
            }
            
            exist = NO;
            for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.zbJsonArray) {
                if([model.ID integerValue] == [self.addProductApproveParameter.mDimNew17Id integerValue]){
                    exist = YES;
                    break;
                }
            }
            if(!exist){
                if(self.madeInfoByProductName.productMadeInfoView.zbJsonArray.count == 0){
                    // 不存在，则刷新
                    [self.fourthBtn setTitle:self.fourthBtn.originalTitle forState:UIControlStateNormal];
                    self.addProductApproveParameter.mDimNew17Id = nil;
                    return;
                }
                
                // 不存在，则取新的选项的第一项值
                DKYDimlistItemModel *firstModel = [self.madeInfoByProductName.productMadeInfoView.zbJsonArray firstObject];
                [self.fourthBtn setTitle:firstModel.attribname forState:UIControlStateNormal];
                self.addProductApproveParameter.mDimNew17Id = @([firstModel.ID integerValue]);
            }
            
        }
            break;
        case 4:{
            BOOL exist = NO;
            for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.zbJsonArray) {
                if([model.ID integerValue] == [self.addProductApproveParameter.mDimNew17Id integerValue]){
                    exist = YES;
                    break;
                }
            }
            if(!exist){
                if(self.madeInfoByProductName.productMadeInfoView.zbJsonArray.count == 0){
                    // 不存在，则刷新
                    [self.fourthBtn setTitle:self.fourthBtn.originalTitle forState:UIControlStateNormal];
                    self.addProductApproveParameter.mDimNew17Id = nil;
                    return;
                }
                
                // 不存在，则取新的选项的第一项值
                DKYDimlistItemModel *firstModel = [self.madeInfoByProductName.productMadeInfoView.zbJsonArray firstObject];
                [self.fourthBtn setTitle:firstModel.attribname forState:UIControlStateNormal];
                self.addProductApproveParameter.mDimNew17Id = @([firstModel.ID integerValue]);
            }
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    //    if(self.optionsBtnClicked){
    //        self.optionsBtnClicked(sender,sender.tag);
    //    }
    if(sender.tag == 4){
        [self showMultipleSelectPopupView];
        return;
    }
    
    [self showOptionsPicker:sender];
}

#pragma mark - private method
- (void)showOptionsPicker:(UIButton *)sender{
    [self.superview endEditing:YES];
    
    NSMutableArray *item = @[].mutableCopy;
    NSArray *models = nil;
    
    switch (sender.tag) {
        case 0:{
            if(self.madeInfoByProductName){
                // 输入款号之后
                models = self.madeInfoByProductName.productMadeInfoView.pzJsonArray;
            }else{
                models = self.customOrderDimList.DIMFLAG_NEW14;
            }
        }
            break;
        case 1:{
            if(self.madeInfoByProductName){
                // 输入款号之后
                models = self.madeInfoByProductName.productMadeInfoView.zzJsonArray;
            }else{
                models = self.customOrderDimList.DIMFLAG_NEW15;;
            }
        }
            break;
        case 2:{
            if(self.madeInfoByProductName){
                // 输入款号之后
                models = self.madeInfoByProductName.productMadeInfoView.zxJsonArray;
            }else{
                models = self.customOrderDimList.DIMFLAG_NEW16;
            }
        }
            break;
        case 3:{
            if(self.madeInfoByProductName){
                // 输入款号之后
                models = self.madeInfoByProductName.productMadeInfoView.zbJsonArray;
            }else{
                models = self.customOrderDimList.DIMFLAG_NEW17;
            }
        }
            break;
        case 5:{
            models = self.madeInfoByProductName.colorRangeViewList;
        }
            break;
    }
    
    if(sender.tag != 5){
        for (DKYDimlistItemModel *model in models) {
            [item addObject:model.attribname];
        }
    }else{
        for (NSDictionary *dict in models) {
            [item addObject:[dict objectForKey:@"colorName"]];
        }
    }
    
    DLog(@"sender.extraInfo = %@",sender.extraInfo);
    WeakSelf(weakSelf);
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:sender.extraInfo
                                             cancelButtonTitle:kDeleteTitle
                                                       clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
                                                           DLog(@"buttonIndex = %@ clicked",@(buttonIndex));
                                                           if(buttonIndex != 0 && sender.tag != 5){
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
    DKYDimlistItemModel *model = nil;
    switch (tag) {
        case 0:{
            if(self.madeInfoByProductName){
                // 输入款号之后
                models = self.madeInfoByProductName.productMadeInfoView.pzJsonArray;
            }else{
                models = self.customOrderDimList.DIMFLAG_NEW14;
            }
            
            model = [models objectOrNilAtIndex:index - 1];
            
            NSNumber *oldOption = self.addProductApproveParameter.mDimNew14Id;
            // 清空
            if(!model){
                self.addProductApproveParameter.mDimNew14Id = nil;
            }else{
                self.addProductApproveParameter.mDimNew14Id = @([model.ID integerValue]);
            }
            
            if(self.madeInfoByProductName && self.addProductApproveParameter.mDimNew14Id != nil &&([self.addProductApproveParameter.mDimNew14Id integerValue] != [oldOption integerValue])){
                [self updateActionSheetOptionsWithFlag:2];
            }
            [self updateColorSheet];
        }
            break;
        case 1:{
            if(self.madeInfoByProductName){
                // 输入款号之后
                models = self.madeInfoByProductName.productMadeInfoView.zzJsonArray;
            }else{
                models = self.customOrderDimList.DIMFLAG_NEW15;;
            }
            
            model = [models objectOrNilAtIndex:index - 1];
            NSNumber *oldOption = self.addProductApproveParameter.mDimNew15Id;
            // 清空
            if(!model){
                self.addProductApproveParameter.mDimNew15Id = nil;
            }else{
                self.addProductApproveParameter.mDimNew15Id = @([model.ID integerValue]);
            }
            [self dealWithmDimNew15IdSelected];
            if(self.madeInfoByProductName && self.addProductApproveParameter.mDimNew14Id != nil &&([self.addProductApproveParameter.mDimNew14Id integerValue] != [oldOption integerValue])){
                [self updateActionSheetOptionsWithFlag:3];
            }
        } 
            break;
        case 2:{
            if(self.madeInfoByProductName){
                // 输入款号之后
                models = self.madeInfoByProductName.productMadeInfoView.zxJsonArray;
            }else{
                models = self.customOrderDimList.DIMFLAG_NEW16;
            }
            
            model = [models objectOrNilAtIndex:index - 1];
            NSNumber *oldOption = self.addProductApproveParameter.mDimNew16Id;
            // 清空
            if(!model){
                self.addProductApproveParameter.mDimNew16Id = nil;
            }else{
                self.addProductApproveParameter.mDimNew16Id = @([model.ID integerValue]);
            }
            if(self.madeInfoByProductName && self.addProductApproveParameter.mDimNew14Id != nil &&([self.addProductApproveParameter.mDimNew14Id integerValue] != [oldOption integerValue])){
                [self updateActionSheetOptionsWithFlag:4];
            }
        }
            break;
        case 3:{
            if(self.madeInfoByProductName){
                // 输入款号之后
                models = self.madeInfoByProductName.productMadeInfoView.zbJsonArray;
            }else{
                models = self.customOrderDimList.DIMFLAG_NEW17;
            }
            
            model = [models objectOrNilAtIndex:index - 1];
            // 清空
            if(!model){
                self.addProductApproveParameter.mDimNew17Id = nil;
            }else{
                self.addProductApproveParameter.mDimNew17Id = @([model.ID integerValue]);
            }
        }
            break;
        case 5:{
            models = self.madeInfoByProductName.colorRangeViewList;
            
            NSDictionary *colorGroup = [models objectOrNilAtIndex:index - 1];
            
            NSString *color = [colorGroup objectForKey:@"colorName"];
            
            // 解析选中颜色，取出()前面
            NSArray *temp = [color componentsSeparatedByString:@","];
            
            NSMutableArray *colors = [NSMutableArray arrayWithCapacity:temp.count];
            
            for (NSString *item in temp) {
                NSRange range = [item rangeOfString:@"("];
                NSString *colorName = nil;
                if(range.location != NSNotFound){
                    colorName = [item substringToIndex:range.location];
                }else{
                    colorName = item;
                }
                
                [colors addObject:colorName];
            }
            
            [self colorGroupSelected:colors.copy];
            
            DLog(@"colors = %@",colors);
        }
            break;

    }
}

- (void)colorGroupSelected:(NSArray*)selectedColors{
    NSMutableArray *clrRangeArray = [NSMutableArray array];
    NSMutableArray *selectedColorModels = [NSMutableArray array];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@""];
    
    for (NSString *colorName in selectedColors) {
        BOOL match = NO;
        DKYDahuoOrderColorModel *color  = nil;
        for (color in self.madeInfoByProductName.displayColorViewList) {
            if([color.colorName isEqualToString:colorName]){
                color.selected = YES;
                match = YES;
                break;
            }
        }
        if(match){
            NSString *oneColor = [NSString stringWithFormat:@"%@(%@); ",color.colorName,color.colorDesc];
            
            [clrRangeArray addObject:color.colorName];
            [selectedColorModels addObject:color];
            
            NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] initWithString:oneColor];
            tagText.yy_color = [UIColor colorWithHex:0x333333];
            tagText.yy_font = [UIFont systemFontOfSize:18];
            
            //        YYTextBorder *border = [[YYTextBorder alloc] init];
            //        border.fillColor = [UIColor randomColor];
            //        border.lineStyle = YYTextLineStyleSingle;
            //        [tagText setYy_textBackgroundBorder:border];
            
            [text appendAttributedString:tagText];
            
            NSMutableAttributedString *blank = [[NSMutableAttributedString alloc] initWithString:@"   "];
            blank.yy_font = [UIFont systemFontOfSize:12];
            YYTextBorder *blank_border = [[YYTextBorder alloc] init];
            blank_border.fillColor = [UIColor clearColor];
            blank_border.lineStyle = YYTextLineStyleSingle;
            [blank setYy_textBackgroundBorder:blank_border];
            [text appendAttributedString:blank];
        }
    }
    for (DKYDahuoOrderColorModel *color in self.madeInfoByProductName.displayColorViewList) {
        BOOL match = NO;
        for (NSString *colorName in selectedColors) {
            if([color.colorName isEqualToString:colorName]){
                color.selected = YES;
                match = YES;
                break;
            }
        }
        
        if(!match){
            color.selected = NO;
        }
    }
    
    // 主色
    DKYDahuoOrderColorModel *model = [selectedColorModels objectOrNilAtIndex:0];
    self.addProductApproveParameter.colorValue = @(model.colorId);

    
    if(selectedColorModels.count > 0){
        self.addProductApproveParameter.colorArr = [clrRangeArray componentsJoinedByString:@";"];
    }else{
        self.addProductApproveParameter.colorArr = nil;
    }
    
    self.selectedColorView.attributedText = text;
    
    if(selectedColors.count == 0){
        self.addProductApproveParameter.colorSource = DKYDetailOrderSelectedColorType_Unset;
        self.colorBtn.enabled = YES;
    }else{
        self.addProductApproveParameter.colorSource = DKYDetailOrderSelectedColorType_ColorGroup;
        self.colorBtn.enabled = NO;
    }
}

- (void)dealWithmDimNew15IdSelected{
    if(self.mDimNew15IdBlock){
        self.mDimNew15IdBlock(nil,0);
    }
}

- (void)updateActionSheetOptionsWithFlag:(NSInteger)flag{
    self.getPzsJsonParameter.flag = [NSString stringWithFormat:@"%@",@(flag)];
    self.getPzsJsonParameter.productId = self.madeInfoByProductName.productMadeInfoView.productId;
    self.getPzsJsonParameter.mDimNew14Id = self.addProductApproveParameter.mDimNew14Id;
    self.getPzsJsonParameter.mDimNew15Id = self.addProductApproveParameter.mDimNew15Id;
    self.getPzsJsonParameter.mDimNew16Id = self.addProductApproveParameter.mDimNew16Id;
    
    if([self checkForupdateActionSheetOptions]){
        [self getPzsJsonFromServer];
    }
}

- (void)updateColorSheet{
    self.getColorListRequestParameter.mDimNew14Id = self.addProductApproveParameter.mDimNew14Id;
    
    // 品种选择了清除
    if(self.addProductApproveParameter.mDimNew14Id == nil){
        
        // 恢复默认情况 UI
        for (DKYDahuoOrderColorModel *model in self.madeInfoByProductName.colorViewList) {
            for (NSString *selectColor in self.madeInfoByProductName.productMadeInfoView.clrRangeArray) {
                if([model.colorName isEqualToString:selectColor]){
                    model.selected = YES;
                    break;
                }else{
                    model.selected = NO;
                }
            }
        }
        
        NSMutableString *selectedColor = [NSMutableString string];
        for (DKYDahuoOrderColorModel *color in self.madeInfoByProductName.colorViewList) {
            if(color.selected){
                NSString *oneColor = [NSString stringWithFormat:@"%@(%@); ",color.colorName,color.colorDesc];
                [selectedColor appendString:oneColor];
            }
        }
        
        if([selectedColor isNotBlank]){
            self.selectedColorView.text = selectedColor;
        }
        
        
        // 恢复参数默认情况
        NSMutableArray *selectedColorId = [NSMutableArray array];
        for (DKYDahuoOrderColorModel *model in self.madeInfoByProductName.colorViewList) {
            if(model.selected){
                self.addProductApproveParameter.colorValue = @(model.colorId);
                break;
            }
        }
        
        for (DKYDahuoOrderColorModel *model in self.madeInfoByProductName.colorViewList) {
            if(model.selected){
                [selectedColorId addObject:model.colorName];
            }
        }
        
        if(selectedColorId.count > 0){
            self.addProductApproveParameter.colorArr = [selectedColorId componentsJoinedByString:@";"];
        }
        
        self.madeInfoByProductName.displayColorViewList = self.madeInfoByProductName.colorViewList;
        return;
    }
    
    [self getColorListFromServer];
}

- (BOOL)checkForupdateActionSheetOptions{
    if(self.getPzsJsonParameter.mDimNew14Id == nil){
        [DKYHUDTool showInfoWithStatus:@"品种不能为空!"];
        return NO;
    }
    if(self.getPzsJsonParameter.mDimNew15Id == nil){
        [DKYHUDTool showInfoWithStatus:@"组织不能为空!"];
        return NO;
    }
    if(self.getPzsJsonParameter.mDimNew16Id == nil){
        [DKYHUDTool showInfoWithStatus:@"针型不能为空!"];
        return NO;
    }
    return YES;
}

- (void)showMultipleSelectPopupView{
    DKYMultipleSelectPopupView *pop = [DKYMultipleSelectPopupView show];
    pop.addProductApproveParameter = self.addProductApproveParameter;
    pop.colorViewList = self.madeInfoByProductName.displayColorViewList;
    pop.clrRangeArray = self.madeInfoByProductName.productMadeInfoView.clrRangeArray;
    WeakSelf(weakSelf);
    pop.confirmBtnClicked = ^(NSMutableArray *selectedColors) {
        NSMutableArray *clrRangeArray = [NSMutableArray array];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@""];
        
        for (DKYDahuoOrderColorModel *color in selectedColors) {
            NSString *oneColor = [NSString stringWithFormat:@"%@(%@); ",color.colorName,color.colorDesc];
            [clrRangeArray addObject:color.colorName];
            
            NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] initWithString:oneColor];
            tagText.yy_color = [UIColor colorWithHex:0x333333];
            tagText.yy_font = [UIFont systemFontOfSize:18];
            
            //        YYTextBorder *border = [[YYTextBorder alloc] init];
            //        border.fillColor = [UIColor randomColor];
            //        border.lineStyle = YYTextLineStyleSingle;
            //        [tagText setYy_textBackgroundBorder:border];
            
            [text appendAttributedString:tagText];
            
            NSMutableAttributedString *blank = [[NSMutableAttributedString alloc] initWithString:@"   "];
            blank.yy_font = [UIFont systemFontOfSize:12];
            YYTextBorder *blank_border = [[YYTextBorder alloc] init];
            blank_border.fillColor = [UIColor clearColor];
            blank_border.lineStyle = YYTextLineStyleSingle;
            [blank setYy_textBackgroundBorder:blank_border];
            [text appendAttributedString:blank];
        }
        weakSelf.madeInfoByProductName.productMadeInfoView.clrRangeArray = [clrRangeArray copy];
        
        self.selectedColorView.attributedText = text;
        
        if(selectedColors.count > 0){
            weakSelf.addProductApproveParameter.colorSource = DKYDetailOrderSelectedColorType_MulSelected;
            weakSelf.colorGroupBtn.enabled = NO;
        }else{
            weakSelf.addProductApproveParameter.colorSource = DKYDetailOrderSelectedColorType_Unset;
            weakSelf.colorGroupBtn.enabled = YES;
        }
    };
}
#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    [self setupOptionsBtn];
    
    [self setupSelectedColorView];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:label];
    self.titleLabel = label;
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(40);
    }];
    label.adjustsFontSizeToFitWidth = YES;
}

- (void)setupOptionsBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eleven];
    [self addSubview:btn];
    btn.tag = 0;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        //        make.right.mas_equalTo(weakSelf);
        make.width.mas_equalTo(140);
    }];
    [btn setTitle:@"点击选择品种" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
    self.optionsBtn = btn;
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eleven];
    [self addSubview:btn];
    btn.tag = 1;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.optionsBtn);
        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(30);
        make.width.mas_equalTo(weakSelf.optionsBtn);
        make.height.mas_equalTo(weakSelf.optionsBtn);
    }];
    [btn setTitle:@"点击选择组织" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
    self.secondBtn = btn;
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eleven];
    [self addSubview:btn];
    btn.tag = 2;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.optionsBtn);
        make.left.mas_equalTo(weakSelf.secondBtn.mas_right).with.offset(30);
        make.width.mas_equalTo(weakSelf.optionsBtn);
        make.height.mas_equalTo(weakSelf.optionsBtn);
    }];
    [btn setTitle:@"点击选择针型" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
    self.thirdBtn = btn;
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eleven];
    [self addSubview:btn];
    btn.tag = 3;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.optionsBtn.mas_bottom).with.offset(20);
        make.left.mas_equalTo(weakSelf.optionsBtn);
        make.width.mas_equalTo(weakSelf.optionsBtn);
        make.height.mas_equalTo(weakSelf.optionsBtn);
    }];
    
    [btn setTitle:@"点击选择支别" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
    self.fourthBtn = btn;
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eleven];
    [self addSubview:btn];
    btn.tag = 5;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.fourthBtn);
        make.left.mas_equalTo(weakSelf.fourthBtn.mas_right).with.offset(30);
        make.width.mas_equalTo(weakSelf.optionsBtn);
        make.height.mas_equalTo(weakSelf.optionsBtn);
    }];
    [btn setTitle:@"设计师推荐色" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.extraInfo = [btn currentTitle];

//    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.colorGroupBtn = btn;
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eleven];
    [self addSubview:btn];
    btn.tag = 4;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.fourthBtn);
        make.left.mas_equalTo(weakSelf.colorGroupBtn.mas_right).with.offset(30);
        make.width.mas_equalTo(weakSelf.optionsBtn);
        make.height.mas_equalTo(weakSelf.optionsBtn);
    }];
    [btn setTitle:@"自选颜色" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
    
    self.colorBtn = btn;
}

- (void)setupSelectedColorView{
    YYTextView *view = [[YYTextView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    view.font = [UIFont systemFontOfSize:18];
    view.textColor = [UIColor colorWithHex:0x333333];
    view.editable = NO;
    
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor colorWithHex:0x686868].CGColor;
    
    self.selectedColorView = view;
    
    WeakSelf(weakSelf);
    [self.selectedColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.fourthBtn.mas_bottom).with.offset(20);;
        make.left.mas_equalTo(weakSelf.fourthBtn);
        make.right.mas_equalTo(weakSelf.thirdBtn);
        make.bottom.mas_equalTo(weakSelf);
    }];
    
//    view.backgroundColor = [UIColor randomColor];
}

#pragma mark - get & set method
- (DKYGetPzsJsonParameter*)getPzsJsonParameter{
    if(_getPzsJsonParameter == nil){
        _getPzsJsonParameter = [[DKYGetPzsJsonParameter alloc] init];
    }
    return _getPzsJsonParameter;
}

- (DKYGetColorListRequestParameter*)getColorListRequestParameter{
    if(_getColorListRequestParameter == nil){
        _getColorListRequestParameter = [[DKYGetColorListRequestParameter alloc] init];
    }
    return _getColorListRequestParameter;
}

@end
