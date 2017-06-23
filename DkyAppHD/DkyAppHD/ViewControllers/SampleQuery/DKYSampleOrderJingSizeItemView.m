//
//  DKYSampleOrderJingSizeItemView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleOrderJingSizeItemView.h"
#import "DKYTitleSelectView.h"
#import "DKYTitleInputView.h"

@interface DKYSampleOrderJingSizeItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) DKYTitleInputView *jxwView;

@property (nonatomic, weak) DKYTitleInputView *sjxcView;

@end

@implementation DKYSampleOrderJingSizeItemView

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
    
    self.sjxcView.textField.enabled = NO;
    
    if(!madeInfoByProductName) return;
    
    if(madeInfoByProductName.productMadeInfoView.mDimNew12Id == 54 ||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 53||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 19||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 60||
       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 55){
        self.canEdit = NO;
        
        if(madeInfoByProductName.productMadeInfoView.mDimNew22Id == 131){
            self.sjxcView.textField.enabled = YES;
        }
    }else{
        self.canEdit = YES;
    }
}

- (void)dealwithMDimNew12IdSelected{
    if([self.addProductApproveParameter.mDimNew12Id integerValue] == 54 ||
       [self.addProductApproveParameter.mDimNew12Id integerValue]== 53||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 19||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 60||
       [self.addProductApproveParameter.mDimNew12Id integerValue] == 55){
        self.canEdit = YES;
    }else{
        self.canEdit = NO;
    }
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    self.jxwView.textField.text = nil;
    self.sjxcView.textField.text = nil;
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    
    self.jxwView.textField.enabled = canEdit;
    self.sjxcView.textField.enabled = canEdit;
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    
    //    [self setupJxwView];
    [self setupSjxcView];
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

- (void)setupJxwView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.jxwView = view;
    
    WeakSelf(weakSelf);
    [self.jxwView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"净胸围";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        weakSelf.addProductApproveParameter.jxwValue = textField.text;
    };
    self.jxwView.itemModel = itemModel;
}

- (void)setupSjxcView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.sjxcView = view;
    
    WeakSelf(weakSelf);
    [self.sjxcView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(weakSelf.jxwView.mas_right).with.offset(37);
        //        make.height.mas_equalTo(weakSelf.titleLabel);
        //        make.width.mas_equalTo(196);
        //        make.top.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(176);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"工艺袖长";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.textFieldDidEditing = ^(UITextField *textField){
        weakSelf.addProductApproveParameter.hzxc1Value = [textField.text isNotBlank] ? @([textField.text doubleValue]) : nil;
    };
    self.sjxcView.itemModel = itemModel;
}

@end
