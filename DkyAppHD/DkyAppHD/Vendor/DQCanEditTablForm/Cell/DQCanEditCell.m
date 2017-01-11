//
//  DQCanEditCell.m
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/24.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import "DQCanEditCell.h"
#import "DQTextField.h"
#import "DQHeader.h"

const NSInteger DQlimitNum = 9999;//最大的限制

@interface DQCanEditCell()<UITextFieldDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
@implementation DQCanEditCell
- (DQTextField *)DQTextFd{
    if (!_DQTextFd) {
        _DQTextFd = [DQTextField new];
        _DQTextFd.layer.borderColor = [UIColor blackColor].CGColor;
        _DQTextFd.layer.borderWidth = 0.5f;
        UIView *sub  = self.contentView;
        [sub addSubview:_DQTextFd];
        _DQTextFd.font = [UIFont systemFontOfSize:13];
        _DQTextFd.textAlignment = NSTextAlignmentCenter;
        _DQTextFd.keyboardType = UIKeyboardTypeNumberPad;
        _DQTextFd.DQCell = self;
        [_DQTextFd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(sub);
            make.left.equalTo(sub.mas_left).offset(4);
            make.right.equalTo(sub.mas_right).offset(-4);
            make.height.mas_equalTo(22);
        }];
        _DQTextFd.delegate = self;
        
    }
    return _DQTextFd;

}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        [self DQAddSubViewFunction];
        self.Textlab.hidden = YES;
        self.DQTextFd.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        [self DQAddSubViewFunction];
        self.Textlab.hidden = YES;
        self.DQTextFd.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)DQEditSetDataFunction:(NSIndexPath *)path andTotalPath:(NSIndexPath *)TotalPath andTitle:(NSString *)title{
    self.currentStr = title;
    self.DQTextFd.Cellpath = self.cellPath;
    self.indexPath = path;
    [self labelAndTextFildShowFunction:path andTotalPath:TotalPath andTitle:title];
    [self HiddenAllSpaceViewFunction];
    [self ViewIsHiddenAndShowFuntion:path andTotalPath:TotalPath];
    
}

- (void)labelAndTextFildShowFunction:(NSIndexPath *)path andTotalPath:(NSIndexPath *)TotalPath andTitle:(NSString *)title{
    
    if (path.section==0&&TotalPath.section>0) {
        self.DQTextFd.hidden = YES;
        self.Textlab.hidden = NO;
        self.Textlab.text = title;
    }else if(path.section == TotalPath.section&&(TotalPath.section>=0)){
        self.DQTextFd.hidden = YES;
        self.Textlab.hidden = NO;
        self.Textlab.text = title;
    
    }else{
        if (path.row == 0) {
            self.DQTextFd.hidden = YES;
            self.Textlab.hidden = NO;
            self.Textlab.text = title;
        }else{
            self.Textlab.hidden = YES;
            self.DQTextFd.hidden = NO;
            self.DQTextFd.text = title;
        
        }
    }

}

- (void)postNotifiFunction{
    //开始点击 就发生通知
    [[NSNotificationCenter defaultCenter]postNotificationName:DQGetCellFromNotifition object:self.DQTextFd];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ([textField isKindOfClass:[DQTextField class]]) {
        [self postNotifiFunction];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger currentNum = [toBeString integerValue];
    
    if (currentNum >= DQlimitNum) {//超过最大的限制
    
        currentNum = DQlimitNum;
        self.currentStr = [NSString stringWithFormat:@"%zd",currentNum];
        return NO;
    }
    //处理前面是0的情况
    if ([textField.text isEqualToString:@"0"] && ![string isEqualToString:@""]) {
        textField.text = string;
        return NO;
    }
    
    //删除最后一位的处理
    if (textField.text.length == 1 && [string isEqualToString:@""]) {
        textField.text = @"0";
      
        return NO;
    }
  
   
    return YES;
}   // return NO to not change text
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.currentStr = textField.text;
    
    if ([self.delegate respondsToSelector:@selector(changeDataFromIndexpath:andTitle:)]) {
        [self.delegate changeDataFromIndexpath:self.indexPath andTitle:self.currentStr];
    }
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
