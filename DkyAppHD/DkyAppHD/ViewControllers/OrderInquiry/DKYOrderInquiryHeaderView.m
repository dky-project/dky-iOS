//
//  DKYOrderInquiryHeaderView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderInquiryHeaderView.h"
#import "UUDatePicker.h"

@interface DKYOrderInquiryHeaderView ()

@property (nonatomic, strong) UUDatePicker *datePicker;

@end

@implementation DKYOrderInquiryHeaderView

//+ (instancetype)orderInquiryHeaderView{
//    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 240)];
//}

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

- (void)faxDateLabelTapped:(UITapGestureRecognizer*)ges{
    if(self.faxDateBlock){
        self.faxDateBlock(self);
    }
}

- (void)sourceLabelTapped:(UITapGestureRecognizer*)ges{
    if(self.sourceBlock){
        self.sourceBlock(self);
    }
}

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
  
    self.kuanhaoTextField.placeholder = @"款号";

    
    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(120, 38)];
    image = [image imageByRoundCornerRadius:0 borderWidth:0.5 borderColor:[UIColor blackColor]];
    [self.findBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.batchPreviewBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sourceLabelTapped:)];
    [self.sourceLabel addGestureRecognizer:tap];
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
