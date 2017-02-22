//
//  DKYDeliveryDateView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/16.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDeliveryDateView.h"
#import "MMPopupItem.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#import "DKYCustomOrderItemModel.h"
#import "WGBDatePickerView.h"

@interface DKYDeliveryDateView ()<WGBDatePickerViewDelegate>

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *optionsBtn;

@property (nonatomic, weak) UILabel *hintLabel;

@property (nonatomic,strong) WGBDatePickerView *datePickView;
@end

@implementation DKYDeliveryDateView

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
        make.width.mas_equalTo(textFrame.size.width + 10);
    }];
}

#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    //    if(self.optionsBtnClicked){
    //        self.optionsBtnClicked(sender,sender.tag);
    //    }
    [self showFaxDateSelectedPicker];
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
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"点击选择日期"
                                                          items:[items copy]];
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [sheetView show];
}

- (void)showFaxDateSelectedPicker{
    [self.superview endEditing:YES];
    [self.datePickView show];
}

#pragma mark- <WGBDatePickerViewDelegate>
//当时间改变时触发
- (void)changeTime:(NSDate *)date{
    
}

//确定时间
- (void)determine:(NSDate *)date{
    DLog(@"选中时间 = %@",[self.datePickView stringFromDate:date]);
}


#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    [self setupOptionsBtn];
    [self setupHintLabel];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor blackColor];
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
//        make.right.mas_equalTo(weakSelf);
        make.width.mas_equalTo(206);
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
        make.left.mas_equalTo(weakSelf.optionsBtn.mas_right).with.offset(8);
        make.top.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
    }];
    label.text = @"*选择传真日期后9~15天内的第一个星期一";
}

#pragma mark - get & set method
- (WGBDatePickerView *)datePickView{
    if (!_datePickView) {
        _datePickView =[[WGBDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds type:UIDatePickerModeDate];
        _datePickView.delegate = self;
        _datePickView.title =@"传真日期";
    }
    return _datePickView;
}

@end
