//
//  DKYMatchHeaderViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/2/7.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYMatchHeaderViewCell.h"

@interface DKYMatchHeaderViewCell()
@property (weak, nonatomic) IBOutlet UILabel *kuanhaoLabel;
@end

@implementation DKYMatchHeaderViewCell

+ (instancetype)matchHeaderViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYMatchHeaderViewCell";
    DKYMatchHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DKYMatchHeaderViewCell class]) owner:self options:nil].lastObject;
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self commonInit];
}

- (void)commonInit{
    //[self p_customSunview:self.kuanhaoLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for(UIView *view in self.contentView.subviews){
        if([view isMemberOfClass:[UILabel class]]){
            [self p_customSunview:view];
        }
    }
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
        textField.shouldResponseToProgrammaticallyTextChanges = NO;
    }
}

@end
