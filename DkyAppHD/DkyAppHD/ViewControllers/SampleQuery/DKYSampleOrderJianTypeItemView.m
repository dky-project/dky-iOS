//
//  DKYSampleOrderJianTypeItemView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleOrderJianTypeItemView.h"
#import "DKYTitleSelectView.h"
#import "DKYTitleInputView.h"

@interface DKYSampleOrderJianTypeItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

// 肩形
@property (nonatomic, weak) UIButton *optionsBtn;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) DKYTitleInputView *jkView;

@property (nonatomic, weak) DKYTitleInputView *gyxcView;

@end

@implementation DKYSampleOrderJianTypeItemView

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
        self.titleLabel.font = [UIFont systemFontOfSize:22];
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
        }];
    }
}

- (void)setMadeInfoByProductName:(DKYMadeInfoByProductNameModel *)madeInfoByProductName{
    [super setMadeInfoByProductName:madeInfoByProductName];
    [self clear];
    
    if(madeInfoByProductName.productMadeInfoView.hzxcValue){
        self.gyxcView.textField.text = [NSString stringWithFormat:@"%@",madeInfoByProductName.productMadeInfoView.hzxcValue];
        self.addProductApproveParameter.hzxc1Value = madeInfoByProductName.productMadeInfoView.hzxcValue;
    }
    
    if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 55||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 58||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 65||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 369||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 64||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 63||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 62||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 68||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 307||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 308||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 309||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 61||
       ((madeInfoByProductName.productMadeInfoView.mDimNew13Id == 364||
         madeInfoByProductName.productMadeInfoView.mDimNew13Id == 365)&&
        (madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367||
         madeInfoByProductName.productMadeInfoView.mDimNew12Id == 368)
        )){
           self.canEdit = NO;
       }else{
           self.canEdit = YES;
           
           if([self.addProductApproveParameter.mDimNew22Id integerValue] == 131){
               self.gyxcView.textField.enabled = YES;
           }else{
               self.gyxcView.textField.enabled = NO;
           }
       }
}

- (void)dealwithMDimNew12IdSelected{
    if([self.addProductApproveParameter.mDimNew12Id integerValue] == 55||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 58||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 65||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 369||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 64||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 63||
       [self.addProductApproveParameter.mDimNew12Id integerValue]== 62||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 68||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 307||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 308||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 309||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 61||
       (([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
         [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
        ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
         [self.addProductApproveParameter.mDimNew12Id integerValue] == 368))){
            self.canEdit = NO;
        }else{
            self.canEdit = YES;
            
            if([self.addProductApproveParameter.mDimNew22Id integerValue] == 131){
                self.gyxcView.textField.enabled = YES;
            }else{
                self.gyxcView.textField.enabled = NO;
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

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    self.textField.text = nil;
    self.jkView.textField.text = nil;
    self.gyxcView.textField.text = nil;
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    
    self.optionsBtn.enabled = canEdit;
    self.textField.enabled = canEdit;
    self.jkView.textField.enabled = canEdit;
    self.gyxcView.textField.enabled = canEdit;
}


#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    //    if(self.optionsBtnClicked){
    //        self.optionsBtnClicked(sender,sender.tag);
    //    }
    [self showOptionsPicker:sender];
}

- (void)qtjxTextFieldEditingChanged:(UITextField*)textField{
    self.addProductApproveParameter.qtjxValue = textField.text;
}

#pragma mark - private method
- (void)showOptionsPicker:(UIButton *)sender{
    [self.superview endEditing:YES];
    
    NSMutableArray *item = @[].mutableCopy;
    
    for (DKYDimlistItemModel *model in self.customOrderDimList.displayDIMFLAG_NEW22) {
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
                                                           [weakSelf actionSheetSelected:0 index:buttonIndex];
                                                       }
                                         otherButtonTitleArray:item];
    actionSheet.scrolling = item.count > 10;
    actionSheet.visibleButtonCount = 10;
    actionSheet.destructiveButtonIndexSet = [NSIndexSet indexSetWithIndex:0];
    [actionSheet show];
}

- (void)actionSheetSelected:(NSInteger)tag index:(NSInteger)index{
    NSArray *models = nil;
    models = self.customOrderDimList.displayDIMFLAG_NEW22;
    
    // 清除
    if(index == 0){
        self.addProductApproveParameter.mDimNew22Id = nil;
        [self dealWithmDimNew22IdSelected];
        return;
    }
    
    DKYDimlistItemModel *model = [models objectOrNilAtIndex:index - 1];
    self.addProductApproveParameter.mDimNew22Id = @([model.ID integerValue]);
    [self dealWithmDimNew22IdSelected];
    DLog(@"肩型 = %@",self.addProductApproveParameter.mDimNew22Id);
}

- (void)dealWithmDimNew22IdSelected{
    // 默认状态
    self.canEdit = YES;
    
    self.textField.enabled = NO;
    self.gyxcView.textField.enabled = NO;
    
//    if(self.mDimNew22IdBlock){
//        self.mDimNew22IdBlock(nil,0);
//    }
    
    
    if([self.addProductApproveParameter.mDimNew22Id integerValue] == 131){
        self.textField.enabled = NO;
    }else{
        self.textField.enabled = YES;
    }
    
    if([self.addProductApproveParameter.mDimNew22Id integerValue] == 131 ||
       [self.addProductApproveParameter.mDimNew22Id integerValue] == 130||
       [self.addProductApproveParameter.mDimNew22Id integerValue] == 129){
        self.jkView.textField.enabled = NO;
    }else{
        self.jkView.textField.enabled = YES;
    }
    
    if([self.addProductApproveParameter.mDimNew22Id integerValue] == 133){
        self.gyxcView.textField.enabled = NO;
    }else{
        self.gyxcView.textField.enabled = YES;
    }
}


#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
//    [self setupOptionsBtn];
//    [self setupTextField];
//    [self setupJkView];
    [self setupGyxcView];
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
    [btn setTitle:@"点击选择肩型" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
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
    textField.textColor = [UIColor colorWithHex:0x333333];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
    leftView.frame = CGRectMake(0, 0, 10, self.textField.mj_h);
    self.textField.leftView = leftView;
    
    textField.background = [UIImage imageWithColor:[UIColor clearColor]];
    textField.disabledBackground = [UIImage imageWithColor:[UIColor colorWithHex:0xF0F0F0]];
    
    [self.textField addTarget:self action:@selector(qtjxTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    WeakSelf(weakSelf);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
}

- (void)setupJkView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.jkView = view;
    
    WeakSelf(weakSelf);
    [self.jkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.textField.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"肩宽:";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        weakSelf.addProductApproveParameter.jkValue = [textField.text isNotBlank] ? @([textField.text doubleValue]) : nil;
    };
    self.jkView.itemModel = itemModel;
}

- (void)setupGyxcView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.gyxcView = view;
    
    WeakSelf(weakSelf);
    [self.gyxcView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.jkView.mas_right).with.offset(DKYCustomOrderItemMargin);
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.width.mas_equalTo(DKYCustomOrderItemWidth);
//        make.top.mas_equalTo(weakSelf);
        
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.width.mas_equalTo(218);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        weakSelf.addProductApproveParameter.hzxc1Value = [textField.text isNotBlank] ? @([textField.text doubleValue]) : nil;
    };
    itemModel.zoomed = YES;
    self.gyxcView.itemModel = itemModel;
}
@end
