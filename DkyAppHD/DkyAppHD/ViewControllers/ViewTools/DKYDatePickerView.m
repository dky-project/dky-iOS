//
//  DKYDatePickerView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDatePickerView.h"
#import "MMPopupDefine.h"
#import "MMPopupCategory.h"
#import "MMPopupWindow.h"
#import "UUDatePicker.h"

static NSString * kDateFormater = @"yyyy-MM-dd HH:mm";

@interface DKYDatePickerView ()<UUDatePickerDelegate>
//
//@property (nonatomic, strong) UIPickerView *datePicker;

@property (nonatomic, strong) UUDatePicker *datePicker;

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, strong) UIColor *oldBackGroundColor;

@property (nonatomic, weak) UILabel *titleLabel;

@end



@implementation DKYDatePickerView

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        [MMPopupWindow sharedWindow].touchWildToHide = YES;
        self.type = MMPopupTypeSheet;
        self.backgroundColor = [UIColor colorWithHex:0xf7f7f7];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(216+44);
        }];
        [self setupTopView];
        
        [self setuppickerView];
    }
    
    return self;
}

#pragma mark - action method
- (void)closeBtnClicked:(UIButton *)sender
{
    [self hide];
}

- (void)doneBtnClicked:(UIButton*)sender
{
    if(self.doneBlock){
        self.doneBlock(self, DkyButtonStatusType_Done);
    }
    [self hide];
}

#pragma mark - UI
- (void)setupTopView
{
    WeakSelf(weakSelf);
    
    self.btnCancel = [UIButton mm_buttonWithTarget:self action:@selector(closeBtnClicked:)];
    [self addSubview:self.btnCancel];
    
    [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 44));
        make.left.equalTo(weakSelf.mas_left).with.offset(16);
        make.top.equalTo(weakSelf);
    }];
    [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    self.btnCancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btnCancel setTitleColor:[UIColor colorWithHex:0x405898] forState:UIControlStateNormal];
    
    
    self.btnConfirm = [UIButton mm_buttonWithTarget:self action:@selector(doneBtnClicked:)];
    [self addSubview:self.btnConfirm];
    [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 44));
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right).with.offset(-16);
        make.top.equalTo(weakSelf);
    }];
    [self.btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
    self.btnConfirm.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.btnConfirm setTitleColor:[UIColor colorWithHex:0x405898] forState:UIControlStateNormal];
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    label.text = @"请选择传真日期";
    self.titleLabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.top.equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.btnCancel.mas_right).with.offset(20);
        make.right.mas_equalTo(weakSelf.btnConfirm.mas_left).with.offset(-20);
    }];
}

- (void)setuppickerView
{
    [self addSubview:self.datePicker];
//    WeakSelf(weakSelf);
//    self.datePicker = [[UIPickerView alloc]init];
//    self.datePicker.delegate = self;
//    self.datePicker.dataSource = self;
//    self.datePicker.backgroundColor = [UIColor whiteColor];
//    [self addSubview:self.datePicker];
//    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(44, 0, 0, 0));
//    }];
}


#pragma mark - UUDatePicker's delegate
- (void)uuDatePicker:(UUDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay
{
    NSString *selectedTime = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
//    DLog(@"%@",selectedTime);
    self.selectedDate = [datePicker dateFromString:selectedTime withFormat:kDateFormater];
}

- (UUDatePicker*)datePicker{
    if(_datePicker == nil){
        _datePicker = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 44, kScreenWidth, 216)
                                             PickerStyle:UUDateStyle_YearMonthDayHourMinute
                                             didSelected:nil];
        
        NSDate *now = [NSDate date];
        _datePicker.delegate = self;
        
        //scroll to specified time
        _datePicker.ScrollToDate = now;
    }
    return _datePicker;
}


@end
