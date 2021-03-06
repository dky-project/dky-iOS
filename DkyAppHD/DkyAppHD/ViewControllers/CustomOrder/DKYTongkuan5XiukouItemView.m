//
//  DKYTongkuan5XiukouItemView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/12/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYTongkuan5XiukouItemView.h"

@interface DKYTongkuan5XiukouItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) DKYTitleInputView *lengthView;

@property (nonatomic, weak) UIButton *optionsBtn;

@property (nonatomic, weak) UITextField *textField;

@end

@implementation DKYTongkuan5XiukouItemView

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
//    [self clear];
    if(madeInfoByProductName == nil)  return;
    
    if(self.madeInfoByProductName.productMadeInfoView.xkccValue > 0){
        self.lengthView.textField.text = self.madeInfoByProductName.productMadeInfoView.xkccValue;
    }
    
    if(self.madeInfoByProductName.productMadeInfoView.mDimNew32Id > 0){
        for (DKYDimlistItemModel *model in self.customOrderDimList.DIMFLAG_NEW32) {
            if([model.ID integerValue] == self.madeInfoByProductName.productMadeInfoView.mDimNew32Id){
                [self.optionsBtn setTitle:model.attribname forState:UIControlStateNormal];
                break;
            }
        }
    }
    
    self.textField.text = self.madeInfoByProductName.productMadeInfoView.xkRemark;
    
//    if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 57 ||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 355||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 56||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 58||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 59||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 65||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 369||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 64||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 63||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 62||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 68||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 307||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 308||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 309||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 61||
//       ((madeInfoByProductName.productMadeInfoView.mDimNew13Id == 364||
//         madeInfoByProductName.productMadeInfoView.mDimNew13Id == 365)&&
//        madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367)){
//           self.canEdit = NO;
//       }else{
//           self.canEdit = YES;
//
//           self.textField.enabled = NO;
//           if(madeInfoByProductName.productMadeInfoView.mDimNew32Id == 148){
//               self.textField.enabled = YES;
//           }
//       }
}

- (void)dealwithMDimNew12IdSelected{
//    if([self.addProductApproveParameter.mDimNew12Id integerValue] == 57||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 355||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 56||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 58||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 59||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 65||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 369||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 64||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 63||
//       [self.addProductApproveParameter.mDimNew12Id integerValue]== 62||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 68||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 307||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 308||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 309||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 61||
//       (([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
//         [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
//        ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
//         [self.addProductApproveParameter.mDimNew12Id integerValue] == 368))){
//            self.canEdit = NO;
//        }else{
//            self.canEdit = YES;
//
//            self.textField.enabled = NO;
//            if([self.addProductApproveParameter.mDimNew32Id integerValue] == 148){
//                self.textField.enabled = YES;
//            }
//        }
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    
    self.lengthView.textField.text = nil;
    [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    self.textField.text = nil;
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    
    self.lengthView.textField.enabled = canEdit;
    self.optionsBtn.enabled = canEdit;
    self.textField.enabled = canEdit;
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
    
    NSArray *models = self.customOrderDimList.DIMFLAG_NEW32;
    
    if(self.madeInfoByProductName){
        models = self.madeInfoByProductName.productCusmptcateView.xkShow;
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
    models = self.customOrderDimList.DIMFLAG_NEW32;
    
    if(self.madeInfoByProductName){
        models = self.madeInfoByProductName.productCusmptcateView.xkShow;
    }
    
    // 清除
    if(index == 0){
        self.addProductApproveParameter.mDimNew32Id = nil;
        [self dealwithmDimNew32IdSelected];
        return;
    }
    
    DKYDimlistItemModel *model = [models objectOrNilAtIndex:index - 1];
    self.addProductApproveParameter.mDimNew32Id = @([model.ID integerValue]);
    [self dealwithmDimNew32IdSelected];
}

- (void)dealwithmDimNew32IdSelected{
    //self.textField.enabled = [self.addProductApproveParameter.pdt isNotBlank] ? NO : YES;
    
//    if([self.addProductApproveParameter.mDimNew32Id integerValue] == 148){
//        self.textField.enabled = YES;
//    }
}

- (void)dealwithMDimNew13IdSelected{
    if(([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
        [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
       ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
        [self.addProductApproveParameter.mDimNew12Id integerValue] == 368)){
//           self.canEdit = NO;
       }else{
           [self dealwithmDimNew32IdSelected];
       }
}

- (void)textFieldEditingChanged:(UITextField *)textField{
    if(textField.text.length > 4){
        textField.text = [textField.text substringToIndex:4];
    }
    
    self.addProductApproveParameter.qtxkValue = textField.text;
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    [self setupLengthView];
    
    [self setupOptionsBtn];
    [self setupTextField];
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
        
        make.left.mas_equalTo(weakSelf.lengthView.mas_right).with.offset(37);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.optionsBtn = btn;
    [btn setTitle:@"点击选择袖口" forState:UIControlStateNormal];
    btn.originalTitle = btn.currentTitle;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupLengthView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.lengthView = view;
    
    WeakSelf(weakSelf);
    [self.lengthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.titleLabel);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        weakSelf.addProductApproveParameter.xkccValue = @([textField.text doubleValue]);
    };
    self.lengthView.itemModel = itemModel;
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
    
    [self.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    WeakSelf(weakSelf);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(37);
        make.top.mas_equalTo(weakSelf.titleLabel);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
}

@end
