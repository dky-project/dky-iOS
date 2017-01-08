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

@property (weak, nonatomic) IBOutlet UITextField *clientTextField;


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

- (void)auditStatusLabelTapped:(UITapGestureRecognizer*)ges{
    if(self.auditStatusBlock){
        self.auditStatusBlock(self);
    }
}

#pragma mark - UI

- (void)commonInit{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    UIView *placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    placeholderView.backgroundColor = [UIColor whiteColor];
    self.clientTextField.leftViewMode = UITextFieldViewModeAlways;
    self.clientTextField.leftView = placeholderView;
    
    self.clientTextField.inputView = self.datePicker;
    
    placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    placeholderView.backgroundColor = [UIColor whiteColor];
    self.sampleTextField.leftViewMode = UITextFieldViewModeAlways;
    self.sampleTextField.leftView = placeholderView;
    
    self.clientTextField.placeholder = @"客户";
    self.sampleTextField.placeholder = @"样衣";
    
    UIImage *image = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(120, 38)];
    image = [image imageByRoundCornerRadius:0 borderWidth:0.5 borderColor:[UIColor blackColor]];
    [self.findBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.deleteBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.batchPreviewBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faxDateLabelTapped:)];
    [self.faxDateLabel addGestureRecognizer:tap];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(auditStatusLabelTapped:)];
    [self.auditStatusLabel addGestureRecognizer:tap];
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
