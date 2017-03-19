//
//  DKYCustomOrderXiuBianItemView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/19.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderXiuBianItemView.h"

@interface DKYCustomOrderXiuBianItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

// 袖边
@property (nonatomic, weak) UIButton *optionsBtn;
@property (nonatomic, weak) DKYTitleInputView *unknowniew;

@property (nonatomic, weak) UIButton *xbzzBtn;
@property (nonatomic, weak) UITextField *textField;

@end

@implementation DKYCustomOrderXiuBianItemView

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
    
    if(madeInfoByProductName == nil)  return;

    self.textField.hidden = (madeInfoByProductName.productMadeInfoView.mDimNew46Id != 397);
    
    if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 19 ||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 366 ||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 53||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 54||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 55||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 65||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 369||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 64||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 63||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 62||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 60||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 68||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 307||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 308||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 309||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 61||
       ((madeInfoByProductName.productMadeInfoView.mDimNew13Id == 364||
         madeInfoByProductName.productMadeInfoView.mDimNew13Id == 365)&&
        madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367)){
        self.canEdit = NO;
    }else{
        self.canEdit = YES;
    }
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    self.unknowniew.textField.text = nil;
    [self.xbzzBtn setTitle:self.xbzzBtn.originalTitle forState:UIControlStateNormal];
    self.textField.text = nil;
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    
    self.optionsBtn.enabled = canEdit;
    self.unknowniew.textField.enabled = canEdit;
    
    self.xbzzBtn.enabled = canEdit;
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
    NSArray *models = nil;
    
    switch (sender.tag) {
        case 0:
            models = self.customOrderDimList.DIMFLAG_NEW45;
            break;
        case 1:
            models = self.customOrderDimList.DIMFLAG_NEW46;
            break;
    }
    
    for (DKYDimlistItemModel *model in models) {
        [item addObject:model.attribname];
    }
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:sender.extraInfo
                                             cancelButtonTitle:kDeleteTitle
                                                       clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
                                                           DLog(@"buttonIndex = %@ clicked",@(buttonIndex));
                                                           if(buttonIndex != 0){
                                                               [sender setTitle:[item objectOrNilAtIndex:buttonIndex - 1] forState:UIControlStateNormal];
                                                           }else{
                                                               [sender setTitle:sender.originalTitle forState:UIControlStateNormal];
                                                           }
                                                       }
                                         otherButtonTitleArray:item];
    actionSheet.scrolling = item.count > 10;
    actionSheet.visibleButtonCount = 10;
    actionSheet.destructiveButtonIndexSet = [NSSet setWithObjects:@0, nil];
    [actionSheet show];
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    [self setupOptionsBtn];
    [self setupXcView];
    [self setupXbzzBtn];
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
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.optionsBtn = btn;
    [btn setTitle:@"点击选择袖边" forState:UIControlStateNormal];
    btn.tag = 0;
    btn.originalTitle = [btn currentTitle];
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupXcView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.unknowniew = view;
    
    WeakSelf(weakSelf);
    [self.unknowniew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.titleLabel);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"";
    itemModel.subText = @"cm";
    self.unknowniew.itemModel = itemModel;
}

- (void)setupXbzzBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.unknowniew.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.xbzzBtn = btn;
    [btn setTitle:@"点击选择袖边组织" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 1;
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
    
    WeakSelf(weakSelf);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.xbzzBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.top.mas_equalTo(weakSelf);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
}

@end
