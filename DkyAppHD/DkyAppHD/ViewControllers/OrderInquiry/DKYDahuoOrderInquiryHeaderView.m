//
//  DKYDahuoOrderInquiryHeaderView.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/1.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDahuoOrderInquiryHeaderView.h"
#import "UUDatePicker.h"

@interface DKYDahuoOrderInquiryHeaderView ()

@property (nonatomic, strong) UUDatePicker *datePicker;

@end

@implementation DKYDahuoOrderInquiryHeaderView

+ (instancetype)orderInquiryHeaderView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - action method

- (IBAction)batchPreviewBtnClicked:(UIButton *)sender {
    if(self.batchPreviewBtnClicked){
        self.batchPreviewBtnClicked(self);
    }
}

- (IBAction)findBtnClicked:(UIButton *)sender {
    if(self.findBtnClicked){
        self.findBtnClicked(self);
    }
}

- (IBAction)deleteBtnClicked:(UIButton *)sender {
    if(self.deleteBtnClicked){
        self.deleteBtnClicked(self);
    }
}

#pragma mark - UI

- (void)commonInit{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    UIView *placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    placeholderView.backgroundColor = [UIColor whiteColor];
    self.kuanhaoTextField.leftViewMode = UITextFieldViewModeAlways;
    self.kuanhaoTextField.leftView = placeholderView;
    
    placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    placeholderView.backgroundColor = [UIColor whiteColor];
    self.sizeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.sizeTextField.leftView = placeholderView;
    
    placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    placeholderView.backgroundColor = [UIColor whiteColor];
    self.colorTextField.leftViewMode = UITextFieldViewModeAlways;
    self.colorTextField.leftView = placeholderView;
    
    self.kuanhaoTextField.placeholder = @"请输入款号";
    self.sizeTextField.placeholder = @"请输入尺寸";
    self.colorTextField.placeholder = @"请输入颜色";
    
    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(120, 38)];
    image = [image imageByRoundCornerRadius:0 borderWidth:0.5 borderColor:[UIColor blackColor]];
    [self.findBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.batchPreviewBtn setBackgroundImage:image forState:UIControlStateNormal];
}

- (UUDatePicker*)datePicker{
    if(_datePicker == nil){
        _datePicker = [[UUDatePicker alloc]initWithframe:CGRectMake(0, 0, 768, 200)
                                             PickerStyle:UUDateStyle_YearMonthDayHourMinute
                                             didSelected:nil];
        
        NSDate *now = [NSDate date];
        //scroll to specified time
        _datePicker.ScrollToDate = now;
        //select the max limit time
        _datePicker.maxLimitDate = now;
        //select the max limit time
        _datePicker.minLimitDate = [now dateByAddingTimeInterval:-1110000];
    }
    return _datePicker;
}

@end
