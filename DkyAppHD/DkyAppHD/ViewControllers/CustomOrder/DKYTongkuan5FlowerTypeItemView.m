//
//  DKYTongkuan5FlowerTypeItemView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/12/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYTongkuan5FlowerTypeItemView.h"
#import "DKYCustomOrderTypeOneView.h"
#import "DKYMadeInfoByProductNameModel.h"

@interface DKYTongkuan5FlowerTypeItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *tiaohua;
@property (nonatomic, weak) DKYCustomOrderTypeOneView *oneView;
@property (nonatomic, weak) UIButton *fourchoufour;
@property (nonatomic, weak) UIButton *fivechoufive;

@property (nonatomic, weak) UIButton *jiaohua;
@property (nonatomic, weak) DKYCustomOrderTypeOneView *twoView;
@property (nonatomic, weak) UIButton *sixchousix;
@property (nonatomic, weak) UIButton *eightchoueight;

@property (nonatomic, weak) UIButton *choutiao;
@property (nonatomic, weak) DKYCustomOrderTypeOneView *threeView;
@property (nonatomic, weak) UIButton *tihua;
@property (nonatomic, weak) UIButton *pingban;


@property (nonatomic, weak) UIButton *kuzi;

@property (nonatomic, weak) UIButton *shuangsuo;
@property (nonatomic, weak) UIButton *jiase;
@property (nonatomic, weak) UIButton *fanzhen;
@property (nonatomic, weak) UIButton *yizhen;
@property (nonatomic, weak) UIButton *pangtiao;

@property (nonatomic, weak) UIButton *diannao;
@property (nonatomic, weak) UIButton *tianzhu;
@property (nonatomic, weak) UIButton *xuxiantihua;
@property (nonatomic, weak) UIButton *jubutihua;

@property (nonatomic, strong) NSMutableArray *options;

@end

@implementation DKYTongkuan5FlowerTypeItemView

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
    
    for (NSString *selected in madeInfoByProductName.productMadeInfoView.hxShow) {
        for (UIButton *btn in self.options) {
            if([[btn currentTitle] isEqualToString:selected]){
                [self checkBtnClickedDefault:btn];
            }
        }
    }
    
    self.threeView.textField.text = madeInfoByProductName.productMadeInfoView.ct;
    self.threeView.textField2.text = madeInfoByProductName.productMadeInfoView.ct1;
    
    if((madeInfoByProductName.productMadeInfoView.mDimNew13Id == 364||
        madeInfoByProductName.productMadeInfoView.mDimNew13Id == 365)&&
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367){
        self.canEdit = NO;
    }else{
        self.canEdit = YES;
    }
}

- (void)dealwithMDimNew12IdSelected{
    if(([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
        [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 367){
        self.canEdit = NO;
    }else{
        self.canEdit = YES;
    }
}

- (void)dealwithMDimNew13IdSelected{
    if(([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
        [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 367){
        self.canEdit = NO;
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

- (void)fetchAddProductApproveInfo{
    NSMutableString *huax = [[NSMutableString alloc] init];
    
    // 挑花
    if(self.tiaohua.selected){
        NSMutableString *tiaohua = [[NSMutableString alloc] initWithString:self.tiaohua.currentTitle];
        [tiaohua appendString:@"("];
        [tiaohua appendString:self.oneView.textField.text];
        [tiaohua appendString:@"-"];
        [tiaohua appendString:self.oneView.textField2.text];
        [tiaohua appendString:@")"];
        [huax appendString:tiaohua];
        [huax appendString:@";"];
    }
    
    if(self.fourchoufour.selected){
        [huax appendString:self.fourchoufour.currentTitle];
        [huax appendString:@";"];
    }
    
    if(self.fivechoufive.selected){
        [huax appendString:self.fivechoufive.currentTitle];
        [huax appendString:@";"];
    }
    
    // 绞花
    if(self.jiaohua.selected){
        NSMutableString *jiaohua = [[NSMutableString alloc] initWithString:self.jiaohua.currentTitle];
        [jiaohua appendString:@"("];
        [jiaohua appendString:self.twoView.textField.text];
        [jiaohua appendString:@"-"];
        [jiaohua appendString:self.twoView.textField2.text];
        [jiaohua appendString:@")"];
        [huax appendString:jiaohua];
        [huax appendString:@";"];
    }
    
    if(self.sixchousix.selected){
        [huax appendString:self.sixchousix.currentTitle];
        [huax appendString:@";"];
    }
    
    if(self.eightchoueight.selected){
        [huax appendString:self.eightchoueight.currentTitle];
        [huax appendString:@";"];
    }
    
    // 抽条
    if(self.choutiao.selected){
        NSMutableString *choutiao = [[NSMutableString alloc] initWithString:self.choutiao.currentTitle];
        [choutiao appendString:@"("];
        [choutiao appendString:self.threeView.textField.text];
        [choutiao appendString:@"-"];
        [choutiao appendString:self.threeView.textField2.text];
        [choutiao appendString:@")"];
        [huax appendString:choutiao];
        [huax appendString:@";"];
    }
    if(self.tihua.selected){
        [huax appendString:self.tihua.currentTitle];
        [huax appendString:@";"];
    }
    
    if(self.pingban.selected){
        [huax appendString:self.pingban.currentTitle];
        [huax appendString:@";"];
    }
    
    // 第四行
    if(self.kuzi.selected){
        [huax appendString:self.kuzi.currentTitle];
        [huax appendString:@";"];
    }
    if(self.shuangsuo.selected){
        [huax appendString:self.shuangsuo.currentTitle];
        [huax appendString:@";"];
    }
    if(self.jiase.selected){
        [huax appendString:self.jiase.currentTitle];
        [huax appendString:@";"];
    }
    if(self.fanzhen.selected){
        [huax appendString:self.fanzhen.currentTitle];
        [huax appendString:@";"];
    }
    if(self.yizhen.selected){
        [huax appendString:self.yizhen.currentTitle];
        [huax appendString:@";"];
    }
    
    // 第五行
    if(self.pangtiao.selected){
        [huax appendString:self.pangtiao.currentTitle];
        [huax appendString:@";"];
    }
    if(self.diannao.selected){
        [huax appendString:self.diannao.currentTitle];
        [huax appendString:@";"];
    }
    if(self.tianzhu.selected){
        [huax appendString:self.tianzhu.currentTitle];
        [huax appendString:@";"];
    }
    if(self.xuxiantihua.selected){
        [huax appendString:self.xuxiantihua.currentTitle];
        [huax appendString:@";"];
    }
    if(self.jubutihua.selected){
        [huax appendString:self.jubutihua.currentTitle];
    }
    
    if([huax hasSuffix:@";"]){
        NSRange deleteRange = NSMakeRange(huax.length - 1, 1);
        [huax deleteCharactersInRange:deleteRange];
    }
    
    self.addProductApproveParameter.huax = [huax copy];
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    
    for (UIButton *btn in self.options) {
        btn.enabled = canEdit;
    }
}

#pragma mark - action method
- (void)checkBtnClicked:(UIButton*)sender{
    // isHxAffix == Y,则不可编辑
    if(self.madeInfoByProductName && [self.madeInfoByProductName.productCusmptcateView.isHxAffix caseInsensitiveCompare:@"Y"] == NSOrderedSame) return;
    
    // 判断sender是未选中的，则要检查有没有查过3个
    if(!sender.selected){
        NSInteger selectedCount = 0;
        for (UIButton *btn in self.options) {
            if(btn.selected){
                selectedCount += 1;
            }
            if(selectedCount >= 3){
                return;
            }
        }
    }
    
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

- (void)checkBtnClickedDefault:(UIButton*)sender{
    // 判断sender是未选中的，则要检查有没有查过3个
    if(!sender.selected){
        NSInteger selectedCount = 0;
        for (UIButton *btn in self.options) {
            if(btn.selected){
                selectedCount += 1;
            }
            if(selectedCount >= 3){
                return;
            }
        }
    }
    
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
    self.tiaohua = btn;
    btn.tag = 1;
    [btn setTitle:@"挑花" forState:UIControlStateNormal];
    
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
    self.fourchoufour = btn;
    [btn setTitle:@"4抽4" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.fourchoufour.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.fivechoufive = btn;
    [btn setTitle:@"5抽5" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.tiaohua);
        make.width.mas_equalTo(100);
    }];
    self.jiaohua = btn;
    [btn setTitle:@"绞花" forState:UIControlStateNormal];
    btn.tag = 2;
    [self setupTwoView];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.twoView);
        
        make.left.mas_equalTo(weakSelf.twoView.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.sixchousix = btn;
    [btn setTitle:@"6抽6" forState:UIControlStateNormal];
    
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.twoView);
        
        make.left.mas_equalTo(weakSelf.sixchousix.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.eightchoueight = btn;
    [btn setTitle:@"8抽8" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.jiaohua.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.tiaohua);
        make.width.mas_equalTo(100);
    }];
    self.choutiao = btn;
    btn.tag = 3;
    [btn setTitle:@"抽条" forState:UIControlStateNormal];
    
    [self setupThreeView];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.choutiao);
        
        make.left.mas_equalTo(weakSelf.threeView.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.tihua = btn;
    [btn setTitle:@"提花" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.choutiao);
        
        make.left.mas_equalTo(weakSelf.tihua.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.pingban = btn;
    [btn setTitle:@"平板" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.choutiao.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.tiaohua);
        make.width.mas_equalTo(100);
    }];
    self.kuzi = btn;
    [btn setTitle:@"裤子" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.kuzi);
        
        make.left.mas_equalTo(weakSelf.tiaohua.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.shuangsuo = btn;
    [btn setTitle:@"双梭" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.kuzi);
        
        make.left.mas_equalTo(weakSelf.shuangsuo.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.jiase = btn;
    [btn setTitle:@"夹色" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.kuzi);
        
        make.left.mas_equalTo(weakSelf.jiase.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.fanzhen = btn;
    [btn setTitle:@"翻针" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.kuzi);
        make.top.mas_equalTo(weakSelf.shuangsuo);
        
        make.left.mas_equalTo(weakSelf.fanzhen.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.yizhen = btn;
    [btn setTitle:@"移针" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.kuzi.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.tiaohua);
        make.width.mas_equalTo(100);
    }];
    self.pangtiao = btn;
    [btn setTitle:@"胖条" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.pangtiao);
        
        make.left.mas_equalTo(weakSelf.pangtiao.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.diannao = btn;
    [btn setTitle:@"电脑" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.pangtiao);
        
        make.left.mas_equalTo(weakSelf.diannao.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.tianzhu = btn;
    [btn setTitle:@"天竺" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.pangtiao);
        
        make.left.mas_equalTo(weakSelf.tianzhu.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.xuxiantihua = btn;
    [btn setTitle:@"虚线提花" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.pangtiao);
        
        make.left.mas_equalTo(weakSelf.xuxiantihua.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.jubutihua = btn;
    [btn setTitle:@"局部提花" forState:UIControlStateNormal];
    
    [self.options addObject:self.tiaohua];
    [self.options addObject:self.fourchoufour];
    [self.options addObject:self.fivechoufive];
    [self.options addObject:self.jiaohua];
    [self.options addObject:self.sixchousix];
    [self.options addObject:self.eightchoueight];
    [self.options addObject:self.choutiao];
    [self.options addObject:self.tihua];
    [self.options addObject:self.pingban];
    [self.options addObject:self.kuzi];
    [self.options addObject:self.shuangsuo];
    [self.options addObject:self.jiase];
    [self.options addObject:self.fanzhen];
    [self.options addObject:self.yizhen];
    [self.options addObject:self.pangtiao];
    [self.options addObject:self.diannao];
    [self.options addObject:self.tianzhu];
    [self.options addObject:self.xuxiantihua];
    [self.options addObject:self.jubutihua];
}

- (void)setupOneView{
    DKYCustomOrderTypeOneView *view = [[DKYCustomOrderTypeOneView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.oneView = view;
    
    WeakSelf(weakSelf);
    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.tiaohua.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
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
        make.left.mas_equalTo(weakSelf.jiaohua.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemButtnWdith * 2 + DKYCustomOrderItemButtnWMargin);
        make.top.mas_equalTo(weakSelf.jiaohua);
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
        make.left.mas_equalTo(weakSelf.choutiao.mas_right).with.offset(DKYCustomOrderItemButtnWMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemButtnWdith * 2 + DKYCustomOrderItemButtnWMargin);
        make.top.mas_equalTo(weakSelf.choutiao);
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
