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

@interface DKYCustomOrderPatternItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *optionsBtn;

// 钉
@property (nonatomic, weak) DKYTitleInputView *dingView;

// 扣
@property (nonatomic, weak) DKYTitleSelectView *kouView;

//门襟宽
@property (nonatomic, weak) DKYTitleInputView *mjkView;
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
        make.width.mas_equalTo(152);
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
        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(3.33);
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
        make.width.mas_equalTo(150);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"门襟宽:";
    itemModel.subText = @"cm";
    self.mjkView.itemModel = itemModel;
}

@end
