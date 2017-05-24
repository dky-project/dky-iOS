//
//  DKYCustomOrderTextFieldView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/16.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderTextFieldView.h"
#import "DKYCustomOrderItemModel.h"

@interface DKYCustomOrderTextFieldView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UITextField *textField;

@end

@implementation DKYCustomOrderTextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setItemModel:(DKYCustomOrderItemModel *)itemModel{
    _itemModel = itemModel;
    
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
    
    if(itemModel.textFieldDidEditing){
        [self.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    self.textField.enabled = itemModel.enabled;
    
    if(itemModel.zoomed){
        self.titleLabel.font = [UIFont systemFontOfSize:24];
        
        self.textField.font = [UIFont systemFontOfSize:30];
    }
}

- (void)clear{
    self.textField.text = nil;
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
    if(self.itemModel.textFieldDidEditing){
        self.itemModel.textFieldDidEditing(textField);
    }
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
