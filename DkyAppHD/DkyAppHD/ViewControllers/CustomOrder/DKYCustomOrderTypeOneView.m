//
//  DKYCustomOrderTypeOneView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/19.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderTypeOneView.h"
#import "DKYCustomOrderItemModel.h"

@interface DKYCustomOrderTypeOneView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIView *line;

@property (nonatomic, weak) UILabel *subTextLabel;

@end

@implementation DKYCustomOrderTypeOneView

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
    self.textField2.keyboardType = itemModel.keyboardType;
    if(itemModel.placeholder.length > 0){
        NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor colorWithHex:0x999999],
                                     NSFontAttributeName : [UIFont systemFontOfSize:12],
                                     NSBaselineOffsetAttributeName : @-1};
        
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:itemModel.placeholder attributes:attributes];
    }
    
    if(itemModel.placeholder2.length > 0){
        NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor colorWithHex:0x999999],
                                     NSFontAttributeName : [UIFont systemFontOfSize:12],
                                     NSBaselineOffsetAttributeName : @-1};
        
        self.textField2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:itemModel.placeholder2 attributes:attributes];
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
        make.width.mas_equalTo(textFrame.size.width + 2);
    }];
    
    if(itemModel.subText.length > 0){
        textFrame = [itemModel.subText boundingRectWithSize:size
                                                    options:options
                                                 attributes:attributes
                                                    context:nil];
        self.subTextLabel.text = itemModel.subText;
        [self.subTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(textFrame.size.width + 2);
        }];
    }
    
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    [self setupSubTextLabel];
    [self setupLine];
    [self setupTextField];
    [self setupTextField2];
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
        make.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(40);
    }];
}

- (void)setupSubTextLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor colorWithHex:0x666666];
    label.textAlignment = NSTextAlignmentRight;
    
    [self addSubview:label];
    self.subTextLabel = label;
    WeakSelf(weakSelf);
    [self.subTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(0);
    }];
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
    
    WeakSelf(weakSelf);
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf.line.mas_left).with.offset(-4);
    }];
}

- (void)setupTextField2{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self addSubview:textField];
    self.textField2 = textField;
    
    textField.layer.borderColor = [UIColor colorWithHex:0x666666].CGColor;
    textField.layer.borderWidth = 1;
    
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = [UIColor colorWithHex:0x333333];
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
    leftView.frame = CGRectMake(0, 0, 5, self.textField.mj_h);
    self.textField2.leftView = leftView;
    
    WeakSelf(weakSelf);
    [self.textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.line.mas_right).with.offset(4);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf.subTextLabel.mas_left).with.offset(0);
    }];
}


- (void)setupLine{
    UIView *line = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:line];
    self.line = line;
    
    self.line.backgroundColor = [UIColor colorWithHex:0x666666];
    WeakSelf(weakSelf);
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(12);
        make.centerX.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf);
    }];
}


@end
