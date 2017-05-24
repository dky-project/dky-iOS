//
//  DKYSampleDetailTypeViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleDetailTypeViewCell.h"
#import "SDCycleScrollView.h"
#import "DKYSampleProductInfoModel.h"

@interface DKYSampleDetailTypeViewCell ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *sampleTypeLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *ganweiLabel;

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *hintLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *designDescriptionLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *genderLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *allTypeLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *collarTypeLabel;
@property (weak, nonatomic) IBOutlet UIView *placehlderView;

@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cycleScrollViewHeightCst;

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

- (void)setModel:(DKYSampleProductInfoModel *)model{
    _model = model;
    
    if(model == nil) return;
    
    self.cycleScrollView.imageURLStringsGroup = model.imgList;
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
//    UIImage *image1 = [UIImage imageNamed:@"sample_detai_image1"];
//    UIImage *image2 = [UIImage imageNamed:@"sample_detai_image2"];
//    UIImage *image3 = [UIImage imageNamed:@"sample_detai_image3"];
//    self.cycleScrollView.localizationImageNamesGroup = @[image1,image2,image3];
    
    NSString *name = [NSString stringWithFormat:@"款号：%@",model.name];
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
    
    self.genderLabel.text = [NSString stringWithFormat:@"性别 : %@",model.mDimNew13Text];
    [self.genderLabel setText:self.genderLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    self.allTypeLabel.text = [NSString stringWithFormat:@"所属类别 : %@",model.mptbelongtypeText];
    
    [self.allTypeLabel setText:self.allTypeLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    self.collarTypeLabel.text = [NSString stringWithFormat:@"领子 : %@",model.description4];
    
    [self.collarTypeLabel setText:self.collarTypeLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    self.hintLabel.text = [NSString stringWithFormat:@"温馨提示 : %@",model.description3];
    
    [self.hintLabel setText:self.hintLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    

    self.designDescriptionLabel.text = [NSString stringWithFormat:@"设计说明 : %@",model.description5];
    [self.designDescriptionLabel setText:self.designDescriptionLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DLog(@"---点击了第%ld张图片", (long)index);
}

//- (void)next:(UIBarButtonItem*)sender{
//    [self.bannerView scrollToNextPage];
//}
//
//- (void)prev:(UIBarButtonItem*)sender{
//    [self.bannerView scrollTopreviousPage];
//}

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
    
    self.cycleScrollViewHeightCst.constant = 880;
    
    [self setupBannerView];
}

- (void)setupBannerView{
//    self.bannerView.delegate = self;
//    self.bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
//    self.bannerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.bannerView.autoScroll = NO;
//    self.bannerView.localizationImageNamesGroup = imageNames;
    
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:NO imageNamesGroup:nil];
    
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    [self.placehlderView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.autoScroll = NO;
    cycleScrollView.backgroundColor = [UIColor whiteColor];
    self.cycleScrollView = cycleScrollView;
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

@end
