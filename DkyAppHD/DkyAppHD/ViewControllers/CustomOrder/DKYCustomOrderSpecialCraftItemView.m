//
//  DKYCustomOrderSpecialCraftItemView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/19.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderSpecialCraftItemView.h"
#import "BEMCheckBox.h"

@interface DKYCustomOrderSpecialCraftItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *dazhe;

@property (nonatomic, weak) UIButton *dazhou;

@property (nonatomic, weak) UIButton *kaicha;

@property (nonatomic, weak) UIButton *caixiangjin;

@property (nonatomic, weak) UIButton *other;

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

#pragma mark - action method
- (void)checkBtnClicked:(UIButton*)sender{
    sender.selected = !sender.selected;
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
    label.textColor = [UIColor colorWithHex:0x333333];
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
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.caixiangjin.mas_right).with.offset(22.5);
        make.width.mas_equalTo(100);
    }];
    self.other = btn;
    [btn setTitle:@"其他" forState:UIControlStateNormal];
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