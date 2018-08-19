//
//  DKYRecommendFilterView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYRecommendFilterView.h"

#define kOptionViewHeight       (120)
#define kOptionViewMargin       (14)

@interface DKYRecommendFilterView ()

@property (nonatomic, weak) UILabel *filterConditionLabel;

@property (nonatomic, weak) UIButton *oneKeyClearBtn;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UITextField *thTextField;

@property (nonatomic, weak) UIButton *thBtn;

@end


@implementation DKYRecommendFilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (NSString*)name{
    if([NSString isEmptyString:self.textField.text]){
        return nil;
    }
    return self.textField.text;
}

#pragma mark - action method

- (void)oneKeyClearBtnClicked:(UIButton*)sender{
    self.textField.text = nil;
    self.hallName = nil;
    [self.thBtn setTitle:@"点击选择厅号" forState:UIControlStateNormal];
}

- (void)optionViewTaped:(UIButton*)btn{
    WeakSelf(weakSelf);
    if(self.thArrays == nil || self.thArrays.count == 0) {
        [DKYHUDTool showErrorWithStatus:@"获取厅号列表失败，请后台设置数据或者下拉数据刷新!"];
        return;
    }
    UIViewController *vc = [self viewController];
    
    NSArray *array = self.thArrays;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [vc jxt_showActionSheetWithTitle:nil
                             message:@"选择厅号"
                   appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                       for (NSString *op in array) {
                           if([op isKindOfClass:[NSString class]]){
                               alertMaker.addActionDefaultTitle(op);
                           }
                       }
                       alertMaker.addActionCancelTitle(@"cancel");
                   } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                       
                       if ([action.title isEqualToString:@"cancel"]) {
                           DLog(@"cancel");
                       }else{
                           [weakSelf actionSheetSelected:btn.tag buttonIndex:buttonIndex];
                       }
                   } sourceView:btn];
#pragma clang diagnostic pop
}

#pragma mark - private method
// index 表示哪一组
// buttonIndex 组里哪一个被选中
- (void)actionSheetSelected:(NSInteger)index buttonIndex:(NSInteger)buttonIndex{
    switch (index) {
        case 1:{
            self.hallName = [self.thArrays objectAtIndex:buttonIndex];
            [self.thBtn setTitle:self.hallName forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UI

- (void)commonInit{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    [self setupFilterConditionLabel];
    [self setupOneKeyClearBtn];
    [self setupTextField];
    [self setupThBtn];
    //[self setupThTextField];
}

- (void)setupFilterConditionLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor colorWithHex:0x3C3362];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:label];
    self.filterConditionLabel = label;
    
    label.text = @"筛选条件";
    [label sizeToFit];
    
    WeakSelf(weakSelf);
    [self.filterConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf).with.offset(28);
        make.left.mas_equalTo(weakSelf).with.offset(75);
    }];
}

- (void)setupOneKeyClearBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(oneKeyClearBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.oneKeyClearBtn = btn;
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setTitle:@"一键清除" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHex:0x333333] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor colorWithHex:0xE2E2E2].CGColor;
    
    WeakSelf(weakSelf);
    [self.oneKeyClearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(31);
        make.right.mas_equalTo(weakSelf).with.offset(-32);
        make.top.mas_equalTo(weakSelf).with.offset(20);
        make.width.mas_equalTo(171);
    }];
}

- (void)setupTextField{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self addSubview:textField];
    self.textField = textField;
    
    textField.layer.borderColor = [UIColor colorWithHex:0x3C3362].CGColor;
    textField.layer.borderWidth = 1;
    
    textField.font = [UIFont systemFontOfSize:15];
    textField.textColor = [UIColor colorWithHex:0x666666];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.placeholder = @"请输入杆号";
    
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
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.top.mas_equalTo(weakSelf.filterConditionLabel.mas_bottom).with.offset(8);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(254);
    }];
}

- (void)setupThBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    self.thBtn = btn;
    [self.thBtn customButtonWithTypeEx:UIButtonCustomType_Thirteen];
    self.thBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.thBtn.layer.borderColor = [UIColor colorWithHex:0x3C3362].CGColor;
    self.thBtn.layer.borderWidth = 1;
    self.thBtn.tag = 1;
    
    [self.thBtn setTitle:@"点击选择厅号" forState:UIControlStateNormal];
    [self.thBtn setTitleColor:[UIColor colorWithHex:0x3C3362] forState:UIControlStateNormal];
    self.thBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.thBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf optionViewTaped:sender];
    }];
    

    [self.thBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.textField.mas_right).with.offset(30);
        make.top.mas_equalTo(weakSelf.filterConditionLabel.mas_bottom).with.offset(8);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(254);
    }];
}

- (void)setupThTextField{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self addSubview:textField];
    self.thTextField = textField;
    
    textField.layer.borderColor = [UIColor colorWithHex:0x3C3362].CGColor;
    textField.layer.borderWidth = 1;
    
    textField.font = [UIFont systemFontOfSize:15];
    textField.textColor = [UIColor colorWithHex:0x666666];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.placeholder = @"请输入厅号";
    
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
    [self.thTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.textField.mas_right).with.offset(30);
        make.top.mas_equalTo(weakSelf.filterConditionLabel.mas_bottom).with.offset(8);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(254);
    }];
}

@end
