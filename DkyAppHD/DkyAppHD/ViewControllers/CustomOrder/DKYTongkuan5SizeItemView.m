//
//  DKYTongkuan5SizetemView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYTongkuan5SizeItemView.h"
#import "DKYTitleSelectView.h"
#import "DKYTitleInputView.h"

@interface DKYTongkuan5SizeItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) DKYTitleSelectView *bigView;

@property (nonatomic, weak) DKYTitleInputView *lengthView;

@end

@implementation DKYTongkuan5SizeItemView

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
    
    self.lengthView.textField.text = madeInfoByProductName.productMadeInfoView.ycValue;
    
    if([madeInfoByProductName.productMadeInfoView.xwValue isNotBlank]){
        [self.bigView.optionsBtn setTitle:madeInfoByProductName.productMadeInfoView.xwValue forState:UIControlStateNormal];
    }else{
        [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
    }
    
//    self.lengthView.textField.enabled = !([madeInfoByProductName.productCusmptcateView.isYcAffix caseInsensitiveCompare:@"Y"] == NSOrderedSame || ([madeInfoByProductName.productMadeInfoView.sizeType caseInsensitiveCompare:@"GD"] == NSOrderedSame && [madeInfoByProductName.productMadeInfoView.ycValue isNotBlank]));
    
//    if(madeInfoByProductName.productMadeInfoView.mDimNew22Id != 131 ||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id != 55 ||
//       (madeInfoByProductName.productMadeInfoView.mDimNew13Id == 20 &&
//        madeInfoByProductName.productMadeInfoView.mDimNew15Id == 36)){
//           [self.bigView.optionsBtn setTitle:madeInfoByProductName.productMadeInfoView.xwValue forState:UIControlStateNormal];
//       }else{
//           [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
//       }
//    
    
//    if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 54||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 53||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 19||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 55||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 60){
//        self.canEdit = NO;
//    }else{
//        self.canEdit = YES;
//    }
}

- (void)dealwithMDimNew22IdSelected{
    if([self.addProductApproveParameter.mDimNew22Id integerValue] != 131||
       [self.addProductApproveParameter.mDimNew12Id integerValue] != 55 ||
       ([self.addProductApproveParameter.mDimNew13Id integerValue] == 20 &&
        [self.addProductApproveParameter.mDimNew15Id integerValue] == 36)){
           if([self.madeInfoByProductName.productMadeInfoView.xwValue isNotBlank]){
               [self.bigView.optionsBtn setTitle:self.madeInfoByProductName.productMadeInfoView.xwValue forState:UIControlStateNormal];
           }else{
               [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
           }
       }else{
           [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
       }
}

- (void)dealwithMDimNew12IdSelected{
    if([self.addProductApproveParameter.mDimNew22Id integerValue] != 131||
       [self.addProductApproveParameter.mDimNew12Id integerValue] != 55 ||
       ([self.addProductApproveParameter.mDimNew13Id integerValue] == 20 &&
        [self.addProductApproveParameter.mDimNew15Id integerValue] == 36)){
           if([self.madeInfoByProductName.productMadeInfoView.xwValue isNotBlank]){
               [self.bigView.optionsBtn setTitle:self.madeInfoByProductName.productMadeInfoView.xwValue forState:UIControlStateNormal];
           }else{
               [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
           }
       }else {
           [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
           if([self.addProductApproveParameter.mDimNew12Id integerValue] == 54 ||
              [self.addProductApproveParameter.mDimNew12Id integerValue]== 53||
              [self.addProductApproveParameter.mDimNew12Id integerValue] == 19||
              [self.addProductApproveParameter.mDimNew12Id integerValue] == 60||
              [self.addProductApproveParameter.mDimNew12Id integerValue] == 55){
               self.canEdit = YES;
           }else{
               self.canEdit = NO;
           }
       }
}

- (void)dealwithMDimNew13IdSelected{
    if([self.addProductApproveParameter.mDimNew22Id integerValue] != 131||
       [self.addProductApproveParameter.mDimNew12Id integerValue] != 55 ||
       ([self.addProductApproveParameter.mDimNew13Id integerValue] == 20 &&
        [self.addProductApproveParameter.mDimNew15Id integerValue] == 36)){
           if([self.madeInfoByProductName.productMadeInfoView.xwValue isNotBlank]){
               [self.bigView.optionsBtn setTitle:self.madeInfoByProductName.productMadeInfoView.xwValue forState:UIControlStateNormal];
           }else{
               [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
           }
       }else{
           [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
       }
}

- (void)dealwithMDimNew15IdSelected{
    if([self.addProductApproveParameter.mDimNew22Id integerValue] != 131||
       [self.addProductApproveParameter.mDimNew12Id integerValue] != 55 ||
       ([self.addProductApproveParameter.mDimNew13Id integerValue] == 20 &&
        [self.addProductApproveParameter.mDimNew15Id integerValue] == 36)){
           if([self.madeInfoByProductName.productMadeInfoView.xwValue isNotBlank]){
               [self.bigView.optionsBtn setTitle:self.madeInfoByProductName.productMadeInfoView.xwValue forState:UIControlStateNormal];
           }else{
               [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
           }
       }else{
           [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
       }
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    [self.bigView.optionsBtn setTitle:self.bigView.optionsBtn.originalTitle forState:UIControlStateNormal];
    self.lengthView.textField.text = nil;
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    
    self.bigView.optionsBtn.enabled = canEdit;
    self.lengthView.textField.enabled = canEdit;
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
    models = self.madeInfoByProductName.productCusmptcateView.xwArrayList;
    [item addObjectsFromArray:models];
    
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
                                                           [weakSelf actionSheetSelected:0 index:buttonIndex];
                                                       }
                                         otherButtonTitleArray:item];
    actionSheet.scrolling = item.count > 10;
    actionSheet.visibleButtonCount = 10;
    actionSheet.destructiveButtonIndexSet = [NSSet setWithObjects:@0, nil];
    [actionSheet show];
}

- (void)actionSheetSelected:(NSInteger)tag index:(NSInteger)index{
    NSArray *models = nil;
    models = self.madeInfoByProductName.productCusmptcateView.xwArrayList;
    
    // 清除
    if(index == 0){
        self.addProductApproveParameter.xwValue = nil;
        return;
    }
    
    self.addProductApproveParameter.xwValue = [models objectOrNilAtIndex:index - 1];
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    
    [self setupBigView];
    [self setupLengthView];
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

- (void)setupBigView{
    DKYTitleSelectView *view = [[DKYTitleSelectView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.bigView = view;
    
    WeakSelf(weakSelf);
    [self.bigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(152);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"大";
    itemModel.content = @"点击选择大小";
    self.bigView.itemModel = itemModel;
    
    view.optionsBtn.tag = 1;
    view.optionsBtn.originalTitle = [view.optionsBtn currentTitle];
    if(itemModel.content.length > 2){
        view.optionsBtn.extraInfo = [itemModel.content substringFromIndex:2];
    }
    view.optionsBtnClicked = ^(UIButton *sender){
        [weakSelf showOptionsPicker:sender];
    };
    
}

- (void)setupLengthView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.lengthView = view;
    
    WeakSelf(weakSelf);
    [self.lengthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bigView.mas_right).with.offset(37);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(196);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"长";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        weakSelf.addProductApproveParameter.ycValue = textField.text;
    };
    self.lengthView.itemModel = itemModel;
}

@end
