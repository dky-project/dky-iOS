//
//  DKYTongkuan5AddMarkItemView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/12/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYTongkuan5AddMarkItemView.h"

@interface DKYTongkuan5AddMarkItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UITextField *textField;

@end

@implementation DKYTongkuan5AddMarkItemView

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
    
    self.titleLabel.text = itemModel.title;
    self.textField.rightViewMode = itemModel.lock ? UITextFieldViewModeAlways : UITextFieldViewModeNever;
    self.textField.text = itemModel.content;
    self.textField.placeholder = itemModel.placeholder;
    self.textField.enabled = !itemModel.lock;
    self.textField.keyboardType = itemModel.keyboardType;
    
    if(itemModel.placeholder.length > 0){
        NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor colorWithHex:0x999999],
                                     NSFontAttributeName : [UIFont systemFontOfSize:12],
                                     NSBaselineOffsetAttributeName : @-1};
        
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:itemModel.placeholder attributes:attributes];
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
    
    if(itemModel.textFieldDidEndEditing){
        [self.textField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    }
}

- (void)setMadeInfoByProductName:(DKYMadeInfoByProductNameModel *)madeInfoByProductName{
    [super setMadeInfoByProductName:madeInfoByProductName];
//    [self clear];
    if(madeInfoByProductName == nil)  return;
    
    self.textField.text = madeInfoByProductName.productMadeInfoView.jzValue;
    
//    if((madeInfoByProductName.productMadeInfoView.mDimNew13Id == 364||
//        madeInfoByProductName.productMadeInfoView.mDimNew13Id == 365)&&
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367){
//        self.textField.enabled = NO;
//    }else{
//        self.textField.enabled = YES;
//    }
}

- (void)dealwithMDimNew12IdSelected{
//    if(([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
//        [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
//       ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
//        [self.addProductApproveParameter.mDimNew12Id integerValue] == 368)){
//           self.textField.enabled = NO;
//       }else{
//           self.textField.enabled = YES;
//       }
}

- (void)dealwithMDimNew13IdSelected{
//    if(([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
//        [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
//       ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
//        [self.addProductApproveParameter.mDimNew12Id integerValue] == 368)){
//           self.textField.enabled = NO;
//       }else{
//           self.textField.enabled = YES;
//       }
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    self.textField.text = nil;
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    self.textField.enabled = canEdit;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
    leftView.frame = CGRectMake(0, 0, 10, self.textField.mj_h);
    self.textField.leftView = leftView;
    
    if(self.textField.rightViewMode == UITextFieldViewModeAlways){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 9)];
        imageView.contentMode = UIViewContentModeLeft;
        imageView.image = [UIImage imageNamed:@"lock"];
        self.textField.rightView = imageView;
    }
}

#pragma mark - action method
- (void)textFieldDidEndEditing:(UITextField *)textField{
    DLog(@"textFieldDidEndEditing");
    if(self.itemModel.textFieldDidEndEditing){
        self.itemModel.textFieldDidEndEditing(textField);
    }
}

- (void)textFieldEditingChanged:(UITextField*)textField{
    // 限制20
    if(textField.text.length > 20){
        textField.text = [textField.text substringToIndex:20];
    }
    self.addProductApproveParameter.jzValue = textField.text;
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    
    [self setupTextField];
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
        make.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(40);
    }];
    
    label.adjustsFontSizeToFitWidth = YES;
    
    //    label.text = @"机构号:";
}

- (void)setupTextField{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self addSubview:textField];
    self.textField = textField;
    
    textField.layer.borderColor = [UIColor colorWithHex:0x666666].CGColor;
    textField.layer.borderWidth = 1;
    
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = [UIColor colorWithHex:0x333333];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.background = [UIImage imageWithColor:[UIColor clearColor]];
    textField.disabledBackground = [UIImage imageWithColor:[UIColor colorWithHex:0xF0F0F0]];
    
    [self.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    WeakSelf(weakSelf);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
    }];
    
    //    textField.text = @"99999";
}
@end
