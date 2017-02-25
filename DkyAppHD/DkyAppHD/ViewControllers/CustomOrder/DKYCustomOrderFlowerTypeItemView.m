//
//  DKYCustomOrderFlowerTypeItemView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/20.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderFlowerTypeItemView.h"
#import "DKYCustomOrderTypeOneView.h"

@interface DKYCustomOrderFlowerTypeItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *tiaohua;
@property (nonatomic, weak) UIButton *jiaohua;
@property (nonatomic, weak) UIButton *fourchoufour;
@property (nonatomic, weak) UIButton *fivechoufive;
@property (nonatomic, weak) UIButton *sixchousix;

@property (nonatomic, weak) UIButton *eightchoueight;
@property (nonatomic, weak) UIButton *choutiao;
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

@end

@implementation DKYCustomOrderFlowerTypeItemView

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
    [btn setTitle:@"挑花" forState:UIControlStateNormal];
    
    
    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf);
//        
//        make.left.mas_equalTo(weakSelf.tiaohua.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.jiaohua = btn;
//    [btn setTitle:@"绞花" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf);
//        
//        make.left.mas_equalTo(weakSelf.jiaohua.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.fourchoufour = btn;
//    [btn setTitle:@"4抽4" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf);
//        
//        make.left.mas_equalTo(weakSelf.fourchoufour.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.fivechoufive = btn;
//    [btn setTitle:@"5抽5" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf);
//        
//        make.left.mas_equalTo(weakSelf.fivechoufive.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.sixchousix = btn;
//    [btn setTitle:@"6抽6" forState:UIControlStateNormal];
//    
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(20);
//        
//        make.left.mas_equalTo(weakSelf.tiaohua);
//        make.width.mas_equalTo(100);
//    }];
//    self.eightchoueight = btn;
//    [btn setTitle:@"8抽8" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.eightchoueight);
//        
//        make.left.mas_equalTo(weakSelf.eightchoueight.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.choutiao = btn;
//    [btn setTitle:@"抽条" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.eightchoueight);
//        
//        make.left.mas_equalTo(weakSelf.choutiao.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.tihua = btn;
//    [btn setTitle:@"提花" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.eightchoueight);
//        
//        make.left.mas_equalTo(weakSelf.tihua.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.pingban = btn;
//    [btn setTitle:@"平板" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.eightchoueight);
//        
//        make.left.mas_equalTo(weakSelf.pingban.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.kuzi = btn;
//    [btn setTitle:@"裤子" forState:UIControlStateNormal];
//    
//    
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.eightchoueight.mas_bottom).with.offset(20);
//        
//        make.left.mas_equalTo(weakSelf.tiaohua);
//        make.width.mas_equalTo(100);
//    }];
//    self.shuangsuo = btn;
//    [btn setTitle:@"双梭" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.shuangsuo);
//        
//        make.left.mas_equalTo(weakSelf.shuangsuo.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.jiase = btn;
//    [btn setTitle:@"夹色" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.shuangsuo);
//        
//        make.left.mas_equalTo(weakSelf.jiase.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.fanzhen = btn;
//    [btn setTitle:@"翻针" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.shuangsuo);
//        
//        make.left.mas_equalTo(weakSelf.fanzhen.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.yizhen = btn;
//    [btn setTitle:@"移针" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.shuangsuo);
//        
//        make.left.mas_equalTo(weakSelf.yizhen.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.pangtiao = btn;
//    [btn setTitle:@"胖条" forState:UIControlStateNormal];
//    
//    
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.shuangsuo.mas_bottom).with.offset(20);
//        
//        make.left.mas_equalTo(weakSelf.tiaohua);
//        make.width.mas_equalTo(100);
//    }];
//    self.diannao = btn;
//    [btn setTitle:@"电脑" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.diannao);
//        
//        make.left.mas_equalTo(weakSelf.diannao.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.tianzhu = btn;
//    [btn setTitle:@"天竺" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.diannao);
//        
//        make.left.mas_equalTo(weakSelf.tianzhu.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.xuxiantihua = btn;
//    [btn setTitle:@"虚线提花" forState:UIControlStateNormal];
//    
//    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
//    [self addSubview:btn];
//    [btn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.top.mas_equalTo(weakSelf.diannao);
//        
//        make.left.mas_equalTo(weakSelf.xuxiantihua.mas_right).with.offset(22.5);
//        make.width.mas_equalTo(100);
//    }];
//    self.jubutihua = btn;
//    [btn setTitle:@"局部提花" forState:UIControlStateNormal];
}

//- (void)setupOneView{
//    DKYCustomOrderTypeOneView *view = [[DKYCustomOrderTypeOneView alloc] initWithFrame:CGRectZero];
//    [self addSubview:view];
//    self.oneView = view;
//    
//    WeakSelf(weakSelf);
//    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(DKYCustomOrderItemMargin);
//        make.height.mas_equalTo(weakSelf.titleLabel);
//        make.width.mas_equalTo(DKYCustomOrderItemWidth * 2 + DKYCustomOrderItemMargin);
//        make.top.mas_equalTo(weakSelf.titleLabel);
//    }];
//    
//    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
//    itemModel.title = @"同";
//    itemModel.subText = @"cm";
//    itemModel.keyboardType = UIKeyboardTypeNumberPad;
//    self.oneView.itemModel = itemModel;
//}


@end
