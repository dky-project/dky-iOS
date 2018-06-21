//
//  DKYDisplayHeaderView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayHeaderView.h"
#import "DKYGetProductListByGroupNoParameter.h"

@interface DKYDisplayHeaderView ()

@property (nonatomic, weak) UITextField *groupNumberTextField;

@property (nonatomic, weak) UIButton *searchBtn;

@property (nonatomic, weak) UIButton *preBtn;

@property (nonatomic, weak) UIButton *nextBtn;

@property (nonatomic, weak) UILabel *groupNoLabel;

@end

@implementation DKYDisplayHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)clear{
    self.groupNumberTextField.text = nil;
    self.getProductListByGroupNoParameter.groupNo = nil;
}

- (void)setGroupNo:(NSString *)groupNo{
    _groupNo = [groupNo copy];
    
    self.groupNoLabel.text = [NSString stringWithFormat:@"搭配组：%@",groupNo];
}

#pragma mark - UI
- (void)commonInit{
//    [self setupGroupNumberTextField];
//    [self setupSearchBtn];
    
    [self setupPreBtn];
    [self setupNextBtn];
    [self setupGroupNoLabel];
}

- (void)setupGroupNumberTextField{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self addSubview:textField];
    self.groupNumberTextField = textField;
    
    textField.layer.borderColor = [UIColor colorWithHex:0x3C3362].CGColor;
    textField.layer.borderWidth = 1;
    
    textField.font = [UIFont systemFontOfSize:15];
    textField.textColor = [UIColor colorWithHex:0x666666];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.placeholder = @"请输入组号";
    
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor colorWithHex:0x999999],
                           NSFontAttributeName : [UIFont systemFontOfSize:12],
                           NSBaselineOffsetAttributeName : @(-1)};
    
    NSAttributedString *searchPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:dict];
    textField.attributedPlaceholder = searchPlaceholder;
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_search"]];
    textField.leftViewMode = UITextFieldViewModeAlways;
    searchImageView.frame = CGRectMake(0, 0, 41, 28);
    searchImageView.contentMode = UIViewContentModeCenter;
    textField.leftView = searchImageView;
    
    WeakSelf(weakSelf);
    [self.groupNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).with.offset(32);
        make.centerY.mas_equalTo(weakSelf);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(35);
    }];
}

- (void)setupSearchBtn{
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Twelve];
    [self addSubview:btn];
    self.searchBtn = btn;
    
    [btn setTitle:@"查询" forState:UIControlStateNormal];
    
    WeakSelf(weakSelf);
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 35));
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.groupNumberTextField.mas_right).with.offset(50);
    }];
    
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        weakSelf.getProductListByGroupNoParameter.groupNo = weakSelf.groupNumberTextField.text;
        if(weakSelf.searchBtnClicked){
            weakSelf.searchBtnClicked(nil);
        }
    }];
}

- (void)setupPreBtn{
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Twelve];
    [self addSubview:btn];
    self.preBtn = btn;
    
    [btn setTitle:@"上一组" forState:UIControlStateNormal];
    
    WeakSelf(weakSelf);
    [self.preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 35));
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf).with.offset(32);
        //        make.size.mas_equalTo(weakSelf.searchBtn);
//        make.left.mas_equalTo(weakSelf.searchBtn.mas_right).with.offset(50);
    }];
    
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.preBtnClicked){
            weakSelf.preBtnClicked(nil);
        }
    }];
}

- (void)setupNextBtn{
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Twelve];
    [self addSubview:btn];
    self.nextBtn = btn;
    
    [btn setTitle:@"下一组" forState:UIControlStateNormal];
    
    WeakSelf(weakSelf);
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakSelf.preBtn);
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.preBtn.mas_right).with.offset(50);
    }];
    
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.nextBtnClicked){
            weakSelf.nextBtnClicked(nil);
        }
    }];
}

- (void)setupGroupNoLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    self.groupNoLabel = label;
    
    WeakSelf(weakSelf);
    [self.groupNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.nextBtn.mas_right).with.offset(88);
    }];
}

@end
