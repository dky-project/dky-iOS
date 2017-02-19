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

#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    //    if(self.optionsBtnClicked){
    //        self.optionsBtnClicked(sender,sender.tag);
    //    }
    [self showOptionsPicker];
}

#pragma mark - private method
- (void)showOptionsPicker{
    [self.superview endEditing:YES];
    MMPopupItemHandler block = ^(NSInteger index){
        DLog(@"++++++++ index = %ld",index);
    };
    
    NSArray *item = @[@"1",@"2",@"3",@"4",@"5"];
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:item.count + 1];
    for (NSString *str in item) {
        [items addObject:MMItemMake(str, MMItemTypeNormal, block)];
    }
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"选择式样"
                                                          items:[items copy]];
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [sheetView show];
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
    [btn setTitle:@"点击选择门襟" forState:UIControlStateNormal];
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
}

- (void)setupJdBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf.dcView.mas_bottom).with.offset(20);
        
        make.left.mas_equalTo(weakSelf.dcView).with.offset(DKYCustomOrderItemMargin);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.jdBtn = btn;
    [btn setTitle:@"点击选择加档" forState:UIControlStateNormal];
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
}

@end
