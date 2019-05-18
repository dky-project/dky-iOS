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
#import "PYPhotoBrowser.h"

@interface DKYSampleDetailTypeViewCell ()<SDCycleScrollViewDelegate,PYPhotoBrowseViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *sampleTypeLabel;

@property (weak, nonatomic) IBOutlet TTTAttributedLabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIView *placehlderView;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *hintLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cycleScrollViewHeightCst;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *seriesLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *onSellTimeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeightCst;

@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;

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
    
    NSString *name = [NSString stringWithFormat:@"款号：%@     品类：%@",model.name, model.mDim16Text];
    self.sampleTypeLabel.text = name;
    NSDictionary *dict = @{NSFontAttributeName : self.sampleTypeLabel.font,
                           NSForegroundColorAttributeName : self.sampleTypeLabel.textColor};
    NSMutableAttributedString *attrName = [[NSMutableAttributedString alloc] initWithString:name attributes:dict];
    NSRange range = [name rangeOfString:@"："];
    range = NSMakeRange(0, range.location);
    [attrName addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
    [attrName addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x606060] range:range];
    [attrName addAttribute:NSBaselineOffsetAttributeName value:@4 range:range];
    
    range = [name rangeOfString:@"品类"];
    range = NSMakeRange(range.location, range.length);
    [attrName addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
    [attrName addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x606060] range:range];
    [attrName addAttribute:NSBaselineOffsetAttributeName value:@4 range:range];
    
    self.sampleTypeLabel.attributedText = attrName;
    
    self.genderLabel.text = [NSString stringWithFormat:@"性别 : %@",model.mDimNew13Text];
    [self.genderLabel setText:self.genderLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    // 系列
    self.seriesLabel.text = [NSString stringWithFormat:@"系列 : %@",model.mDim13Text];
    [self.seriesLabel setText:self.seriesLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    // 设计说明
    self.onSellTimeLabel.text = [NSString stringWithFormat:@"设计说明 : %@",model.description5];
    [self.onSellTimeLabel setText:self.onSellTimeLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    // 温馨提示
    self.hintLabel.text = [NSString stringWithFormat:@"定制温馨提示 : %@",model.description3];
    [self.hintLabel setText:self.hintLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DLog(@"---点击了第%ld张图片", (long)index);
    
    // 点击图片，显示图片浏览器
    
    // 1. 创建photoBroseView对象
    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
    
    // 2.1 设置图片源(UIImageView)数组
    photoBroseView.imagesURL = self.model.imgList;
    
    // 2.2 设置初始化图片下标（即当前点击第几张图片）
    photoBroseView.currentIndex = index;

    CGRect frameFormWindow = [cycleScrollView.superview convertRect:cycleScrollView.frame toView:[UIApplication sharedApplication].keyWindow];
    photoBroseView.frameFormWindow = frameFormWindow;
    photoBroseView.frameToWindow = frameFormWindow;
    
    // 不转屏
    photoBroseView.autoRotateImage = NO;
    
    // 动画时间
    photoBroseView.showDuration = 0.78;
    photoBroseView.hiddenDuration = 0.78;
    
    // 设置代理
    photoBroseView.delegate = self;
    
    // 3.显示(浏览)
    [photoBroseView show];
}

#pragma mark - PYPhotoBrowseViewDelegate

- (void)photoBrowseView:(PYPhotoBrowseView *)photoBrowseView didLongPressImage:(UIImage *)image index:(NSInteger)index{
    // 长按图片浏览器，相应的时间，类似微信，弹出一个action sheet，有相应的操作。
    [self showOptionsPicker:image];
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

- (void)showOptionsPicker:(UIImage*)image{
    [self.superview endEditing:YES];
    
    NSMutableArray *item = @[@"保存图片到相册"].mutableCopy;
    
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:nil
                                             cancelButtonTitle:kCancelTitle
                                                       clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
                                                           DLog(@"buttonIndex = %@ clicked",@(buttonIndex));
                                                           if(buttonIndex == 1){
                                                            // 保存到相册
                                                               UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
                                                           }
                                                       }
                                         otherButtonTitleArray:item];
    actionSheet.scrolling = item.count > 10;
    actionSheet.visibleButtonCount = 10;
    actionSheet.destructiveButtonIndexSet = [NSIndexSet indexSetWithIndex:0];
    [actionSheet show];
}


#pragma mark - UI

- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.hintLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
//    self.hintLabel.lineSpacing = 5.0;
//    self.hintLabel.numberOfLines = 0;
    
    self.cycleScrollViewHeightCst.constant = 880;
    //self.bottomViewHeightCst.constant = 200;
    self.onSellTimeLabel.numberOfLines = 0;
    self.onSellTimeLabel.lineSpacing = 2.5;
    
    [self setupBannerView];
}

- (void)setupBannerView{
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

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if(error){
                [MBProgressHUD showError:@"保存失败"] ;
            }else{
                [MBProgressHUD showSuccess:@"保存成功"];
            }
        });
    });
}

@end
