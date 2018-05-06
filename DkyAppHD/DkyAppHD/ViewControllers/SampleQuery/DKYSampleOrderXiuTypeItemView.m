//
//  DKYSampleOrderXiuTypeItemView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/5/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleOrderXiuTypeItemView.h"
#import "DKYGetSizeDataModel.h"

@interface DKYSampleOrderXiuTypeItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

// 袖形
@property (nonatomic, weak) UIButton *optionsBtn;
@property (nonatomic, weak) UITextField *textField;


@property (nonatomic, weak) UIButton *optionsBtn2;
@property (nonatomic, weak) UITextField *textField2;

@property (nonatomic, weak) UIButton *optionsBtn3;
@property (nonatomic, weak) UITextField *textField3;

@property (nonatomic, weak) DKYTitleInputView *xcView;

@end

@implementation DKYSampleOrderXiuTypeItemView

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
    if(madeInfoByProductName == nil)  return;
    
    self.xcView.textField.text = madeInfoByProductName.productMadeInfoView.xcValue;
    
    self.xcView.textField.enabled = !([madeInfoByProductName.productCusmptcateView.isXcAffix caseInsensitiveCompare:@"Y"] == NSOrderedSame || ([madeInfoByProductName.productMadeInfoView.sizeType caseInsensitiveCompare:@"GD"] == NSOrderedSame && [madeInfoByProductName.productMadeInfoView.xcValue isNotBlank]));
    
    // 不显示袖长
    if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 55||
       madeInfoByProductName.productMadeInfoView.mDimNew22Id == 131){
        self.canEdit = NO;
    }else{
        if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 19||
           madeInfoByProductName.productMadeInfoView.mDimNew12Id == 53||
           madeInfoByProductName.productMadeInfoView.mDimNew12Id == 60||
           madeInfoByProductName.productMadeInfoView.mDimNew12Id == 54||
           madeInfoByProductName.productMadeInfoView.mDimNew12Id == 366){
            self.canEdit = YES;
        }else{
            // 两个都显示
            if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 307||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 369||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 368||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 308||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 309||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 61||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 62||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 63||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 65||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 68||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 56||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 59||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 58||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 355||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 64||
               madeInfoByProductName.productMadeInfoView.mDimNew12Id == 57){
                self.canEdit = NO;
            }
        }
    }
}

- (void)dealwithMDimNew12IdSelected{
    // 不显示袖长
    if([self.addProductApproveParameter.mDimNew12Id integerValue] == 55||
       [self.addProductApproveParameter.mDimNew22Id integerValue] == 131){
        self.canEdit = NO;
    }else{
        if([self.addProductApproveParameter.mDimNew12Id integerValue] == 19||
           [self.addProductApproveParameter.mDimNew12Id integerValue] == 53||
           [self.addProductApproveParameter.mDimNew12Id integerValue]== 60||
           [self.addProductApproveParameter.mDimNew12Id integerValue] == 54||
           [self.addProductApproveParameter.mDimNew12Id integerValue] == 366){
            self.canEdit = YES;
        }else{
            // 两个都显示
            if([self.addProductApproveParameter.mDimNew12Id integerValue] == 307||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 369||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 368||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 308||
               [self.addProductApproveParameter.mDimNew12Id integerValue]== 309||
               [self.addProductApproveParameter.mDimNew12Id integerValue]== 61||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 62||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 63||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 65||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 68||
               [self.addProductApproveParameter.mDimNew12Id integerValue]== 56||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 59||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 58||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 355||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 64||
               [self.addProductApproveParameter.mDimNew12Id integerValue] == 57){
                self.canEdit = NO;
            }
        }
    }
}

- (void)dealwithMDimNew22IdSelected{
    if(self.canEdit){
        if([self.addProductApproveParameter.mDimNew22Id integerValue] == 131){
            self.xcView.textField.enabled = NO;
        }else{
            self.xcView.textField.enabled = YES;
        }
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

- (void)dealWithXwValueSelected:(DKYGetSizeDataModel*)model{
    if(model == nil) return;
    
    self.xcView.textField.text = model.xc;
    
    self.addProductApproveParameter.defaultXcValue = [self.xcView.textField.text isNotBlank] ? @([self.xcView.textField.text doubleValue]) : nil;
    self.addProductApproveParameter.xcValue = [self.xcView.textField.text isNotBlank] ? self.xcView.textField.text: nil;
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    self.textField.text = nil;
    self.textField2.text = nil;
    self.textField3.text = nil;
    
    [self.optionsBtn2 setTitle:self.optionsBtn2.originalTitle forState:UIControlStateNormal];
    [self.optionsBtn3 setTitle:self.optionsBtn3.originalTitle forState:UIControlStateNormal];
    self.xcView.textField.text = nil;
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    
    self.optionsBtn.enabled = canEdit;
    self.textField.enabled = canEdit;
    self.textField2.enabled = canEdit;
    self.textField3.enabled = canEdit;
    
    self.optionsBtn2.enabled = canEdit;
    self.optionsBtn3.enabled = canEdit;
    
    self.xcView.textField.enabled = canEdit;
}


#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    //    if(self.optionsBtnClicked){
    //        self.optionsBtnClicked(sender,sender.tag);
    //    }
    [self showOptionsPicker:sender];
}

#pragma mark - private method
- (void)showOptionsPicker:(UIButton *)sender{
    [self.superview endEditing:YES];
    NSMutableArray *item = @[].mutableCopy;
    NSArray *models = nil;
    
    switch (sender.tag) {
        case 0:
            models = self.staticDimListModel.DIMFLAG1;
            break;
        case 1:
            models = self.staticDimListModel.DIMFLAG2;
            break;
        case 2:
            models = self.staticDimListModel.DIMFLAG3;
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
        case 0:
            //第一袖型
            if(index == 0){
                self.addProductApproveParameter.mDimNew9Id = nil;
                [self dealWithmDimNew9IdSelected];
                return;
            }
            
            models = self.staticDimListModel.DIMFLAG1;
            model = [models objectOrNilAtIndex:index - 1];
            self.addProductApproveParameter.mDimNew9Id = @([model.ID integerValue]);
            [self dealWithmDimNew9IdSelected];
            DLog(@"第一袖型 = %@",self.addProductApproveParameter.mDimNew22Id);
            break;
        case 1:
            // 第二袖型
            if(index == 0){
                self.addProductApproveParameter.mDimNew9Id1 = nil;
                return;
            }
            
            models = self.staticDimListModel.DIMFLAG2;
            model = [models objectOrNilAtIndex:index - 1];
            self.addProductApproveParameter.mDimNew9Id1 = @([model.ID integerValue]);
            break;
        case 2:
            //第三袖型
            if(index == 0){
                self.addProductApproveParameter.mDimNew9Id2 = nil;
                return;
            }
            
            models = self.staticDimListModel.DIMFLAG3;
            model = [models objectOrNilAtIndex:index - 1];
            self.addProductApproveParameter.mDimNew9Id2 = @([model.ID integerValue]);
            
            break;
        default:
            break;
    }
}

- (void)dealWithmDimNew9IdSelected{
    self.textField.enabled = NO;
    self.textField2.enabled = NO;
    self.textField3.enabled = NO;
    
    if([self.addProductApproveParameter.mDimNew9Id integerValue] == 185){
        self.textField.enabled = YES;
        self.textField2.enabled = NO;
        self.textField3.enabled = NO;
    }else if([self.addProductApproveParameter.mDimNew9Id integerValue] == -1){
        self.textField.enabled = YES;
        self.textField2.enabled = NO;
        self.textField3.enabled = YES;
    }else if([self.addProductApproveParameter.mDimNew9Id integerValue] == -2){
        self.textField.enabled = YES;
        self.textField2.enabled = YES;
        self.textField3.enabled = NO;
    }
}

- (void)textFieldEditingChanged:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            self.addProductApproveParameter.qtxxValue = textField.text;
            break;
        case 1:
            self.addProductApproveParameter.qtxxValue1 = textField.text;
            break;
        case 2:
            self.addProductApproveParameter.qtxxValue2 = textField.text;
            break;
        default:
            break;
    }
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
//    [self setupOptionsBtn];
//    [self setupTextField];
//    
//    [self setupOptionsBtn2];
//    [self setupTextField2];
//    
//    [self setupOptionsBtn3];
//    [self setupTextField3];
    
    [self setupXcView];
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
        make.bottom.mas_equalTo(weakSelf);
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
    self.optionsBtn = btn;
    [btn setTitle:@"点击选择袖型" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 0;
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
    
    textField.tag = 0;
    [self.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    WeakSelf(weakSelf);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.top.mas_equalTo(weakSelf);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
}

- (void)setupOptionsBtn2{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.textField.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.optionsBtn2 = btn;
    [btn setTitle:@"点击选择袖型" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 1;
    btn.extraInfo = @"";
}

- (void)setupTextField2{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self addSubview:textField];
    self.textField2 = textField;
    
    textField.layer.borderColor = [UIColor colorWithHex:0x666666].CGColor;
    textField.layer.borderWidth = 1;
    
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = [UIColor colorWithHex:0x666666];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
    leftView.frame = CGRectMake(0, 0, 10, self.textField.mj_h);
    self.textField2.leftView = leftView;
    
    textField.background = [UIImage imageWithColor:[UIColor clearColor]];
    textField.disabledBackground = [UIImage imageWithColor:[UIColor colorWithHex:0xF0F0F0]];
    
    textField.tag = 1;
    [self.textField2 addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    WeakSelf(weakSelf);
    [self.textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn2.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.top.mas_equalTo(weakSelf);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
}

- (void)setupOptionsBtn3{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.optionsBtn3 = btn;
    [btn setTitle:@"点击选择袖型" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 2;
    btn.extraInfo = @"";
}

- (void)setupTextField3{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self addSubview:textField];
    self.textField3 = textField;
    
    textField.layer.borderColor = [UIColor colorWithHex:0x666666].CGColor;
    textField.layer.borderWidth = 1;
    
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = [UIColor colorWithHex:0x666666];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
    leftView.frame = CGRectMake(0, 0, 10, self.textField.mj_h);
    self.textField3.leftView = leftView;
    
    textField.background = [UIImage imageWithColor:[UIColor clearColor]];
    textField.disabledBackground = [UIImage imageWithColor:[UIColor colorWithHex:0xF0F0F0]];
    
    textField.tag = 2;
    [self.textField3 addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    WeakSelf(weakSelf);
    [self.textField3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn3.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.top.mas_equalTo(weakSelf.optionsBtn3);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
}

- (void)setupXcView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.xcView = view;
    
    WeakSelf(weakSelf);
    [self.xcView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.textField3.mas_right).with.offset(DKYCustomOrderItemMargin);
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.width.mas_equalTo(DKYCustomOrderItemWidth);
//        make.top.mas_equalTo(weakSelf.optionsBtn3);
        
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.width.mas_equalTo(215);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        weakSelf.addProductApproveParameter.xcValue = [textField.text isNotBlank] ? textField.text  : nil;
        NSRange range = [textField.text rangeOfString:@"+"];
        if(range.location != NSNotFound){
            weakSelf.addProductApproveParameter.xcLeftValue = [textField.text substringToIndex:range.location];
        }else{
            weakSelf.addProductApproveParameter.xcLeftValue = textField.text;
        }
    };
    itemModel.zoomed = YES;
    self.xcView.itemModel = itemModel;
}

@end
