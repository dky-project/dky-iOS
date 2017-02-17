//
//  DKYCustomOrderSizeItemView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderSizeItemView.h"
#import "DKYTitleSelectView.h"
#import "DKYTitleInputView.h"

@interface DKYCustomOrderSizeItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) DKYTitleSelectView *bigView;

@property (nonatomic, weak) DKYTitleInputView *lengthView;

@end

@implementation DKYCustomOrderSizeItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setItemModel:(DKYCustomOrderItemModel *)itemModel{
    [super setItemModel:itemModel];
    
    if(itemModel.title.length > 0){
        self.titleLabel.text = itemModel.title;
    }
    
    if(itemModel.title.length >0 && [itemModel.title hasPrefix:@"*"]){
        NSDictionary *dict = @{NSForegroundColorAttributeName : self.titleLabel.textColor,
                               NSFontAttributeName : self.titleLabel.font};
        NSMutableAttributedString *atitle = [[NSMutableAttributedString alloc] initWithString:itemModel.title attributes:dict];
        
        [atitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        self.titleLabel.attributedText = atitle;
    }
    
    
    UIFont *font = self.titleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    UIColor *foregroundColor = self.titleLabel.textColor;
    
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSForegroundColorAttributeName: foregroundColor};
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect textFrame = [itemModel.title boundingRectWithSize:size
                                                     options:options
                                                  attributes:attributes
                                                     context:nil];
    CGFloat offset = itemModel.textFieldLeftOffset > 0 ? itemModel.textFieldLeftOffset : 10;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textFrame.size.width + offset);
    }];
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    
    [self setupBigView];
    [self setupLengthView];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:label];
    self.titleLabel = label;
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(40);
    }];
}

- (void)setupBigView{
    DKYTitleSelectView *view = [[DKYTitleSelectView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.bigView = view;
    
    WeakSelf(weakSelf);
    [self.bigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(152);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"大";
    itemModel.content = @"点击选择大小";
    self.bigView.itemModel = itemModel;
}

- (void)setupLengthView{
    DKYTitleInputView *view = [[DKYTitleInputView alloc] initWithFrame:CGRectZero];
    [self addSubview:view];
    self.lengthView = view;
    
    WeakSelf(weakSelf);
    [self.lengthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bigView.mas_right).with.offset(37);
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.width.mas_equalTo(196);
        make.top.mas_equalTo(weakSelf);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"长";
    self.lengthView.itemModel = itemModel;
}

@end
