//
//  DKYCustomOrderSpecialCraftItemView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/19.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderSpecialCraftItemView.h"

@interface DKYCustomOrderSpecialCraftItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *dazhe;

@property (nonatomic, weak) UIButton *dazhou;

@property (nonatomic, weak) UIButton *kaicha;

@property (nonatomic, weak) UIButton *caixiangjin;

@property (nonatomic, weak) UIButton *other;
@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, strong) NSMutableArray *options;

//@property (nonatomic, weak) BEMCheckBox *dazhe;

@end

@implementation DKYCustomOrderSpecialCraftItemView

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
    
    for (NSString *selected in madeInfoByProductName.productMadeInfoView.tsgyShow) {
        for (UIButton *btn in self.options) {
            if([[btn currentTitle] isEqualToString:selected]){
                [self checkBtnClicked:btn];
            }
        }
    }
    
    if((madeInfoByProductName.productMadeInfoView.mDimNew13Id == 364||
        madeInfoByProductName.productMadeInfoView.mDimNew13Id == 365)&&
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367){
        self.canEdit = NO;
    }else{
        self.canEdit = YES;
    }
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    
    for (UIButton *btn in self.options) {
        btn.enabled = canEdit;
    }
}


#pragma mark - action method
- (void)checkBtnClicked:(UIButton*)sender{
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
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).with.offset(10);
        make.width.mas_equalTo(100);
    }];
    self.dazhe = btn;
    [btn setTitle:@"打折" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.dazhe.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.dazhou = btn;
    [btn setTitle:@"打皱" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.dazhou.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.kaicha = btn;
    [btn setTitle:@"开叉" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.kaicha.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.caixiangjin = btn;
    [btn setTitle:@"踩橡筋" forState:UIControlStateNormal];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.dazhe);
        make.width.mas_equalTo(100);
    }];
    self.other = btn;
    [btn setTitle:@"其他" forState:UIControlStateNormal];
    btn.tag = 1;
    [self setupTextField];
    
    [self.options addObject:self.dazhe];
    [self.options addObject:self.dazhou];
    [self.options addObject:self.kaicha];
    [self.options addObject:self.caixiangjin];
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

//- (void)setupCheckBoxes{
////    BEMCheckBox *myCheckBox = [[BEMCheckBox alloc] initWithFrame:CGRectZero];
//    BEMCheckBox *myCheckBox = [[BEMCheckBox alloc] initWithFrame:CGRectMake(100, 0, 30, 30)];
//    [self addSubview:myCheckBox];
//    
//    self.dazhe = myCheckBox;
////    WeakSelf(weakSelf);
////    [self.dazhe mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).with.offset(30);
////        make.top.mas_equalTo(weakSelf);
////        make.bottom.mas_equalTo(weakSelf);
////        make.width.mas_equalTo(weakSelf.height);
////    }];
//}


@end
