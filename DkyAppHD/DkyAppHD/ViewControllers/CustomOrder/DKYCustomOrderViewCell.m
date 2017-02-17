//
//  DKYCustomOrderViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/16.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderViewCell.h"
#import "UIButton+Custom.h"
#import "MMPopupItem.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#import "DKYCustomOrderTextFieldView.h"
#import "DKYCustomOrderTextFieldView.h"
#import "DKYCustomOrderItemModel.h"
#import "DKYCustomOrderGenderItemView.h"
#import "DKYCustomOrderVarietyView.h"
#import "DKYCustomOrderPatternItemView.h"
#import "DKYCustomOrderSizeItemView.h"

static const CGFloat topOffset = 30;
static const CGFloat leftOffset = 53;

static const CGFloat hpadding = 37;
static const CGFloat vpadding = 20;

static const CGFloat basicItemWidth = 196;
static const CGFloat basicItemHeight = 30;

@interface DKYCustomOrderViewCell ()

// 编号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *numberView;

// 客户号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *clientView;

// 手机号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *phoneNumberView;

// 款号
@property (nonatomic, weak) DKYCustomOrderTextFieldView *styleNumberView;

// 性别
@property (nonatomic, weak) DKYCustomOrderGenderItemView *genderItemView;

// 品种
@property (nonatomic, weak) DKYCustomOrderVarietyView *varietyView;

// 式样
@property (nonatomic, weak) DKYCustomOrderPatternItemView *patternItemView;

// 尺寸View
@property (nonatomic, weak) DKYCustomOrderSizeItemView *sizeView;


//@property (nonatomic, weak) UILabel *titleLabel;

//
@end

@implementation DKYCustomOrderViewCell

+ (instancetype)customOrderViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYCustomOrderViewCell";
    DKYCustomOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYCustomOrderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self commonInit];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(72, self.tw_height - 1)];
    [path addLineToPoint:CGPointMake(self.tw_width - 72, self.tw_height - 1)];
    [[UIColor colorWithHex:0x999999] setStroke];
    
    [path setLineWidth:1];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapButt];
    
    CGFloat lengths[2] = { 1, 1 };
    CGContextSetLineDash(context, 0, lengths, 2);
    [path stroke];
}

#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
//    if(self.optionsBtnClicked){
//        self.optionsBtnClicked(sender,sender.tag);
//    }
    [self showOptionsPicker];
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
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"点击选择内容"
                                                          items:[items copy]];
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [sheetView show];
}

#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 第一行 款号，客户，手机号
    [self setupNumberView];
    [self setupClientView];
    [self setupPhoneNumberView];
    
    // 第二行 款号，性别
    [self setupStyleNumberView];
    [self setupGenderItemView];
    
    // 第三大行 品种 4个选择器
    [self setupVarietyView];
    
    // 第四大行， 式样
    [self setupPatternItemView];
    
    // 第五大行，尺寸
    [self setupSizeView];
}

- (void)setupNumberView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.numberView = view;
    
    WeakSelf(weakSelf);
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).with.offset(leftOffset);
        make.width.mas_equalTo(basicItemWidth);
        make.height.mas_equalTo(basicItemHeight);
        make.top.mas_equalTo(weakSelf.contentView).with.offset(topOffset);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"编号:";
    itemModel.placeholder = @"请输入1-6位的数字编号";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    itemModel.textFieldLeftOffset = 16;
    self.numberView.itemModel = itemModel;
}

- (void)setupClientView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.clientView = view;
    
    WeakSelf(weakSelf);
    [self.clientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.numberView.mas_right).with.offset(hpadding);
        make.width.mas_equalTo(weakSelf.numberView);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.numberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*客户:";
    self.clientView.itemModel = itemModel;
}

- (void)setupPhoneNumberView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.phoneNumberView = view;
    
    WeakSelf(weakSelf);
    [self.phoneNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.clientView.mas_right).with.offset(hpadding);
        make.width.mas_equalTo(weakSelf.numberView);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.numberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*手机号:";
    itemModel.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNumberView.itemModel = itemModel;
}

- (void)setupStyleNumberView{
    DKYCustomOrderTextFieldView *view = [[DKYCustomOrderTextFieldView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.styleNumberView = view;
    
    WeakSelf(weakSelf);
    [self.styleNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.numberView);
        make.width.mas_equalTo(weakSelf.numberView);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.numberView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*款号:";
    itemModel.keyboardType = UIKeyboardTypeNumberPad;
    self.styleNumberView.itemModel = itemModel;
}

- (void)setupGenderItemView{
    DKYCustomOrderGenderItemView *view = [[DKYCustomOrderGenderItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.genderItemView = view;
    
    WeakSelf(weakSelf);
    [self.genderItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.clientView);
        make.width.mas_equalTo(weakSelf.numberView);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.styleNumberView);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*性别:";
    self.genderItemView.itemModel = itemModel;
}

- (void)setupVarietyView{
    DKYCustomOrderVarietyView *view = [[DKYCustomOrderVarietyView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.varietyView = view;
    
    WeakSelf(weakSelf);
    [self.varietyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(80);
        make.top.mas_equalTo(weakSelf.styleNumberView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*品种:";
    self.varietyView.itemModel = itemModel;
}

- (void)setupPatternItemView{
    DKYCustomOrderPatternItemView *view = [[DKYCustomOrderPatternItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.patternItemView = view;
    
    WeakSelf(weakSelf);
    [self.patternItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(80);
        make.top.mas_equalTo(weakSelf.varietyView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"*式样:";
    self.patternItemView.itemModel = itemModel;
}

- (void)setupSizeView{
    DKYCustomOrderSizeItemView *view = [[DKYCustomOrderSizeItemView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    self.sizeView = view;
    
    WeakSelf(weakSelf);
    [self.sizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.styleNumberView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-leftOffset);
        make.height.mas_equalTo(weakSelf.numberView);
        make.top.mas_equalTo(weakSelf.patternItemView.mas_bottom).with.offset(vpadding);
    }];
    
    DKYCustomOrderItemModel *itemModel = [[DKYCustomOrderItemModel alloc] init];
    itemModel.title = @"尺寸:";
    itemModel.textFieldLeftOffset = 16;
    self.sizeView.itemModel = itemModel;
}






















































//- (void)setupTitleLabel{
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
//    label.font = [UIFont boldSystemFontOfSize:15];
//    label.textColor = [UIColor blackColor];
//    label.textAlignment = NSTextAlignmentLeft;
//    
//    [self.contentView addSubview:label];
//    self.titleLabel = label;
//    WeakSelf(weakSelf);
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.contentView).with.offset(72);
//        make.top.mas_equalTo(weakSelf.contentView).with.offset(42);
//        make.width.mas_equalTo(80);
//    }];
//
//    label.adjustsFontSizeToFitWidth = YES;
//    
//    label.text = @"标题标题";
//}
//
//- (void)setupOptionsBtn{
//    WeakSelf(weakSelf);
//    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
//    [self.contentView addSubview:btn];
//    [btn setTitle:@"点击选中内容" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(160, 28));
//        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
//        make.top.mas_equalTo(weakSelf.contentView).with.offset(37);
//    }];
//}
//
//- (void)setupCustomOrderTextFieldView{
//    
//}

@end
