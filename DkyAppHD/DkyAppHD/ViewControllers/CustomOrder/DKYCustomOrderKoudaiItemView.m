//
//  DKYCustomOrderKoudaiItemView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/21.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderKoudaiItemView.h"
#import "DKYCustomOrderTypeOneView.h"

@interface DKYCustomOrderKoudaiItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *biaodai;
@property (nonatomic, weak) UIButton *tiedai;
@property (nonatomic, weak) UIButton *wadai;
@property (nonatomic, weak) UIButton *zhijiedai;
@property (nonatomic, weak) UIButton *xiewadai;

@property (nonatomic, weak) UIButton *other;
@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, strong) NSMutableArray *options;

@end

@implementation DKYCustomOrderKoudaiItemView

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
    
    if(!madeInfoByProductName) return;
    
    for (UIButton *btn in self.options) {
        btn.selected = NO;
    }
    
    for (NSString *selected in madeInfoByProductName.productMadeInfoView.kdShow) {
        for (UIButton *btn in self.options) {
            if([[btn currentTitle] isEqualToString:selected]){
                [self checkBtnClicked:btn];
            }
        }
    }
    
    NSInteger mDimNew12Id = self.madeInfoByProductName.productMadeInfoView.mDimNew12Id;
    if(mDimNew12Id == 68 ||
       mDimNew12Id == 61 ||
       mDimNew12Id == 307 ||
       mDimNew12Id == 308 ||
       mDimNew12Id == 309||
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

- (void)fetchAddProductApproveInfo{
    NSMutableString *koudai = [[NSMutableString alloc] init];
    if(self.biaodai.selected){
        [koudai appendString:self.biaodai.currentTitle];
        [koudai appendString:@";"];
    }
    if(self.tiedai.selected){
        [koudai appendString:self.tiedai.currentTitle];
        [koudai appendString:@";"];
    }
    if(self.wadai.selected){
        [koudai appendString:self.wadai.currentTitle];
        [koudai appendString:@";"];
    }
    if(self.zhijiedai.selected){
        [koudai appendString:self.zhijiedai.currentTitle];
        [koudai appendString:@";"];
    }
    if(self.xiewadai.selected){
        [koudai appendString:self.xiewadai.currentTitle];
        [koudai appendString:@";"];
    }
    
    if(self.other.selected){
        [koudai appendString:self.textField.text];
    }
    
    if([koudai hasSuffix:@";"]){
        NSRange deleteRange = NSMakeRange(koudai.length - 1, 1);
        [koudai deleteCharactersInRange:deleteRange];
    }
    
    self.addProductApproveParameter.koud = [koudai copy];
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    for (UIButton *btn in self.options) {
        btn.selected = NO;
    }
    self.textField.text = nil;
    self.textField.enabled = NO;
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    
    self.textField.enabled = canEdit;
    for (UIButton *btn in self.options) {
        btn.enabled = canEdit;
    }
}

#pragma mark - action method
- (void)checkBtnClicked:(UIButton*)sender{
    if(!self.canEdit) return;
    
    // 判断sender是未选中的，则要检查有没有查过2个
    if(!sender.selected){
        NSInteger selectedCount = 0;
        for (UIButton *btn in self.options) {
            if(btn.selected){
                selectedCount += 1;
            }
            if(selectedCount >= 2){
                return;
            }
        }
    }
    sender.selected = !sender.selected;
    
    if(sender.tag == 1){
        self.textField.enabled = sender.selected;
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
    self.biaodai = btn;
    [btn setTitle:@"表袋" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.biaodai.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
        make.width.mas_equalTo(100);
    }];
    self.tiedai = btn;
    [btn setTitle:@"贴袋" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.tiedai.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
        make.width.mas_equalTo(100);
    }];
    self.wadai = btn;
    [btn setTitle:@"挖袋" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.wadai.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
        make.width.mas_equalTo(100);
    }];
    self.zhijiedai = btn;
    [btn setTitle:@"直挖袋" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.zhijiedai.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
        make.width.mas_equalTo(100);
    }];
    self.xiewadai = btn;
    [btn setTitle:@"斜挖袋" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.biaodai);
        make.width.mas_equalTo(100);
    }];
    self.other = btn;
    [btn setTitle:@"其它" forState:UIControlStateNormal];
    btn.tag  = 1;
    
    [self setupTextField];
    
    [self.options addObject:self.biaodai];
    [self.options addObject:self.tiedai];
    [self.options addObject:self.wadai];
    [self.options addObject:self.zhijiedai];
    [self.options addObject:self.xiewadai];
    [self.options addObject:self.other];
}

- (void)setupTextField{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self addSubview:textField];
    self.textField = textField;
    
    textField.layer.borderColor = [UIColor colorWithHex:0x666666].CGColor;
    textField.layer.borderWidth = 1;
    
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = [UIColor colorWithHex:0x333333];
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
    leftView.frame = CGRectMake(0, 0, 5, self.textField.mj_h);
    self.textField.leftView = leftView;
    
    textField.background = [UIImage imageWithColor:[UIColor clearColor]];
    textField.disabledBackground = [UIImage imageWithColor:[UIColor colorWithHex:0xF0F0F0]];
    
    WeakSelf(weakSelf);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.other.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
        make.top.mas_equalTo(weakSelf.other);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemButtnWdith * 2 + DKYCustomOrderItemButtnWMargin);
    }];
    textField.enabled = NO;
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor colorWithHex:0x999999],
                                 NSFontAttributeName : [UIFont systemFontOfSize:12],
                                 NSBaselineOffsetAttributeName : @-1};
    
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:kSelectCanEdit attributes:attributes];
}

#pragma mark - get & set method
- (NSMutableArray*)options{
    if(_options == nil){
        _options = [NSMutableArray array];
    }
    return _options;
}

@end
