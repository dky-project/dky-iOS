//
//  DKYCustomOrderPatternItemView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderPatternItemView.h"
#import "DKYTitleInputView.h"
#import "DKYTitleSelectView.h"
#import "DKYTextFieldAndTextFieldView.h"

@interface DKYCustomOrderPatternItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

// 式样
@property (nonatomic, weak) UIButton *optionsBtn;

// 钉
@property (nonatomic, weak) DKYTitleInputView *dingView;

// 扣
@property (nonatomic, weak) DKYTitleSelectView *kouView;

//门襟宽
@property (nonatomic, weak) DKYTitleInputView *mjkView;

// 选择门襟1
@property (nonatomic, weak) UIButton *mjBtn1;

// 选择门襟2
@property (nonatomic, weak) UIButton *mjBtn2;

// # 输入框
@property (nonatomic, weak) DKYTextFieldAndTextFieldView *mjInputView;

// 带长
@property (nonatomic, weak) DKYTitleInputView *dcView;

// 加穗
@property (nonatomic, weak) UIButton *suiBtn;

// 裤类别
@property (nonatomic, weak) UIButton *klbBtn;

// 开口
@property (nonatomic, weak) UIButton *kkBtn;

// 加档
@property (nonatomic, weak) UIButton *jdBtn;

// 加档后面的输入框
@property (nonatomic, weak) DKYTitleInputView *jdInputView;

// 工艺袖长
@property (nonatomic, weak) DKYTitleInputView *gyxcView;

// 裙类别
@property (nonatomic, weak) UIButton *qlbBtn;

// 门襟长
@property (nonatomic, weak) DKYTitleInputView *mjcView;

// 挂件袖肥
@property (nonatomic, weak) UIButton *gjxfBtn;

// 收腰
@property (nonatomic, weak) UIButton *syBtn;

@end

@implementation DKYCustomOrderPatternItemView

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
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textFrame.size.width + 10);
    }];
}

- (void)setMadeInfoByProductName:(DKYMadeInfoByProductNameModel *)madeInfoByProductName{
    [super setMadeInfoByProductName:madeInfoByProductName];
    
    if(!madeInfoByProductName) return;
    
    if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 19 ||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 366||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 59||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 60||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 61){
        [self updateSubviewStatus:0 canEdit:NO];
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 57){
        [self updateSubviewStatus:1 canEdit:NO];
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 53){
        [self updateSubviewStatus:2 canEdit:NO];
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 54){
        [self updateSubviewStatus:3 canEdit:NO];
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 55){
        [self updateSubviewStatus:4 canEdit:NO];
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 355 ||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 56){
        [self updateSubviewStatus:5 canEdit:NO];
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 58){
        [self updateSubviewStatus:6 canEdit:NO];
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 65||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 369){
        [self updateSubviewStatus:7 canEdit:NO];
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 64){
        [self updateSubviewStatus:8 canEdit:NO];
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 63||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 68||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 307||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 308||
             madeInfoByProductName.productMadeInfoView.mDimNew12Id == 309){
        [self updateSubviewStatus:9 canEdit:NO];
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 62){
        [self updateSubviewStatus:10 canEdit:NO];
    }
    
    self.mjInputView.textField.enabled = NO;
    self.mjInputView.textFieldTwo.enabled = NO;
    
    if(madeInfoByProductName.productMadeInfoView.mDimNew7Id == 196||
       madeInfoByProductName.productMadeInfoView.mDimNew7Id == 189){
        self.mjInputView.textField.enabled = YES;
        self.mjInputView.textFieldTwo.enabled = NO;
    }else if(madeInfoByProductName.productMadeInfoView.mDimNew7Id == 198){
        self.mjInputView.textField.enabled = NO;
        self.mjInputView.textFieldTwo.enabled = YES;
    }
    
    if((madeInfoByProductName.productMadeInfoView.mDimNew13Id == 364||
        madeInfoByProductName.productMadeInfoView.mDimNew13Id == 365)&&
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367){
        [self updateSubviewStatus:11 canEdit:NO];
    }
}

- (void)clear{
    // 逻辑属性
    self.addProductApproveParameter.mDimNew18Id = nil;
    
    // UI 清空
    self.canEdit = YES;
    [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
    self.dingView.textField.text = nil;
    [self.kouView.optionsBtn setTitle:self.kouView.optionsBtn.originalTitle forState:UIControlStateNormal];
    self.mjkView.textField.text = nil;
    [self.mjBtn1 setTitle:self.mjBtn1.originalTitle forState:UIControlStateNormal];
    [self.mjBtn2 setTitle:self.mjBtn2.originalTitle forState:UIControlStateNormal];
    self.mjInputView.textField.text = nil;
    self.mjInputView.textFieldTwo.text = nil;
    self.dcView.textField.text = nil;
    [self.suiBtn setTitle:self.suiBtn.originalTitle forState:UIControlStateNormal];
    [self.klbBtn setTitle:self.klbBtn.originalTitle forState:UIControlStateNormal];
    [self.kkBtn setTitle:self.kkBtn.originalTitle forState:UIControlStateNormal];
    [self.jdBtn setTitle:self.jdBtn.originalTitle forState:UIControlStateNormal];
    self.jdInputView.textField.text = nil;
    self.gyxcView.textField.text = nil;
    [self.qlbBtn setTitle:self.qlbBtn.originalTitle forState:UIControlStateNormal];
    self.mjcView.textField.text = nil;
    [self.gjxfBtn setTitle:self.gjxfBtn.originalTitle forState:UIControlStateNormal];
    [self.syBtn setTitle:self.syBtn.originalTitle forState:UIControlStateNormal];
}

- (void)updateSubviewStatus:(NSInteger)type canEdit:(BOOL)canEdit{
    self.canEdit = YES;
    self.addProductApproveParameter.needGjxf = YES;
    switch (type) {
        case 0:{
            self.kouView.optionsBtn.enabled = canEdit;
            self.mjkView.textField.enabled = canEdit;
            
            self.mjBtn1.enabled = canEdit;
            self.mjBtn2.enabled = canEdit;
            
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.suiBtn.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.gyxcView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
        }
            break;
        case 1:
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.suiBtn.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.gyxcView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
            self.gjxfBtn.enabled = canEdit;
            self.addProductApproveParameter.needGjxf = canEdit;
            break;
        case 2:
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.suiBtn.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.gyxcView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
            break;
        case 3:
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.suiBtn.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.gyxcView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            break;
        case 4:
            self.kouView.optionsBtn.enabled = canEdit;
            self.mjkView.textField.enabled = canEdit;
            
            self.mjBtn1.enabled = canEdit;
            self.mjBtn2.enabled = canEdit;
            
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.suiBtn.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
            self.syBtn.enabled = canEdit;
            break;
        case 5:{
            self.kouView.optionsBtn.enabled = canEdit;
            self.mjkView.textField.enabled = canEdit;
            
            self.mjBtn1.enabled = canEdit;
            self.mjBtn2.enabled = canEdit;
            
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.suiBtn.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.gyxcView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
            self.gjxfBtn.enabled = canEdit;
            self.addProductApproveParameter.needGjxf = canEdit;
        }
            break;
        case 6:{
            self.kouView.optionsBtn.enabled = canEdit;
            self.mjkView.textField.enabled = canEdit;
            
            self.mjBtn1.enabled = canEdit;
            self.mjBtn2.enabled = canEdit;
            
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.suiBtn.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.gyxcView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
            self.gjxfBtn.enabled = canEdit;
            self.addProductApproveParameter.needGjxf = canEdit;
        }
            break;
        case 7:{
            self.kouView.optionsBtn.enabled = canEdit;
            self.mjkView.textField.enabled = canEdit;
            
            self.mjBtn1.enabled = canEdit;
            self.mjBtn2.enabled = canEdit;
            
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.gyxcView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
            self.gjxfBtn.enabled = canEdit;
            self.addProductApproveParameter.needGjxf = canEdit;
            self.syBtn.enabled = canEdit;
        }
            break;
        case 8:{
            self.kouView.optionsBtn.enabled = canEdit;
            self.mjkView.textField.enabled = canEdit;
            
            self.mjBtn1.enabled = canEdit;
            self.mjBtn2.enabled = canEdit;
            
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.suiBtn.enabled = canEdit;
            
            self.gyxcView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
            self.gjxfBtn.enabled = canEdit;
            self.addProductApproveParameter.needGjxf = canEdit;
            self.syBtn.enabled = canEdit;
        }
            break;
        case 9:{
            self.kouView.optionsBtn.enabled = canEdit;
            self.mjkView.textField.enabled = canEdit;
            
            self.mjBtn1.enabled = canEdit;
            self.mjBtn2.enabled = canEdit;
            
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.suiBtn.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.gyxcView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
            self.gjxfBtn.enabled = canEdit;
            self.addProductApproveParameter.needGjxf = canEdit;
            self.syBtn.enabled = canEdit;
        }
            break;
        case 10:{
            self.kouView.optionsBtn.enabled = canEdit;
            self.mjkView.textField.enabled = canEdit;
            
            self.mjBtn1.enabled = canEdit;
            self.mjBtn2.enabled = canEdit;
            
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.suiBtn.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.gyxcView.textField.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
            self.gjxfBtn.enabled = canEdit;
            self.addProductApproveParameter.needGjxf = canEdit;
            self.syBtn.enabled = canEdit;
        }
            break;
        case 11:{
            self.dingView.textField.enabled = canEdit;
            self.kouView.optionsBtn.enabled = canEdit;
            self.mjkView.textField.enabled = canEdit;
            
            self.mjBtn1.enabled = canEdit;
            self.mjBtn2.enabled = canEdit;
            
            self.mjInputView.textField.enabled = canEdit;
            self.mjInputView.textFieldTwo.enabled = canEdit;
            
            self.dcView.textField.enabled = canEdit;
            self.suiBtn.enabled = canEdit;
            self.klbBtn.enabled = canEdit;
            self.kkBtn.enabled = canEdit;
            self.jdBtn.enabled = canEdit;
            self.jdInputView.textField.enabled = canEdit;
            self.gyxcView.textField.enabled = canEdit;
            self.qlbBtn.enabled = canEdit;
            self.mjcView.textField.enabled = canEdit;
            self.gjxfBtn.enabled = canEdit;
            self.addProductApproveParameter.needGjxf = canEdit;
            self.syBtn.enabled = canEdit;
        }
            break;
        default:
            break;
    }
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    self.optionsBtn.enabled = canEdit;
    self.dingView.textField.enabled = canEdit;
    self.kouView.optionsBtn.enabled = canEdit;
    self.mjkView.textField.enabled = canEdit;
    self.mjBtn1.enabled = canEdit;
    self.mjBtn1.enabled = canEdit;
    self.mjInputView.textField.enabled = canEdit;
    self.mjInputView.textFieldTwo.enabled = canEdit;
    self.dcView.textField.enabled = canEdit;
    self.suiBtn.enabled = canEdit;
    self.klbBtn.enabled = canEdit;
    self.kkBtn.enabled = canEdit;
    self.jdBtn.enabled = canEdit;
    self.jdInputView.textField.enabled = canEdit;
    self.gyxcView.textField.enabled = canEdit;
    self.qlbBtn.enabled = canEdit;
    self.mjcView.textField.enabled = canEdit;
    self.gjxfBtn.enabled = canEdit;
    self.syBtn.enabled = canEdit;
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
            models = self.customOrderDimList.DIMFLAG_NEW12;
            break;
        case 1:
            models = self.customOrderDimList.DIMFLAG_NEW4;
            break;
        case 2:
            models = self.customOrderDimList.DIMFLAG_NEW6;
            break;
        case 3:
            models = self.customOrderDimList.DIMFLAG_NEW7;
            break;
        case 4:
            models = self.customOrderDimList.DIMFLAG_NEW37;
            break;
        case 5:
            models = self.customOrderDimList.DIMFLAG_NEW38;
            break;
        case 6:
            models = self.customOrderDimList.DIMFLAG_NEW39;
            break;
        case 7:
            models = self.customOrderDimList.DIMFLAG_NEW1;
            break;
        case 8:
            models = self.customOrderDimList.DIMFLAG_NEW3;
            break;
        case 9:
            models = self.customOrderDimList.DIMFLAG_NEW18;
            break;
        case 10:
            models = self.customOrderDimList.DIMFLAG_NEW19;
            break;
        default:
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
        case 0:
            // 清除
            if(index == 0){
                self.addProductApproveParameter.mDimNew12Id = nil;
                return;
            }
            
            models = self.customOrderDimList.DIMFLAG_NEW12;
            model = [models objectOrNilAtIndex:index - 1];
            self.addProductApproveParameter.mDimNew12Id = @([model.ID integerValue]);
            break;
        case 1:
            models = self.customOrderDimList.DIMFLAG_NEW4;
            break;
        case 2:
            models = self.customOrderDimList.DIMFLAG_NEW6;
            break;
        case 3:
            models = self.customOrderDimList.DIMFLAG_NEW7;
            break;
        case 4:
            models = self.customOrderDimList.DIMFLAG_NEW37;
            break;
        case 5:
            models = self.customOrderDimList.DIMFLAG_NEW38;
            break;
        case 6:
            models = self.customOrderDimList.DIMFLAG_NEW39;
            break;
        case 7:
            models = self.customOrderDimList.DIMFLAG_NEW1;
            break;
        case 8:
            models = self.customOrderDimList.DIMFLAG_NEW3;
            break;
        case 9:
            // 清除
            if(index == 0){
                self.addProductApproveParameter.mDimNew18Id = nil;
                return;
            }
            
            models = self.customOrderDimList.DIMFLAG_NEW18;
            model = [models objectOrNilAtIndex:index - 1];
            self.addProductApproveParameter.mDimNew18Id = @([model.ID integerValue]);
            break;
        case 10:
            models = self.customOrderDimList.DIMFLAG_NEW19;
            break;
        default:
            break;
    }
}

#pragma mark - mark
- (void)commonInit{
    // 第一行
    [self setupTitleLabel];
    [self setupOptionsBtn];
    
    [self setupDingView];
    [self setupKouView];
    [self setupMjkView];
    
    // 第二行
    [self setupMjBtn1];
    [self setupMjBtn2];
    [self setupMjInputView];
    
    // 第四行
    [self setupDcView];
    [self setupSuiBtn];
    [self setupKlbBtn];
    [self setupKkBtn];
    
    // 第五行
    [self setupJdBtn];
    [self setupJdInputView];
    [self setupGyxcView];
    [self setupQlbBtn];
    
    // 第六行
    [self setupMjcView];
    [self setupGjxfBtn];
    [self setupSyBtn];
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
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.optionsBtn = btn;
    [btn setTitle:@"点击选择式样" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 0;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupDingView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.dingView = view;
    
    WeakSelf(weakSelf);
    [self.dingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"钉";
    itemModel.subText = @"#";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    self.dingView.itemModel = itemModel;
}

- (void)setupKouView{
    DKYTitleSelectView *view = [[DKYTitleSelectView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.kouView = view;
    
    WeakSelf(weakSelf);
    [self.kouView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.dingView.mas_right).with.offset(6.5);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"扣";
    itemModel.content = @"点击选择钉扣";
    self.kouView.itemModel = itemModel;
    view.optionsBtn.tag = 1;
    view.optionsBtn.originalTitle = [view.optionsBtn currentTitle];
    if(itemModel.content.length > 2){
        view.optionsBtn.extraInfo = [itemModel.content substringFromIndex:2];
    }
    view.optionsBtnClicked = ^(UIButton *sender){
        [weakSelf showOptionsPicker:sender];
    };
}

- (void)setupMjkView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.mjkView = view;
    
    WeakSelf(weakSelf);
    [self.mjkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.kouView.mas_right).with.offset(6.5);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"门襟宽:";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    self.mjkView.itemModel = itemModel;
}

- (void)setupMjBtn1{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.optionsBtn);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.mjBtn1 = btn;
    [btn setTitle:@"点击选择门襟" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 2;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupMjBtn2{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.mjBtn1.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.mjBtn2 = btn;
    [btn setTitle:@"点击选择门襟组织" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 3;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupMjInputView{
    DKYTextFieldAndTextFieldView *view = [[DKYTextFieldAndTextFieldView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.mjInputView = view;
    
    WeakSelf(weakSelf);
    [self.mjInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.mjBtn2);
        
        make.left.mas_equalTo(weakSelf.mjBtn2.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.right.mas_equalTo(weakSelf.mjkView);
    }];
}

- (void)setupDcView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.dcView = view;
    
    WeakSelf(weakSelf);
    [self.dcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mjBtn1);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.mjBtn1.mas_bottom).with.offset(20);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"带长:";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    self.dcView.itemModel = itemModel;
}

- (void)setupSuiBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.dcView);
        
        make.left.mas_equalTo(weakSelf.dcView.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.suiBtn = btn;
    [btn setTitle:@"点击选择加穗" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 4;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupKlbBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.dcView);
        
        make.left.mas_equalTo(weakSelf.suiBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.klbBtn = btn;
    [btn setTitle:@"点击选择裤类别" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 5;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupKkBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.dcView);
        
        make.left.mas_equalTo(weakSelf.klbBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.kkBtn = btn;
    [btn setTitle:@"点击选择开口" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 6;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupJdBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.dcView.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.dcView);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.jdBtn = btn;
    [btn setTitle:@"点击选择加档" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 7;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupJdInputView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.jdInputView = view;
    
    WeakSelf(weakSelf);
    [self.jdInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.jdBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.jdBtn);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    self.jdInputView.itemModel = itemModel;
}

- (void)setupGyxcView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.gyxcView = view;
    
    WeakSelf(weakSelf);
    [self.gyxcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.jdInputView.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.jdBtn);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"工艺袖长:";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    self.gyxcView.itemModel = itemModel;
}

- (void)setupQlbBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.gyxcView.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.jdBtn);
    }];
    self.qlbBtn = btn;
    [btn setTitle:@"点击选择裙类别" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 8;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupMjcView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.mjcView = view;
    
    WeakSelf(weakSelf);
    [self.mjcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.optionsBtn);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.jdBtn.mas_bottom).with.offset(20);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"门襟长";
    itemModel.subText = @"cm";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    self.mjcView.itemModel = itemModel;
}

- (void)setupGjxfBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.mjcView.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.mjcView);
    }];
    self.gjxfBtn = btn;
    [btn setTitle:@"点击选挂件袖肥" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 9;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

- (void)setupSyBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.gjxfBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf.mjcView);
    }];
    self.syBtn = btn;
    [btn setTitle:@"点击选择收腰" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 10;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

@end
