//
//  DKYDisplayCategoryDahuoViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayCategoryDahuoViewCell.h"
#import "DKYGetProductListByGroupNoModel.h"
#import "DKYDahuoOrderColorModel.h"
#import "DKYSizeViewListItemModel.h"

@interface DKYDisplayCategoryDahuoViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *colorBtn;
@property (weak, nonatomic) IBOutlet UIButton *sizeBtn;
@property (weak, nonatomic) IBOutlet UIButton *lengthBtn;
@property (weak, nonatomic) IBOutlet QMUITextField *xcTextField;
@property (weak, nonatomic) IBOutlet QMUITextField *amountTextField;
@property (weak, nonatomic) IBOutlet QMUITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@end

@implementation DKYDisplayCategoryDahuoViewCell

+ (instancetype)displayCategoryDahuoViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYDisplayCategoryDahuoViewCell";
    DKYDisplayCategoryDahuoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DKYDisplayCategoryDahuoViewCell class]) owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self commonInit];
}

- (void)setGetProductListByGroupNoModel:(DKYGetProductListByGroupNoModel *)getProductListByGroupNoModel{
    _getProductListByGroupNoModel = getProductListByGroupNoModel;
    
    self.titleLabel.text = getProductListByGroupNoModel.productName;
}

#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    
}

#pragma mark - private method
- (void)showOptionsPicker:(UIButton *)sender{
    [self.superview endEditing:YES];
    
    NSMutableArray *item = @[].mutableCopy;
    
    switch (sender.tag) {
        case 0:{
            
        }
            break;
        case 1:{
            for (DKYDahuoOrderColorModel *model in self.getProductListByGroupNoModel.colorViewList) {
                [item addObject:model.colorName];
            }
        }
            break;
        case 2:{
            for (DKYSizeViewListItemModel *model in self.getProductListByGroupNoModel.sizeViewList) {
                [item addObject:model.sizeName];
            }
        }
            break;
        case 3:{
            
        }
            break;
        default:
            break;
    }
    
    WeakSelf(weakSelf);
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:sender.extraInfo
                                             cancelButtonTitle:kDeleteTitle
                                                       clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
                                                           DLog(@"buttonIndex = %@ clicked",@(buttonIndex));
                                                           if(buttonIndex != 0){
                                                               [sender setTitle:[item objectOrNilAtIndex:buttonIndex - 1] forState:UIControlStateNormal];
                                                           }else{
                                                               [sender setTitle:sender.originalTitle forState:UIControlStateNormal];
                                                           }
                                                           [weakSelf actionSheetSelected:sender.tag index:buttonIndex];
                                                       }
                                         otherButtonTitleArray:item];
    actionSheet.scrolling = item.count > 10;
    actionSheet.visibleButtonCount = 10;
    actionSheet.destructiveButtonIndexSet = [NSSet setWithObjects:@0, nil];
    [actionSheet show];
}

- (void)actionSheetSelected:(NSInteger)tag index:(NSInteger)index{
    
}




#pragma mark - UI

- (void)commonInit{
    WeakSelf(weakSelf);
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self p_customSunview:self.titleLabel];
    
    // 颜色
    [self p_customSunview:self.colorBtn];
    self.colorBtn.originalTitle = [self.colorBtn currentTitle];
    self.colorBtn.extraInfo = [self.colorBtn currentTitle];
    self.colorBtn.tag = 1;
    [self.colorBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf showOptionsPicker:weakSelf.colorBtn];
    }];
    
    // 尺寸
    [self p_customSunview:self.sizeBtn];
    self.sizeBtn.originalTitle = [self.sizeBtn currentTitle];
    self.sizeBtn.extraInfo = [self.sizeBtn currentTitle];
    self.sizeBtn.tag = 2;
    [self.sizeBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf showOptionsPicker:weakSelf.sizeBtn];
    }];

    [self p_customSunview:self.amountTextField];
    [self p_customSunview:self.moneyTextField];
    [self p_customSunview:self.collectBtn];
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
        textField.disabledBackground = [UIImage imageWithColor:[UIColor colorWithHex:0xF0F0F0]];
    }
}
@end
