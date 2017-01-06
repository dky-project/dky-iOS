//
//  DKYSampleDetailTypeViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleDetailTypeViewCell.h"

@interface DKYSampleDetailTypeViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *sampleImageView;
@property (weak, nonatomic) IBOutlet UILabel *sampleTypeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *hintLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *designDescriptionLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *genderLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *allTypeLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *collarTypeLabel;

@end
@implementation DKYSampleDetailTypeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self commonInit];
}

+ (instancetype)sampleDetailTypeViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYSampleDetailTypeViewCell";
    DKYSampleDetailTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DKYSampleDetailTypeViewCell class]) owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setModel:(NSObject *)model{
    self.sampleImageView.image = [UIImage imageNamed:@"image1"];
    self.detailImageView.image = [UIImage imageNamed:@"image2"];
    
    NSString *name = @"款号：DKY0000";
    self.sampleTypeLabel.text = name;
    NSDictionary *dict = @{NSFontAttributeName : self.sampleTypeLabel.font,
                           NSForegroundColorAttributeName : self.sampleTypeLabel.textColor};
    NSMutableAttributedString *attrName = [[NSMutableAttributedString alloc] initWithString:name attributes:dict];
    NSRange range = [name rangeOfString:@"："];
    range = NSMakeRange(0, range.location);
    [attrName addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
    [attrName addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x606060] range:range];
    [attrName addAttribute:NSBaselineOffsetAttributeName value:@4 range:range];
    self.sampleTypeLabel.attributedText = attrName;
    
    [self.genderLabel setText:self.genderLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    [self.allTypeLabel setText:self.allTypeLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    [self.collarTypeLabel setText:self.collarTypeLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    [self.hintLabel setText:self.hintLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
//    DLog(@"self.designDescriptionLabel.text = %@",self.designDescriptionLabel.text)
    [self.designDescriptionLabel setText:self.designDescriptionLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
}

#pragma mark - private method
- (void)formatMutableAttributedString:(NSMutableAttributedString*)mutableAttributedString{
    NSRange range = [mutableAttributedString.string rangeOfString:@":"];
    if(range.location != NSNotFound){
        range = NSMakeRange(range.location + 1, mutableAttributedString.string.length - range.location - 1);
        [mutableAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor colorWithHex:0x666666].CGColor range:range];
    }
}

#pragma mark - UI

- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.hintLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    self.hintLabel.lineSpacing = 5.0;
    self.hintLabel.numberOfLines = 0;

    
    self.designDescriptionLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    self.designDescriptionLabel.lineSpacing = 5.0;
    self.designDescriptionLabel.numberOfLines = 0;
}

@end
