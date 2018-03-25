//
//  DKYFiltrateView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYFiltrateView.h"
#import "DKYFiltrateOptionView.h"
#import "DKYSexEnumModel.h"
#import "DKYBigClassEnumModel.h"
#import "NSString+Utility.h"
#import "DKYDimNewListModel.h"
#import "DKYSampleQueryParameter.h"

#define kOptionViewHeight       (120)
#define kOptionViewMargin       (14)

@interface DKYFiltrateView ()

@property (nonatomic, weak) UILabel *filterConditionLabel;

@property (nonatomic, weak) UIButton *oneKeyClearBtn;

@property (nonatomic, strong) NSMutableArray *optionViews;

@property (nonatomic, weak) UITextField *styleNumberTextField;

@property (nonatomic, weak) UIButton *recommendBtn;

@property (nonatomic, weak) UIButton *rankBtn;

@property (nonatomic, weak) UIButton *maijiaxiuBtn;

@end

@implementation DKYFiltrateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (NSString*)name{
    if([NSString isEmptyString:self.styleNumberTextField.text]){
        return nil;
    }
    return self.styleNumberTextField.text;
}

#pragma mark - action method

- (void)oneKeyClearBtnClicked:(UIButton*)sender{
    for (DKYFiltrateOptionView *op in self.optionViews) {
        op.selectedOption = @"";
    }
    self.styleNumberTextField.text = nil;
    self.sampleQueryParameter.mDimNew11Id = nil;
    self.sampleQueryParameter.mDimNew13Id = nil;
    self.sampleQueryParameter.mDimNew14Id = nil;
    self.sampleQueryParameter.mDimNew15Id = nil;
    self.sampleQueryParameter.mDimNew16Id = nil;
    self.sampleQueryParameter.mDimNew12Id = nil;
    self.sampleQueryParameter.mDimNew25Id = nil;
    self.sampleQueryParameter.mDimNew9Id = nil;
    self.sampleQueryParameter.mDim13Id = nil;
    self.sampleQueryParameter.mDim16Id = nil;
//    self.selectedBigClas = nil;
//    self.selectedSex = nil;
}

- (void)optionViewTaped:(DKYFiltrateOptionView*)optionView{
    WeakSelf(weakSelf);
    UIViewController *vc = [self viewController];
    
    NSArray *array = [self actionSheetArrays:optionView.tag];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [vc jxt_showActionSheetWithTitle:nil
                             message:optionView.title
                   appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                       for (NSString *op in array) {
                           alertMaker.addActionDefaultTitle(op);
                       }
                       alertMaker.addActionCancelTitle(@"cancel");
                   } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                       
                       if ([action.title isEqualToString:@"cancel"]) {
                           DLog(@"cancel");
                       }else{
                           [weakSelf actionSheetSelected:optionView.tag buttonIndex:buttonIndex];
                       }
                   } sourceView:optionView];
#pragma clang diagnostic pop
}

- (void)recommendBtnClicked:(UIButton*)sender{
    sender.selected = !sender.selected;
    self.sampleQueryParameter.isRecommend = sender.selected ? @"Y" : @"N";
}

- (void)rankBtnClicked:(UIButton*)sender{
    sender.selected = !sender.selected;
    self.sampleQueryParameter.isRank = sender.selected ? @"Y" : @"N";
}

- (void)maijiaxiuBtnClicked:(UIButton*)sender{
    sender.selected = !sender.selected;
    self.sampleQueryParameter.isBuy = sender.selected ? @"Y" : @"N";
}

#pragma mark - private method
// index 表示哪一组
// buttonIndex 组里哪一个被选中
- (void)actionSheetSelected:(NSInteger)index buttonIndex:(NSInteger)buttonIndex{
    NSArray *itemModels = nil;
    DKYDimNewListItemModel *model = nil;
    switch (index) {
        case 0:{
            itemModels = self.dimNewListModel.sexList;
            model = [itemModels objectOrNilAtIndex:buttonIndex];
            self.sampleQueryParameter.mDimNew13Id = model ? @(model.Id) : nil;
        }
            break;
        case 1:{
            itemModels = self.dimNewListModel.pinList;
            model = [itemModels objectOrNilAtIndex:buttonIndex];
            self.sampleQueryParameter.mDim16Id = model ? @(model.Id) : nil;
        }
            break;
        case 2:{
            itemModels = self.dimNewListModel.pzList;
            model = [itemModels objectOrNilAtIndex:buttonIndex];
            self.sampleQueryParameter.mDimNew14Id = model ? @(model.Id) : nil;
        }
            break;
        case 3:{
            itemModels = self.dimNewListModel.zzList;
            model = [itemModels objectOrNilAtIndex:buttonIndex];
            self.sampleQueryParameter.mDimNew15Id = model ? @(model.Id) : nil;
        }
            break;
        case 4:{
            itemModels = self.dimNewListModel.zxList;
            model = [itemModels objectOrNilAtIndex:buttonIndex];
            self.sampleQueryParameter.mDimNew16Id = model ? @(model.Id) : nil;
        }
            break;
        case 5:{
            itemModels = self.dimNewListModel.syList;
            model = [itemModels objectOrNilAtIndex:buttonIndex];
            self.sampleQueryParameter.mDimNew12Id = model ? @(model.Id) : nil;
        }
            break;
        case 6:{
            itemModels = self.dimNewListModel.lxList;
            model = [itemModels objectOrNilAtIndex:buttonIndex];
            self.sampleQueryParameter.mDimNew25Id = model ? @(model.Id) : nil;
        }
            break;
        case 7:{
            itemModels = self.dimNewListModel.xxList;
            model = [itemModels objectOrNilAtIndex:buttonIndex];
            self.sampleQueryParameter.mDimNew9Id = model ? @(model.Id) : nil;
        }
            break;
        case 8:{
            itemModels = self.dimNewListModel.yearList;
            model = [itemModels objectOrNilAtIndex:buttonIndex];
            self.sampleQueryParameter.mDim13Id = model ? @(model.Id) : nil;
        }
            break;
            
        default:
            break;
    }
    DKYFiltrateOptionView *optionView = [self.optionViews objectAtIndex:index];

    
    optionView.selectedOption = [[self actionSheetArrays:index] objectOrNilAtIndex:buttonIndex];
}

#pragma mark - help method
- (NSArray*)actionSheetArrays:(NSInteger)index{
    if(self.dimNewListModel == nil) return nil;
    
    NSArray *originArray = nil;
    switch (index) {
        case 0:
            originArray = self.dimNewListModel.sexList;
            break;
        case 1:
            originArray = self.dimNewListModel.pinList;
            break;
        case 2:
            originArray = self.dimNewListModel.pzList;
            break;
        case 3:
            originArray = self.dimNewListModel.zzList;
            break;
        case 4:
            originArray = self.dimNewListModel.zxList;
            break;
        case 5:
            originArray = self.dimNewListModel.syList;
            break;
        case 6:
            originArray = self.dimNewListModel.lxList;
            break;
        case 7:
            originArray = self.dimNewListModel.xxList;
            break;
        case 8:
            originArray = self.dimNewListModel.yearList;
            break;
        default:
            break;
    }
    NSMutableArray *options = [NSMutableArray arrayWithCapacity:originArray.count];
    for (DKYDimNewListItemModel *model in originArray) {
        [options addObject:model.attribname];
    }
    return options.copy;
}

#pragma mark - UI

- (void)commonInit{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    [self setupFilterConditionLabel];
    [self setupOneKeyClearBtn];
    
    [self setupOpentionView];
    
    [self setupStyleNumberTextField];
    
    //[self setupRecommendBtn];
    //[self setupRankBtn];
    [self setupMaijiaxiuBtn];
//    [self test];
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
//    self.filterConditionLabel.tw_x = 75;
//    self.filterConditionLabel.tw_y = 28;
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
//    btn.frame =  CGRectMake(512, 20, 171, 31);
}

- (void)setupOpentionView{
    WeakSelf(weakSelf);
    DKYFiltrateOptionView *opention1 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention1];
    [opention1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kOptionViewHeight, kOptionViewHeight));
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-165);
    }];
    opention1.title = @"性别";
    opention1.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention2 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention2];
    [opention2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kOptionViewHeight, kOptionViewHeight));
        make.left.mas_equalTo(opention1.mas_right).with.offset(kOptionViewMargin);
        make.bottom.mas_equalTo(opention1);
    }];
    opention2.title = @"品类";
    opention2.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention3 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention3];
    [opention3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kOptionViewHeight, kOptionViewHeight));
        make.left.mas_equalTo(opention2.mas_right).with.offset(kOptionViewMargin);
        make.bottom.mas_equalTo(opention1);
    }];
    opention3.title = @"品种";
    opention3.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention4 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention4];
    [opention4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kOptionViewHeight, kOptionViewHeight));
        make.left.mas_equalTo(opention3.mas_right).with.offset(kOptionViewMargin);
        make.bottom.mas_equalTo(opention1);
    }];
    opention4.title = @"组织";
    opention4.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention5 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention5];
    [opention5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kOptionViewHeight, kOptionViewHeight));
        make.left.mas_equalTo(opention4.mas_right).with.offset(kOptionViewMargin);
        make.bottom.mas_equalTo(opention1);
    }];
    opention5.title = @"针型";
    opention5.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention6 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention6];
    [opention6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kOptionViewHeight, kOptionViewHeight));
        make.left.mas_equalTo(opention1);
        make.top.mas_equalTo(opention1.mas_bottom).with.offset(20);
    }];
    opention6.title = @"式样";
    opention6.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention7 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention7];
    [opention7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kOptionViewHeight, kOptionViewHeight));
        make.left.mas_equalTo(opention6.mas_right).with.offset(kOptionViewMargin);
        make.top.mas_equalTo(opention6);
    }];
    opention7.title = @"领型";
    opention7.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention8 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention8];
    [opention8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kOptionViewHeight, kOptionViewHeight));
        make.left.mas_equalTo(opention7.mas_right).with.offset(kOptionViewMargin);
        make.top.mas_equalTo(opention6);
    }];
    opention8.title = @"袖型";
    opention8.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention9 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention9];
    [opention9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kOptionViewHeight, kOptionViewHeight));
        make.left.mas_equalTo(opention8.mas_right).with.offset(kOptionViewMargin);
        make.top.mas_equalTo(opention6);
    }];
    opention9.title = @"年份";
    opention9.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    [self.optionViews addObject:opention1];
    [self.optionViews addObject:opention2];
    [self.optionViews addObject:opention3];
    [self.optionViews addObject:opention4];
    [self.optionViews addObject:opention5];
    [self.optionViews addObject:opention6];
    [self.optionViews addObject:opention7];
    [self.optionViews addObject:opention8];
    [self.optionViews addObject:opention9];
    
    int i = 0;
    for (UIView *view in self.optionViews) {
        view.tag = i++;
    }
}
- (void)setupStyleNumberTextField{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self addSubview:textField];
    self.styleNumberTextField = textField;
    
    textField.layer.borderColor = [UIColor colorWithHex:0x3C3362].CGColor;
    textField.layer.borderWidth = 1;
    
    textField.font = [UIFont systemFontOfSize:15];
    textField.textColor = [UIColor colorWithHex:0x666666];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor whiteColor];
    
    textField.placeholder = @"请输入款号";
    
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
    
    UIView *view = [self.optionViews firstObject];
    UIView *rightView = [self.optionViews objectOrNilAtIndex:1];
    [self.styleNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view);
        make.bottom.mas_equalTo(view.mas_top).with.offset(-15);
        make.right.mas_equalTo(rightView);
        make.height.mas_equalTo(35);
    }];
}

- (void)setupRecommendBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(recommendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.styleNumberTextField);
        make.top.mas_equalTo(weakSelf.styleNumberTextField);
        
        make.left.mas_equalTo(weakSelf.styleNumberTextField.mas_right).with.offset(kOptionViewMargin);
        make.width.mas_equalTo(kOptionViewHeight);
    }];
    self.recommendBtn = btn;
    [btn setTitle:@"推荐" forState:UIControlStateNormal];
}

- (void)setupRankBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(rankBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.styleNumberTextField);
        make.top.mas_equalTo(weakSelf.styleNumberTextField);
        
        make.left.mas_equalTo(weakSelf.recommendBtn.mas_right).with.offset(kOptionViewMargin);
        make.width.mas_equalTo(kOptionViewHeight);
    }];
    self.rankBtn = btn;
    [btn setTitle:@"销量排行" forState:UIControlStateNormal];
}

- (void)setupMaijiaxiuBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eigh];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(maijiaxiuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.styleNumberTextField);
        make.top.mas_equalTo(weakSelf.styleNumberTextField);
        
        make.left.mas_equalTo(weakSelf.styleNumberTextField.mas_right).with.offset(kOptionViewMargin);
        make.width.mas_equalTo(kOptionViewHeight);
    }];
    self.rankBtn = btn;
    [btn setTitle:@"买家秀" forState:UIControlStateNormal];
}

- (void)test{
    WeakSelf(weakSelf);
    DKYFiltrateOptionView *opention1 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention1];
    [opention1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(171, 171));
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-28);
    }];
    opention1.title = @"性别";
    opention1.selectedOption = @"全部";
    opention1.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
    DKYFiltrateOptionView *opention2 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
    [self addSubview:opention2];
    [opention2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(171, 171));
        make.left.mas_equalTo(opention1.mas_right).with.offset(70);
        make.bottom.mas_equalTo(opention1);
    }];
    opention2.title = @"原料";
    opention2.selectedOption = @"羊绒";
    opention2.optionViewTaped = ^(DKYFiltrateOptionView *view){
        [weakSelf optionViewTaped:view];
    };
    
//    DKYFiltrateOptionView *opention3 = [[DKYFiltrateOptionView alloc] initWithFrame:CGRectZero];
//    [self addSubview:opention3];
//    [opention3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(171, 171));
//        make.left.mas_equalTo(opention2.mas_right).with.offset(70);
//        make.bottom.mas_equalTo(opention1);
//    }];
//    opention3.title = @"式样";
//    opention3.selectedOption = @"DKY0082";
//    opention3.optionViewTaped = ^(DKYFiltrateOptionView *view){
//        [weakSelf optionViewTaped:view];
//    };
}

#pragma mark - get & set method

- (NSMutableArray*)optionViews{
    if(_optionViews == nil){
        _optionViews = [NSMutableArray array];
    }
    return _optionViews;
}

@end
