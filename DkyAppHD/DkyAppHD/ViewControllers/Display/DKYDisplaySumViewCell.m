//
//  DKYDisplaySumViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplaySumViewCell.h"
#import "DKYGetProductListByGroupNoModel.h"
#import "DKYDisplayCollectButton.h"

@interface DKYDisplaySumViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *ammountSumLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneySumLabel;
@property (weak, nonatomic) IBOutlet DKYDisplayCollectButton *collectBtn;

@end

@implementation DKYDisplaySumViewCell

+ (instancetype)displaySumViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYDisplaySumViewCell";
    DKYDisplaySumViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DKYDisplaySumViewCell class]) owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self commonInit];
}

- (void)setProductList:(NSArray *)productList{
    _productList = productList;
    
    [self updateSum];
    [self updateCollectStatus];
}

- (void)amuntTextFieldChanged:(NSNotification*)notification{
    [self updateSum];
}

- (void)oneCollectChanged:(NSNotification*)notification{
    [self updateCollectStatus];
}

- (void)updateSum{
    NSInteger sum = 0;
    double sumMoney = 0;
    for (DKYGetProductListByGroupNoModel *model in self.productList) {
        sum += model.sum;
        sumMoney += model.sum * [model.price doubleValue];
    }
    
    self.ammountSumLabel.text = (sum > 0) ? [NSString stringWithFormat:@"%@",@(sum)] : @"合计";

    NSString *sumMoneyText = [NSString formatRateStringWithRate:sumMoney];
    sumMoneyText = [NSString stringWithFormat:@"%@元",sumMoneyText];
    
    self.moneySumLabel.text = (sum > 0) ? sumMoneyText : @"合计";
}

- (void)updateCollectStatus{
    BOOL isAllCollect = NO;
    __block BOOL flag = NO;
    [self.productList enumerateObjectsUsingBlock:^(DKYGetProductListByGroupNoModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.isCollected == NO){
            *stop = YES;
            flag = YES;
        }
    }];
    
    isAllCollect = !flag;
    
    self.collectBtn.selected = isAllCollect;
}

#pragma mark - api
-(void)collectAll{
    [self.productList enumerateObjectsUsingBlock:^(DKYGetProductListByGroupNoModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isCollected = YES;
    }];
    
    self.collectBtn.selected = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDisplayAllCollectChangedNotification object:nil userInfo:nil];
}

- (void)cancleCollectAll{
    [self.productList enumerateObjectsUsingBlock:^(DKYGetProductListByGroupNoModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isCollected = NO;
    }];
    
    self.collectBtn.selected = NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kDisplayAllCollectChangedNotification object:nil userInfo:nil];
}

#pragma mark - UI

- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amuntTextFieldChanged:) name:kDisplayAmountChangedNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oneCollectChanged:) name:kDisplayOneCollectChangedNotification object:nil];
    
    [self p_customSunview:self.ammountSumLabel];
    [self p_customSunview:self.moneySumLabel];
    
    // 收藏
    [self p_customSunview:self.collectBtn];
    [self.collectBtn customButtonWithTypeEx:UIButtonCustomType_Thirteen];
    self.collectBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.collectBtn setTitle:@"全部收藏" forState:UIControlStateNormal];
    [self.collectBtn setTitle:@"全部取消收藏" forState:UIControlStateSelected];
    
    WeakSelf(weakSelf);
    [self.collectBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(weakSelf.collectBtn.selected){
            // 说明全部被收藏了，按钮此时是取消全部收藏
            [weakSelf cancleCollectAll];
        }else{
            [weakSelf collectAll];
        }
    }];
}

- (void)p_customSunview:(UIView*)view{
    view.qmui_borderPosition = QMUIBorderViewPositionTop | QMUIBorderViewPositionLeft | QMUIBorderViewPositionBottom | QMUIBorderViewPositionRight;
    view.qmui_borderWidth = 1;
    view.qmui_borderColor = [UIColor colorWithHex:0x686868];
    
    if([view isMemberOfClass:[UILabel class]]){
        UILabel *label = (UILabel*)view;
        label.adjustsFontSizeToFitWidth = YES;
    }
    
    if([view isMemberOfClass:[UIButton class]]){
        UIButton *btn = (UIButton*)view;
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    if([view isMemberOfClass:[QMUITextField class]]){
        QMUITextField *textField = (QMUITextField*)view;
        textField.textInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
