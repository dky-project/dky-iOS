//
//  DKYCustomOrderLingItemView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/19.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderLingItemView.h"
#import "DKYCustomOrderTypeOneView.h"

@interface DKYCustomOrderLingItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

// 袖边
@property (nonatomic, weak) UIButton *optionsBtn;

@property (nonatomic, weak) DKYCustomOrderTypeOneView *oneView;

// 尺寸
@property (nonatomic, weak) DKYTitleInputView *sizeView;

// 领边层
@property (nonatomic, weak) UIButton *lbcBtn;

// 领边
@property (nonatomic, weak) UIButton *lbBtn;

@property (nonatomic, weak) UITextField *textField;

// 领型
@property (nonatomic, weak) UIButton *lxBtn;

// 粒扣
@property (nonatomic, weak) DKYTitleInputView *likouView;

// 其他备注
@property (nonatomic, weak) DKYTitleInputView *otherMarkView;
// 备注
@property (nonatomic, weak) DKYTitleInputView *markView;

@end

@implementation DKYCustomOrderLingItemView

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
    CGFloat offset = itemModel.textFieldLeftOffset > 0 ? itemModel.textFieldLeftOffset : 10;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textFrame.size.width + offset);
    }];
}

- (void)setMadeInfoByProductName:(DKYMadeInfoByProductNameModel *)madeInfoByProductName{
    [super setMadeInfoByProductName:madeInfoByProductName];
    [self clear];
    if(!madeInfoByProductName) return;
    
    if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 65||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 369||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 64||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 62||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 68||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 307||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 308||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 309||
             ((madeInfoByProductName.productMadeInfoView.mDimNew13Id == 364||
               madeInfoByProductName.productMadeInfoView.mDimNew13Id == 365)&&
              madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367)){
        self.canEdit = NO;
    }else{
        self.canEdit = YES;
        
        if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 355||
           madeInfoByProductName.productMadeInfoView.mDimNew12Id == 56){
            self.textField.enabled = NO;
        }
        
        if([madeInfoByProductName.productMadeInfoView.lwqt isNotBlank]){
            self.oneView.textField.text = madeInfoByProductName.productMadeInfoView.lwqt;
            DKYDimlistItemModel *model =  [self.customOrderDimList.lingArray objectOrNilAtIndex:0];
            [self.optionsBtn setTitle:model.attribname forState:UIControlStateNormal];
            [self dealWithLingSelected:3];
        }
        
        if([madeInfoByProductName.productMadeInfoView.lbt isNotBlank]){
            self.oneView.textField.text = madeInfoByProductName.productMadeInfoView.lbt;
            DKYDimlistItemModel *model =  [self.customOrderDimList.lingArray objectOrNilAtIndex:1];
            [self.optionsBtn setTitle:model.attribname forState:UIControlStateNormal];
            [self dealWithLingSelected:1];
        }
        
        if([madeInfoByProductName.productMadeInfoView.lxt isNotBlank]){
            self.oneView.textField.text = madeInfoByProductName.productMadeInfoView.lxt;
            DKYDimlistItemModel *model =  [self.customOrderDimList.lingArray objectOrNilAtIndex:2];
            [self.optionsBtn setTitle:model.attribname forState:UIControlStateNormal];
            [self dealWithLingSelected:2];
        }
        
        self.sizeView.textField.text = madeInfoByProductName.productMadeInfoView.lbccValue;
        
        if(self.madeInfoByProductName.productMadeInfoView.mDimNew28Id > 0){
            for (DKYDimlistItemModel *model in self.customOrderDimList.DIMFLAG_NEW28) {
                if([model.ID integerValue] == self.madeInfoByProductName.productMadeInfoView.mDimNew28Id){
                    [self.lbcBtn setTitle:model.attribname forState:UIControlStateNormal];
                    break;
                }
            }
        }
        
        if(self.madeInfoByProductName.productMadeInfoView.mDimNew26Id > 0){
            for (DKYDimlistItemModel *model in self.customOrderDimList.DIMFLAG_NEW26) {
                if([model.ID integerValue] == self.madeInfoByProductName.productMadeInfoView.mDimNew26Id){
                    [self.lbBtn setTitle:model.attribname forState:UIControlStateNormal];
                    break;
                }
            }
        }
        
        if(self.madeInfoByProductName.productMadeInfoView.mDimNew25Id > 0){
            for (DKYDimlistItemModel *model in self.customOrderDimList.DIMFLAG_NEW25) {
                if([model.ID integerValue] == self.madeInfoByProductName.productMadeInfoView.mDimNew25Id){
                    [self.lxBtn setTitle:model.attribname forState:UIControlStateNormal];
                    break;
                }
            }
        }
        
        self.markView.textField.text = madeInfoByProductName.productMadeInfoView.lxRemark;
        self.otherMarkView.textField.text = madeInfoByProductName.productMadeInfoView.qtxRemark;
        
        self.otherMarkView.textField.enabled = NO;
        self.likouView.textField.enabled = NO;
        if(madeInfoByProductName.productMadeInfoView.mDimNew25Id == 299 ||
           madeInfoByProductName.productMadeInfoView.mDimNew25Id == 302){
            self.likouView.textField.enabled = YES;
            self.otherMarkView.textField.enabled = NO;
        }else if(madeInfoByProductName.productMadeInfoView.mDimNew25Id == 270){
            self.likouView.textField.enabled = NO;
            self.otherMarkView.textField.enabled = YES;
        }
        
        self.textField.enabled = NO;
        if(madeInfoByProductName.productMadeInfoView.mDimNew26Id == 232){
            self.textField.enabled = YES;
        }
    }
}

- (void)fetchAddProductApproveInfo{
    self.addProductApproveParameter.lingNumber1Value = self.oneView.textField.text;
    self.addProductApproveParameter.lingNumber2Value = self.oneView.textField2.text;
}

- (void)dealwithMDimNew12IdSelected{
    if([self.addProductApproveParameter.mDimNew12Id integerValue] == 355||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 56){
        self.textField.enabled = NO;
    }else if([self.addProductApproveParameter.mDimNew12Id integerValue] == 65||
             [self.addProductApproveParameter.mDimNew12Id integerValue] == 369||
             [self.addProductApproveParameter.mDimNew12Id integerValue] == 64||
             [self.addProductApproveParameter.mDimNew12Id integerValue] == 62||
             [self.addProductApproveParameter.mDimNew12Id integerValue] == 68||
             [self.addProductApproveParameter.mDimNew12Id integerValue] == 307||
             [self.addProductApproveParameter.mDimNew12Id integerValue] == 308||
             [self.addProductApproveParameter.mDimNew12Id integerValue] == 309||
             (([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
               [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
              ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 368))){
                 self.canEdit = NO;
             }else{
                 self.canEdit = YES;
                 
                 
                 self.otherMarkView.textField.enabled = NO;
                 self.likouView.textField.enabled = NO;
                 if([self.addProductApproveParameter.mDimNew25Id integerValue] == 299 ||
                    [self.addProductApproveParameter.mDimNew25Id integerValue] == 302){
                     self.likouView.textField.enabled = YES;
                     self.otherMarkView.textField.enabled = NO;
                 }else if([self.addProductApproveParameter.mDimNew25Id integerValue] == 270){
                     self.likouView.textField.enabled = NO;
                     self.otherMarkView.textField.enabled = YES;
                 }
                 
                 self.textField.enabled = NO;
                 if([self.addProductApproveParameter.mDimNew26Id integerValue] == 232){
                     self.textField.enabled = YES;
                 }
             }
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    self.otherMarkView.textField.enabled = NO;
    
    [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    self.oneView.textField.text = nil;
    self.oneView.textField2.text = nil;
    self.sizeView.textField.text = nil;
    
    [self.lbcBtn setTitle:self.lbcBtn.originalTitle forState:UIControlStateNormal];
    [self.lbBtn setTitle:self.lbBtn.originalTitle forState:UIControlStateNormal];
    self.textField.text = nil;
    [self.lxBtn setTitle:self.lxBtn.originalTitle forState:UIControlStateNormal];
    self.likouView.textField.text = nil;
    self.markView.textField.text = nil;
    self.otherMarkView.textField.text = nil;
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    self.optionsBtn.enabled = canEdit;
    self.oneView.textField.enabled = canEdit;
    self.oneView.textField2.enabled = canEdit;
    self.sizeView.textField.enabled = canEdit;
    self.lbcBtn.enabled = canEdit;
    self.lbBtn.enabled = canEdit;
    self.textField.enabled = canEdit;
    self.lxBtn.enabled = canEdit;
    self.likouView.textField.enabled = canEdit;
    self.markView.textField.enabled = canEdit;
    self.otherMarkView.textField.enabled = canEdit;
}

#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    //    if(self.optionsBtnClicked){
    //        self.optionsBtnClicked(sender,sender.tag);
    //    }
    [self showOptionsPicker:sender];
}

- (void)oneViewLeftTextFieldEditing:(UITextField*)textField{
    self.addProductApproveParameter.lingNumber1Value = textField.text;
}

- (void)oneViewRightTextFieldEditing:(UITextField*)textField{
    self.addProductApproveParameter.lingNumber2Value = textField.text;
}

- (void)lbTextFieldEditingChanged:(UITextField *)textField{
    if(textField.text.length > 4){
        textField.text = [textField.text substringToIndex:4];
    }
    
    self.addProductApproveParameter.qtlbValue = textField.text;
}

#pragma mark - private method
- (void)showOptionsPicker:(UIButton *)sender{
    [self.superview endEditing:YES];
    
    NSMutableArray *item = @[].mutableCopy;
    NSArray *models = nil;
    
    switch (sender.tag) {
        case 0:
            models = self.customOrderDimList.DIMFLAG_NEW28;
            break;
        case 1:{
            // 领边
            models = self.customOrderDimList.DIMFLAG_NEW26;
            if(self.madeInfoByProductName){
                models = self.madeInfoByProductName.productCusmptcateView.lbShow;
            }
        }
            break;
        case 2:{
            // 领型
            models = self.customOrderDimList.DIMFLAG_NEW25;
            if(self.madeInfoByProductName){
                models = self.madeInfoByProductName.productCusmptcateView.lxShow;
            }
        }
            break;
        case 3:
            models = self.staticDimListModel.DIMFLAG5;
            break;
        default:
            break;
    }
    
    for (DKYDimlistItemModel *model in models) {
        [item addObject:model.attribname];
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
                                                           
                                                           if(sender.tag == 3){
                                                               [weakSelf dealWithLingSelected:buttonIndex];
                                                           }else{
                                                               [weakSelf actionSheetSelected:sender.tag index:buttonIndex];
                                                           }
                                                       }
                                         otherButtonTitleArray:item];
    actionSheet.scrolling = item.count > 10;
    actionSheet.visibleButtonCount = 10;
    actionSheet.destructiveButtonIndexSet = [NSSet setWithObjects:@0, nil];
    [actionSheet show];
}

- (void)dealWithLingSelected:(NSInteger)index{
    self.lbcBtn.enabled = YES;
    self.lbBtn.enabled = YES;
    self.lxBtn.enabled = YES;
    self.sizeView.textField.enabled = YES;
    
    DKYDimlistItemModel *model = [self.staticDimListModel.DIMFLAG5 objectOrNilAtIndex:index - 1];
    if(!model) {
        self.addProductApproveParameter.lingValue = nil;
        return;
    }
    
    if([model.attribname isEqualToString:@"领边"]){
        self.lbcBtn.enabled = NO;
        self.lbBtn.enabled = NO;
        self.sizeView.textField.enabled = NO;
    }else if([model.attribname isEqualToString:@"领型"]){
        self.lxBtn.enabled = NO;
    }else if([model.attribname isEqualToString:@"完全"]){
        self.lbcBtn.enabled = NO;
        self.lbBtn.enabled = NO;
        self.lxBtn.enabled = NO;
        self.sizeView.textField.enabled = NO;
    }
    [self.optionsBtn setTitle:model.attribname forState:UIControlStateNormal];
    self.addProductApproveParameter.lingValue = model.attribname;
//    switch (index) {
//        case 1:{
//            // 领边
//            self.lbcBtn.enabled = NO;
//            self.lbBtn.enabled = NO;
//            self.sizeView.textField.enabled = NO;
//        }
//            break;
//        case 2:{
//            // 领型
//            self.lxBtn.enabled = NO;
//        }
//            break;
//            
//        case 3:{
//            // 完全
//            self.lbcBtn.enabled = NO;
//            self.lbBtn.enabled = NO;
//            self.lxBtn.enabled = NO;
//            self.sizeView.textField.enabled = NO;
//        }
//            break;
//            
//        default:
//            break;
//    }
}

- (void)actionSheetSelected:(NSInteger)tag index:(NSInteger)index{
    NSArray *models = nil;
    DKYDimlistItemModel *model = nil;
    switch (tag) {
        case 0:
            // 领边层
            models = self.customOrderDimList.DIMFLAG_NEW28;
            
            model = [models objectOrNilAtIndex:index - 1];
            // 清空
            if(!model){
                self.addProductApproveParameter.mDimNew28Id = nil;
            }else{
                self.addProductApproveParameter.mDimNew28Id = @([model.ID integerValue]);
            }

            break;
        case 1:
            // 领边
            models = self.customOrderDimList.DIMFLAG_NEW26;
            if(self.madeInfoByProductName){
                models = self.madeInfoByProductName.productCusmptcateView.lbShow;
            }
            
            model = [models objectOrNilAtIndex:index - 1];
            // 清空
            if(!model){
                self.addProductApproveParameter.mDimNew26Id = nil;
            }else{
                self.addProductApproveParameter.mDimNew26Id = @([model.ID integerValue]);
            }
            DLog(@"领边 = %@",self.addProductApproveParameter.mDimNew26Id);
            [self dealwithmDimNew26IdSelected];
            break;
        case 2:
            // 领型
            models = self.customOrderDimList.DIMFLAG_NEW25;
            if(self.madeInfoByProductName){
                models = self.madeInfoByProductName.productCusmptcateView.lxShow;
            }
            
            model = [models objectOrNilAtIndex:index - 1];
            // 清空
            if(!model){
                self.addProductApproveParameter.mDimNew25Id = nil;
            }else{
                self.addProductApproveParameter.mDimNew25Id = @([model.ID integerValue]);
            }
            DLog(@"领型 = %@",self.addProductApproveParameter.mDimNew25Id);
            [self dealwithmDimNew25IdSelected];
            break;
        case 3:
            models = self.staticDimListModel.DIMFLAG5;
            break;
        default:
            break;
    }
}

- (void)dealwithmDimNew25IdSelected{
    self.otherMarkView.textField.enabled = NO;
    self.likouView.textField.enabled = NO;
    if([self.addProductApproveParameter.mDimNew25Id integerValue] == 299 ||
       [self.addProductApproveParameter.mDimNew25Id integerValue] == 302){
        self.likouView.textField.enabled = YES;
        self.otherMarkView.textField.enabled = NO;
    }else if([self.addProductApproveParameter.mDimNew25Id integerValue] == 270){
        self.likouView.textField.enabled = NO;
        self.otherMarkView.textField.enabled = YES;
    }
    
    if(self.addProductApproveParameter.mDimNew26Id && self.addProductApproveParameter.mDimNew25Id){
        self.addProductApproveParameter.lingValue = nil;
        [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
        self.optionsBtn.enabled = NO;
    }else{
        self.optionsBtn.enabled = YES;
    }
}

- (void)dealwithmDimNew26IdSelected{
    self.textField.enabled = [self.addProductApproveParameter.pdt isNotBlank] ? NO : YES;
    if([self.addProductApproveParameter.mDimNew26Id integerValue] == 232){
        self.textField.enabled = YES;
    }
    
    if(self.addProductApproveParameter.mDimNew25Id && self.addProductApproveParameter.mDimNew26Id){
        self.addProductApproveParameter.lingValue = nil;
        [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
        self.optionsBtn.enabled = NO;
    }else{
        self.optionsBtn.enabled = YES;
    }
}

- (void)dealwithMDimNew13IdSelected{
    if(([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
        [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
       ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
        [self.addProductApproveParameter.mDimNew12Id integerValue] == 368)){
        self.canEdit = NO;
    }else{
        [self dealwithMDimNew12IdSelected];
    }
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    [self setupOptionsBtn];
    
    [self setupOneView];
    [self setupSizeView];
    [self setupLbcsBtn];
    [self setupLbBtn];
    [self setupTextField];
    
    [self setupLxBtn];
    [self setupLikouView];
    [self setupOtherMarkView];
    [self setupMarkView];
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
}

- (void)setupOptionsBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    [btn setTitle:@"点击选择领" forState:UIControlStateNormal];
    self.optionsBtn = btn;
    btn.originalTitle = btn.currentTitle;
    btn.tag = 3;

    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupOneView{
    DKYCustomOrderTypeOneView *view = [[DKYCustomOrderTypeOneView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.oneView = view;
    
    WeakSelf(weakSelf);
    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth * 2 + DKYCustomOrderItemMargin);
        make.top.mas_equalTo(weakSelf.titleLabel);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"同";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    self.oneView.itemModel = itemModel;
    
    [self.oneView.textField addTarget:self action:@selector(oneViewLeftTextFieldEditing:) forControlEvents:UIControlEventEditingChanged];
    [self.oneView.textField2 addTarget:self action:@selector(oneViewRightTextFieldEditing:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setupSizeView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.sizeView = view;
    
    WeakSelf(weakSelf);
    [self.sizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.oneView.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.titleLabel);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"尺寸:";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.textFieldDidEditing = ^(UITextField* textField){
        weakSelf.addProductApproveParameter.lingCcValue = [textField.text isNotBlank] ? @([textField.text doubleValue]) : nil;
    };
    self.sizeView.itemModel = itemModel;
}

- (void)setupLbcsBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(20);
    }];
    self.lbcBtn = btn;
    [btn setTitle:@"点击选择领边层" forState:UIControlStateNormal];
    btn.originalTitle = btn.currentTitle;
    btn.tag = 0;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupLbBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.lbcBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.lbcBtn);
    }];
    self.lbBtn = btn;
    [btn setTitle:@"点击选择领边" forState:UIControlStateNormal];
    btn.originalTitle = btn.currentTitle;
    btn.tag =1;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupTextField{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self addSubview:textField];
    self.textField = textField;
    
    textField.layer.borderColor = [UIColor colorWithHex:0x666666].CGColor;
    textField.layer.borderWidth = 1;
    
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = [UIColor colorWithHex:0x666666];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
    leftView.frame = CGRectMake(0, 0, 10, self.textField.mj_h);
    self.textField.leftView = leftView;
    
    textField.background = [UIImage imageWithColor:[UIColor clearColor]];
    textField.disabledBackground = [UIImage imageWithColor:[UIColor colorWithHex:0xF0F0F0]];
    
    [self.textField addTarget:self action:@selector(lbTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    WeakSelf(weakSelf);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.lbBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.top.mas_equalTo(weakSelf.lbBtn);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
}

- (void)setupLxBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.lbcBtn.mas_bottom).with.offset(20);
    }];
    self.lxBtn = btn;
    [btn setTitle:@"点击选择领型" forState:UIControlStateNormal];
    btn.originalTitle = btn.currentTitle;
    btn.tag = 2;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupLikouView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.likouView = view;
    
    WeakSelf(weakSelf);
    [self.likouView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.lxBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.lxBtn);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"";
    itemModel.subText = @"粒扣";
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        weakSelf.addProductApproveParameter.lxsx4Value = textField.text;
    };
    self.likouView.itemModel = itemModel;
}

- (void)setupOtherMarkView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.otherMarkView = view;
    
    WeakSelf(weakSelf);
    [self.otherMarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.likouView.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.lxBtn);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"其他备注:";
    itemModel.subText = @"";
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        if(textField.text.length > 5){
            textField.text = [textField.text substringToIndex:5];
        }
        weakSelf.addProductApproveParameter.qtLingOther = [textField.text isNotBlank] ? @([textField.text doubleValue]) : nil;
    };
    self.otherMarkView.itemModel = itemModel;
    
    self.otherMarkView.textField.enabled = NO;
}

- (void)setupMarkView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.markView = view;
    
    WeakSelf(weakSelf);
    [self.markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.otherMarkView.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.right.mas_equalTo(weakSelf.sizeView);
        make.top.mas_equalTo(weakSelf.lxBtn);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"备注:";
    itemModel.subText = @"";
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        if(textField.text.length > 15){
            textField.text = [textField.text substringToIndex:15];
        }
        weakSelf.addProductApproveParameter.lxsx5Value = textField.text;
    };
    self.markView.itemModel = itemModel;
}

@end
