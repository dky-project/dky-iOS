//
//  DKYTongkuan5TangzhuItemView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/12/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYTongkuan5TangzhuItemView.h"
#import "DKYCustomOrderTypeOneView.h"

@interface DKYTongkuan5TangzhuItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *tangzhu;
@property (nonatomic, weak) DKYCustomOrderTypeOneView *oneView;

@property (nonatomic, weak) UIButton *xiuhua;
@property (nonatomic, weak) DKYCustomOrderTypeOneView *twoView;

@property (nonatomic, weak) UIButton *chuanzhu;
@property (nonatomic, weak) DKYCustomOrderTypeOneView *threeView;

@property (nonatomic, weak) UIButton *goubian;
@property (nonatomic, weak) UIButton *gongzhen;

@property (nonatomic, strong) NSMutableArray *options;

@end


@implementation DKYTongkuan5TangzhuItemView

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
    if(!madeInfoByProductName) return;
    
    for (UIButton *btn in self.options) {
        btn.selected = NO;
    }
    
    for (NSString *selected in madeInfoByProductName.productMadeInfoView.tzShow) {
        for (UIButton *btn in self.options) {
            if([[btn currentTitle] isEqualToString:selected]){
                [self checkBtnClickedAndSetRemark:btn];
            }
        }
    }
    
//    if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 64||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 62||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 68||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 307||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 308||
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 309||
//       ((madeInfoByProductName.productMadeInfoView.mDimNew13Id == 364||
//         madeInfoByProductName.productMadeInfoView.mDimNew13Id == 365)&&
//        madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367)){
//           self.canEdit = NO;
//       }else{
//           self.canEdit = YES;
//       }
}

- (void)fetchAddProductApproveInfo{
    NSMutableString *tangzhu = [[NSMutableString alloc] init];
    if(self.tangzhu.selected){
        NSMutableString *tz = [[NSMutableString alloc] initWithString:self.tangzhu.currentTitle];
        [tz appendString:@"("];
        [tz appendString:self.oneView.textField.text];
        [tz appendString:@"-"];
        [tz appendString:self.oneView.textField2.text];
        [tz appendString:@"#"];
        [tz appendString:@")"];
        
        [tangzhu appendString:tz];
        [tangzhu appendString:@";"];
    }
    if(self.goubian.selected){
        [tangzhu appendString:self.goubian.currentTitle];
        [tangzhu appendString:@";"];
    }
    if(self.gongzhen.selected){
        [tangzhu appendString:self.gongzhen.currentTitle];
        [tangzhu appendString:@";"];
    }
    
    if(self.xiuhua.selected){
        NSMutableString *xiuhua = [[NSMutableString alloc] initWithString:self.xiuhua.currentTitle];
        [xiuhua appendString:@"("];
        [xiuhua appendString:self.twoView.textField.text];
        [xiuhua appendString:@"-"];
        [xiuhua appendString:self.twoView.textField2.text];
        [xiuhua appendString:@"#"];
        [xiuhua appendString:@")"];
        
        [tangzhu appendString:xiuhua];
        [tangzhu appendString:@";"];
    }
    
    if(self.chuanzhu.selected){
        NSMutableString *chuanzhu = [[NSMutableString alloc] initWithString:self.chuanzhu.currentTitle];
        [chuanzhu appendString:@"("];
        [chuanzhu appendString:self.threeView.textField.text];
        [chuanzhu appendString:@"-"];
        [chuanzhu appendString:self.threeView.textField2.text];
        [chuanzhu appendString:@"#"];
        [chuanzhu appendString:@")"];
        
        [tangzhu appendString:chuanzhu];
        [tangzhu appendString:@";"];
    }
    
    if([tangzhu hasSuffix:@";"]){
        NSRange deleteRange = NSMakeRange(tangzhu.length - 1, 1);
        [tangzhu deleteCharactersInRange:deleteRange];
    }
    
    self.addProductApproveParameter.tangz = [tangzhu copy];
}

- (void)dealwithMDimNew12IdSelected{
//    if([self.addProductApproveParameter.mDimNew12Id integerValue] == 64||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 62||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 68||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 307||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 308||
//       [self.addProductApproveParameter.mDimNew12Id integerValue] == 309||
//       (([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
//         [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
//        ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
//         [self.addProductApproveParameter.mDimNew12Id integerValue] == 368))){
//            self.canEdit = NO;
//        }else{
//            self.canEdit = YES;
//        }
}

- (void)dealwithMDimNew13IdSelected{
    if(([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
        [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
       ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
        [self.addProductApproveParameter.mDimNew12Id integerValue] == 368)){
//           self.canEdit = NO;
       }else{
           [self dealwithMDimNew12IdSelected];
       }
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    for (UIButton *btn in self.options) {
        btn.selected = NO;
    }
    
    self.oneView.textField.enabled = NO;
    self.oneView.textField2.enabled = NO;
    self.oneView.textField.text = nil;
    self.oneView.textField2.text = nil;
    
    self.twoView.textField.enabled = NO;
    self.twoView.textField2.enabled = NO;
    self.twoView.textField.text = nil;
    self.twoView.textField2.text = nil;
    
    self.threeView.textField.enabled = NO;
    self.threeView.textField2.enabled = NO;
    self.threeView.textField.text = nil;
    self.threeView.textField2.text = nil;
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    
    for (UIButton *btn in self.options) {
        btn.enabled = canEdit;
    }
}


#pragma mark - action method
- (void)checkBtnClickedAndSetRemark:(UIButton*)sender{
    sender.selected = !sender.selected;
    
    switch (sender.tag) {
        case 1:
//            self.oneView.textField.enabled = sender.selected;
//            self.oneView.textField2.enabled = sender.selected;
            
            self.oneView.textField.text = self.madeInfoByProductName.productMadeInfoView.tzRemark;
            break;
        case 2:
//            self.twoView.textField.enabled = sender.selected;
//            self.twoView.textField2.enabled = sender.selected;
            
            self.twoView.textField.text = self.madeInfoByProductName.productMadeInfoView.tzRemark1;
            break;
        case 3:
//            self.threeView.textField.enabled = sender.selected;
//            self.threeView.textField2.enabled = sender.selected;
            
            self.threeView.textField.text = self.madeInfoByProductName.productMadeInfoView.tzRemark2;
            break;
        default:
            break;
    }
    
}

- (void)checkBtnClicked:(UIButton*)sender{
    sender.selected = !sender.selected;
    
    switch (sender.tag) {
        case 1:
            self.oneView.textField.enabled = sender.selected;
            self.oneView.textField2.enabled = sender.selected;
            break;
        case 2:
            self.twoView.textField.enabled = sender.selected;
            self.twoView.textField2.enabled = sender.selected;
            break;
        case 3:
            self.threeView.textField.enabled = sender.selected;
            self.threeView.textField2.enabled = sender.selected;
            break;
        default:
            break;
    }
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    [self setupCheckBtns];
    //    [self setupCheckBoxes];
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

- (void)setupCheckBtns{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).with.offset(28);
        make.width.mas_equalTo(100);
    }];
    self.tangzhu = btn;
    btn.tag = 1;
    [btn setTitle:@"烫珠" forState:UIControlStateNormal];
    [self setupOneView];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.oneView.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.goubian = btn;
    [btn setTitle:@"勾边" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.goubian.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.gongzhen = btn;
    [btn setTitle:@"工针" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.tangzhu.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.tangzhu);
        make.width.mas_equalTo(100);
    }];
    self.xiuhua = btn;
    btn.tag = 2;
    [btn setTitle:@"绣花" forState:UIControlStateNormal];
    [self setupTwoView];
    
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.xiuhua.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.xiuhua);
        make.width.mas_equalTo(100);
    }];
    self.chuanzhu = btn;
    [btn setTitle:@"串珠" forState:UIControlStateNormal];
    btn.tag = 3;
    [self setupThreeView];
    
    [self.options addObject:self.tangzhu];
    [self.options addObject:self.goubian];
    [self.options addObject:self.gongzhen];
    [self.options addObject:self.xiuhua];
    [self.options addObject:self.chuanzhu];
}

- (void)setupOneView{
    DKYCustomOrderTypeOneView *view = [[DKYCustomOrderTypeOneView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.oneView = view;
    
    WeakSelf(weakSelf);
    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.tangzhu.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemButtnWdith * 2 + DKYCustomOrderItemButtnWMargin);
        make.top.mas_equalTo(weakSelf.titleLabel);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"";
    itemModel.subText = @"#";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.placeholder = @"选中可编辑";
    itemModel.placeholder2 = @"选中可编辑";
    self.oneView.itemModel = itemModel;
    
    self.oneView.textField.enabled = NO;
    self.oneView.textField2.enabled = NO;
}

- (void)setupTwoView{
    DKYCustomOrderTypeOneView *view = [[DKYCustomOrderTypeOneView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.twoView = view;
    
    WeakSelf(weakSelf);
    [self.twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.xiuhua.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemButtnWdith * 2 + DKYCustomOrderItemButtnWMargin);
        make.top.mas_equalTo(weakSelf.xiuhua);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"";
    itemModel.subText = @"#";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.placeholder = @"选中可编辑";
    itemModel.placeholder2 = @"选中可编辑";
    self.twoView.itemModel = itemModel;
    
    self.twoView.textField.enabled = NO;
    self.twoView.textField2.enabled = NO;
}

- (void)setupThreeView{
    DKYCustomOrderTypeOneView *view = [[DKYCustomOrderTypeOneView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.threeView = view;
    
    WeakSelf(weakSelf);
    [self.threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.chuanzhu.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemButtnWdith * 2 + DKYCustomOrderItemButtnWMargin);
        make.top.mas_equalTo(weakSelf.chuanzhu);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"";
    itemModel.subText = @"#";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.placeholder = @"选中可编辑";
    itemModel.placeholder2 = @"选中可编辑";
    self.threeView.itemModel = itemModel;
    
    self.threeView.textField.enabled = NO;
    self.threeView.textField2.enabled = NO;
}

#pragma mark - get & set method
- (NSMutableArray*)options{
    if(_options == nil){
        _options = [NSMutableArray array];
    }
    return _options;
}


@end
