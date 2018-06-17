//
//  DKYDataAnalysisSummarizingView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/16.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYDataAnalysisSummarizingView.h"

@interface DKYDataAnalysisSummarizingView()

@property (nonatomic, weak) TTTAttributedLabel *orderSumLabel;

@property (nonatomic, weak) TTTAttributedLabel *sellAmountSumLabel;

@property (nonatomic, weak) TTTAttributedLabel *discountOrRebateLabel;

@property (nonatomic, weak) TTTAttributedLabel *originalPriceLabel;

@property (nonatomic, weak) TTTAttributedLabel *rebateAmountLabel;

@end

@implementation DKYDataAnalysisSummarizingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    [self setupLables];
    
    [self setData];
}

- (void)setData{
    self.orderSumLabel.text = @"下单总数 : 100件";
    [self.orderSumLabel setText:self.orderSumLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    self.sellAmountSumLabel.text = @"零售总金额 : 10000000元";
    [self.sellAmountSumLabel setText:self.sellAmountSumLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    self.discountOrRebateLabel.text = @"专卖店-折扣 : 9.8折";
    [self.discountOrRebateLabel setText:self.discountOrRebateLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    self.originalPriceLabel.text = @"进货价总金额 : 840000元";
    [self.originalPriceLabel setText:self.originalPriceLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
    
    self.rebateAmountLabel.text = @"返利总额 : 840000元";
    [self.rebateAmountLabel setText:self.rebateAmountLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [self formatMutableAttributedString:mutableAttributedString];
        return mutableAttributedString;
    }];
}

#pragma mark - private method
- (void)formatMutableAttributedString:(NSMutableAttributedString*)mutableAttributedString{
    NSRange range = [mutableAttributedString.string rangeOfString:@":"];
    if(range.location != NSNotFound){
        range = NSMakeRange(range.location + 1, mutableAttributedString.string.length - range.location - 1);
        [mutableAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColor colorWithHex:0x333333].CGColor range:range];
    }
}

- (void)setupLables{
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:label];
    self.orderSumLabel = label;
    
    label = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:label];
    self.sellAmountSumLabel = label;
    
    label = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:label];
    self.discountOrRebateLabel = label;
    
    label = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:label];
    self.originalPriceLabel = label;
    
    label = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:label];
    self.rebateAmountLabel = label;
    
    WeakSelf(weakSelf);
    
    [self.orderSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(53);
        make.top.mas_equalTo(32);
    }];
    
    [self.sellAmountSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(384 + 50);
        make.top.mas_equalTo(32);
    }];
    
    [self.discountOrRebateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.orderSumLabel);
        make.top.mas_equalTo(weakSelf.orderSumLabel.mas_bottom).with.offset(12);
    }];
    
    [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.sellAmountSumLabel);
        make.top.mas_equalTo(weakSelf.discountOrRebateLabel);
    }];
    
    [self.rebateAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.orderSumLabel);
        make.top.mas_equalTo(weakSelf.discountOrRebateLabel.mas_bottom).with.offset(12);
    }];
}

@end
