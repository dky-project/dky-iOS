//
//  DKYOrderBrowserLineView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderBrowserLineView.h"

@interface DKYOrderBrowserLineView ()

@property (nonatomic, weak) UILabel *firstTitleLabel;

@property (nonatomic, weak) UILabel *firstContentLabel;

@property (nonatomic, weak) UILabel *secondTitleLabel;

@property (nonatomic, weak) UILabel *secondContentLabel;

@property (nonatomic, weak) UIView *centerLine;

@end

@implementation DKYOrderBrowserLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(44, self.tw_height - 1)];
    [path addLineToPoint:CGPointMake(self.tw_width - 44, self.tw_height - 1)];
    [[UIColor colorWithHex:0x999999] setStroke];
    
    [path setLineWidth:1];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapButt];
    
    CGFloat lengths[2] = { 3, 1 };
    CGContextSetLineDash(context, 0, lengths, 2);
    [path stroke];
}

#pragma mark - UI
- (void)commonInit{
    self.backgroundColor = [UIColor whiteColor];
    [self setupCentenLine];
    [self setupFirstTitleLabel];
    [self setupFirstContentLabel];
    [self setupSecondTitleLabel];
    [self setupSecondContentLabel];
}

- (void)setupCentenLine{
    UIView *line = [[UIView alloc]initWithFrame:CGRectZero];
    line.backgroundColor = [UIColor clearColor];
    [self addSubview:line];
    self.centerLine = line;
    WeakSelf(weakSelf);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.centerX.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(kOnePixLine);
    }];
}

- (void)setupFirstTitleLabel{
    self.firstTitleLabel = [self createLabelWithName:@"机构"];
    WeakSelf(weakSelf);
    UIFont *font = self.firstTitleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    UIColor *foregroundColor = self.firstTitleLabel.textColor;
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSForegroundColorAttributeName: foregroundColor};
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect textFrame = [self.firstTitleLabel.text boundingRectWithSize:size
                                                options:options
                                             attributes:attributes
                                                context:nil];
    [self.firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf).with.offset(-1);
        make.left.mas_equalTo(weakSelf).with.offset(43);
        make.width.mas_equalTo((textFrame.size.width + 1));
    }];
}

- (void)setupFirstContentLabel{
    self.firstContentLabel = [self createContentLabelWithName:@"xxxxx"];
    WeakSelf(weakSelf);
    [self.firstContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf.firstTitleLabel);
        make.left.mas_equalTo(weakSelf.firstTitleLabel.mas_right).with.offset(10);
        make.right.mas_equalTo(weakSelf.centerLine.mas_left);
    }];
}

- (void)setupSecondTitleLabel{
    self.secondTitleLabel = [self createLabelWithName:@"交期"];
    WeakSelf(weakSelf);
    UIFont *font = self.secondTitleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    UIColor *foregroundColor = self.secondTitleLabel.textColor;
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSForegroundColorAttributeName: foregroundColor};
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect textFrame = [self.secondTitleLabel.text boundingRectWithSize:size
                                                               options:options
                                                            attributes:attributes
                                                               context:nil];
    [self.secondTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf).with.offset(-1);
        make.left.mas_equalTo(weakSelf.centerLine.mas_right);
        make.width.mas_equalTo((textFrame.size.width + 1));
    }];
}

- (void)setupSecondContentLabel{
    self.secondContentLabel = [self createContentLabelWithName:@"16/15/19"];
    WeakSelf(weakSelf);
    [self.secondContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf).with.offset(-1);
        make.left.mas_equalTo(weakSelf.secondTitleLabel.mas_right).with.offset(10);
        make.right.mas_equalTo(weakSelf);
    }];
}

- (UILabel*)createLabelWithName:(NSString*)name{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.font = [UIFont systemFontOfSize:11];
    label.textAlignment = NSTextAlignmentLeft;
    [label sizeToFit];
    
    [self addSubview:label];
    
    label.text = name;
    return label;
}

- (UILabel*)createContentLabelWithName:(NSString*)name{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor colorWithHex:0x666666];
    label.font = [UIFont systemFontOfSize:11];
    label.textAlignment = NSTextAlignmentLeft;
    [label sizeToFit];
    
    [self addSubview:label];
    
    label.text = name;
    return label;
}


@end
