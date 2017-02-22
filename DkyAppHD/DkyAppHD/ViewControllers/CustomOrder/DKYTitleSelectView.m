//
//  DKYTitleSelectView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYTitleSelectView.h"
#import "MMPopupItem.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#import "DKYCustomOrderItemModel.h"

@interface DKYTitleSelectView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *hintLabel;

@end

@implementation DKYTitleSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setItemModel:(DKYCustomOrderItemModel *)itemModel{
    _itemModel = itemModel;
    
    self.titleLabel.text = itemModel.title;
    
    [self.optionsBtn setTitle:itemModel.content forState:UIControlStateNormal];
    
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
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textFrame.size.width + 2);
    }];
    
    if(itemModel.subText.length > 0){
        textFrame = [itemModel.subText boundingRectWithSize:size
                                                    options:options
                                                 attributes:attributes
                                                    context:nil];
        self.hintLabel.text = itemModel.subText;
        [self.hintLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(textFrame.size.width + 2);
        }];
    }

}

#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    if(self.optionsBtnClicked){
        self.optionsBtnClicked(sender);
    }
//    [self showOptionsPicker];
}

#pragma mark - private method
- (void)showOptionsPicker{
    [self.superview endEditing:YES];
    MMPopupItemHandler block = ^(NSInteger index){
        DLog(@"++++++++ index = %ld",index);
    };
    
    NSArray *item = @[@"1",@"2",@"3",@"4",@"5"];
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:item.count + 1];
    for (NSString *str in item) {
        [items addObject:MMItemMake(str, MMItemTypeNormal, block)];
    }
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"选择钉扣"
                                                          items:[items copy]];
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [sheetView show];
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    [self setupHintLabel];
    [self setupOptionsBtn];
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
        make.bottom.mas_equalTo(weakSelf);
        make.width.mas_equalTo(40);
    }];
    
    label.adjustsFontSizeToFitWidth = YES;
}

- (void)setupOptionsBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.right.mas_equalTo(weakSelf.hintLabel.mas_left);
    }];
    self.optionsBtn = btn;
}

- (void)setupHintLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor colorWithHex:0x999999];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:label];
    self.hintLabel = label;
    WeakSelf(weakSelf);
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
    }];
}

@end
