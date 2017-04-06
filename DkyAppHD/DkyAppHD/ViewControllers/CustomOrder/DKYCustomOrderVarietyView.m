//
//  DKYCustomOrderVarietyView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderVarietyView.h"
#import "DKYMultipleSelectPopupView.h"
#import "DKYGetPzsJsonParameter.h"

@interface DKYCustomOrderVarietyView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *optionsBtn;

@property (nonatomic, weak) UIButton *secondBtn;

@property (nonatomic, weak) UIButton *thirdBtn;

@property (nonatomic, weak) UIButton *fourthBtn;

@property (nonatomic, strong) DKYGetPzsJsonParameter *getPzsJsonParameter;

@end

@implementation DKYCustomOrderVarietyView

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
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    [self.secondBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    [self.thirdBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    [self.fourthBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
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
            NSArray *value = [dict objectForKey:@"value"];
            NSArray *array = [DKYDimlistItemModel mj_objectArrayWithKeyValuesArray:value];
            [weakSelf dealWithgetPzsJsonFromServer:flag value:array];
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
        case 1:
            self.madeInfoByProductName.productMadeInfoView.pzJsonArray = value;
            break;
        case 2:
            self.madeInfoByProductName.productMadeInfoView.zzJsonArray = value;
            break;
        case 3:
            self.madeInfoByProductName.productMadeInfoView.zxJsonArray = value;
            break;
        case 4:
            
            break;
        default:
            break;
    }
    [self updateActionSheetAfterGetPzsJsonFromServer:flag];
}

- (void)updateActionSheetAfterGetPzsJsonFromServer:(NSInteger)flag{
    switch (flag) {
        case 1:{
            BOOL exist = NO;
            for (DKYDimlistItemModel *model in self.madeInfoByProductName.productMadeInfoView.pzJsonArray) {
                if([model.ID integerValue] == [self.addProductApproveParameter.mDimNew14Id integerValue]){
                    exist = YES;
                    break;
                }
            }
            if(!exist){
                // 不存在，则刷新
                [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
            }
        }
            break;
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
    }
    
    for (DKYDimlistItemModel *model in models) {
        [item addObject:model.attribname];
    }
    
    DLog(@"sender.extraInfo = %@",sender.extraInfo);
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
                [self updateActionSheetOptionsWithFlag:1];
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
                [self updateActionSheetOptionsWithFlag:2];
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
                [self updateActionSheetOptionsWithFlag:3];
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
    pop.colorViewList = self.madeInfoByProductName.colorViewList;
    pop.clrRangeArray = self.madeInfoByProductName.productMadeInfoView.clrRangeArray;
}
#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    [self setupOptionsBtn];
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
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(40);
    }];
    label.adjustsFontSizeToFitWidth = YES;
}

- (void)setupOptionsBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    btn.tag = 0;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
//        make.right.mas_equalTo(weakSelf);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    [btn setTitle:@"点击选择品种" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
    self.optionsBtn = btn;
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    btn.tag = 1;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.optionsBtn);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(3.33);
        make.width.mas_equalTo(weakSelf.optionsBtn);
    }];
    [btn setTitle:@"点击选择组织" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
    self.secondBtn = btn;
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    btn.tag = 2;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.optionsBtn);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.secondBtn.mas_right).with.offset(3.33);
        make.width.mas_equalTo(weakSelf.optionsBtn);
    }];
    [btn setTitle:@"点击选择针型" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
    self.thirdBtn = btn;
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    btn.tag = 3;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.optionsBtn);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.thirdBtn.mas_right).with.offset(3.33);
        make.width.mas_equalTo(weakSelf.optionsBtn);
    }];
    [btn setTitle:@"点击选择支别" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
    self.fourthBtn = btn;
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    btn.tag = 4;
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.optionsBtn.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.optionsBtn);
        make.width.mas_equalTo(weakSelf.optionsBtn);
    }];
    [btn setTitle:@"点击多选颜色" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}
#pragma mark - get & set method
- (DKYGetPzsJsonParameter*)getPzsJsonParameter{
    if(_getPzsJsonParameter == nil){
        _getPzsJsonParameter = [[DKYGetPzsJsonParameter alloc] init];
    }
    return _getPzsJsonParameter;
}

@end
