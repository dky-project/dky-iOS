//
//  DKYDahuoPopupView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDahuoPopupView.h"
#import "KLCPopup.h"
#import "DKYTitleSelectView.h"
#import "DKYCustomOrderItemModel.h"
#import "DKYDimlistItemModel.h"
#import "DKYMadeInfoByProductNameModel.h"

@interface DKYDahuoPopupView ()

@property (nonatomic, weak) KLCPopup *popup;

// 标题
@property (nonatomic, weak) UILabel *titleLabel;

// 子标题
@property (nonatomic, weak) UILabel *subTitleLabel;

@property (nonatomic, weak) DKYTitleSelectView *selectView1;

@property (nonatomic, weak) DKYTitleSelectView *selectView2;

@property (nonatomic, weak) UIButton *confirmOrderBtn;

@property (nonatomic, weak) UIButton *cancelBtn;

@end

@implementation DKYDahuoPopupView

+ (instancetype)show{
    DKYDahuoPopupView *contentView = [[DKYDahuoPopupView alloc]initWithFrame:CGRectZero];
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeBounceInFromTop
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:NO
                               dismissOnContentTouch:NO];
    popup.dimmedMaskAlpha = 0.6;
    contentView.popup = popup;
    
    [popup show];
    return contentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)dismiss{
    [self.popup dismiss:YES];
}

#pragma mark - action method

- (void)confirmOrderBtnClicked:(UIButton*)sender{
    if(self.confirmBtnClicked){
        self.confirmBtnClicked(sender);
    }
    self.popup.dismissType = KLCPopupDismissTypeFadeOut;
    [self dismiss];
}

- (void)cancelBtnClicked:(UIButton*)sender{
    if(self.cancelBtnClicked){
        self.cancelBtnClicked(sender);
    }
    [self dismiss];
}

- (void)showOptionsPicker:(UIButton *)sender{
    [self.superview endEditing:YES];
    
    NSMutableArray *item = @[].mutableCopy;
    
    if(sender.tag == 0){
        for (DKYDahuoOrderSizeModel *model in self.madeInfoByProductNameModel.sizeViewList) {
            [item addObject:model.sizeName];
        }
    }else{
        for (DKYDahuoOrderColorModel *model in self.madeInfoByProductNameModel.colorViewList) {
            [item addObject:model.colorName];
        }
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
#pragma mark - UI
- (void)commonInit{
    self.bounds = CGRectMake(0, 0, 514, 300);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
    [self setupTitleLabel];
    [self setupSubTitleLabel];
    [self setupSelectView];
    [self setupActionBtn];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:label];
    self.titleLabel = label;
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf).with.offset(32);
        make.right.mas_equalTo(weakSelf);
    }];
    label.text = @"大货下单";
}

- (void)setupSubTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor colorWithHex:0x666666];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:label];
    self.subTitleLabel = label;
    WeakSelf(weakSelf);
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).with.offset(32);
        make.right.mas_equalTo(weakSelf);
    }];
    label.text = @"款号 16-A033";
}

- (void)setupSelectView{
    DKYTitleSelectView *view = [[DKYTitleSelectView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.selectView1 = view;
    
    WeakSelf(weakSelf);
    [self.selectView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.subTitleLabel.mas_bottom).with.offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"尺寸";
    itemModel.content = @"点击选择尺寸";
    self.selectView1.itemModel = itemModel;
    view.optionsBtn.tag = 0;
    view.optionsBtn.originalTitle = [view.optionsBtn currentTitle];
    if(itemModel.content.length > 2){
        view.optionsBtn.extraInfo = [itemModel.content substringFromIndex:2];
    }
    view.optionsBtnClicked = ^(UIButton *sender){
        [weakSelf showOptionsPicker:sender];
    };
    
    view = [[DKYTitleSelectView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.selectView2 = view;
    
    [self.selectView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.selectView1.mas_bottom).with.offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(weakSelf);
    }];
    
    itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"颜色";
    itemModel.content = @"点击选择颜色";
    self.selectView2.itemModel = itemModel;
    view.optionsBtn.tag = 1;
    view.optionsBtn.originalTitle = [view.optionsBtn currentTitle];
    if(itemModel.content.length > 2){
        view.optionsBtn.extraInfo = [itemModel.content substringFromIndex:2];
    }
    view.optionsBtnClicked = ^(UIButton *sender){
        [weakSelf showOptionsPicker:sender];
    };
}

- (void)setupActionBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Seven];
    [btn addTarget:self action:@selector(confirmOrderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.confirmOrderBtn = btn;
    [self.confirmOrderBtn setTitle:@"确认下单" forState:UIControlStateNormal];
    
    [self.confirmOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.left.mas_equalTo(weakSelf).with.offset(100);
        make.bottom.mas_equalTo(weakSelf).with.offset(-30);
    }];
    
    btn = [UIButton buttonWithCustomType:UIButtonCustomType_Seven];
    [self addSubview:btn];
    self.cancelBtn = btn;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakSelf.confirmOrderBtn);
        make.right.mas_equalTo(weakSelf).with.offset(-100);
        make.bottom.mas_equalTo(weakSelf.confirmOrderBtn);
    }];
}

@end
