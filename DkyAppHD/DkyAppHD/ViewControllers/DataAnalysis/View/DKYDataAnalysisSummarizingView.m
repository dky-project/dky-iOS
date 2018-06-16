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
    
    WeakSelf(weakSelf);
    
    [self.orderSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(53);
        make.top.mas_equalTo(32);
    }];
}

@end
