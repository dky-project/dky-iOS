//
//  DQFormCollectionViewCell.m
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/23.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import "DQFormCollectionViewCell.h"
@interface DQFormCollectionViewCell ()

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *BottoView;
@property (nonatomic, strong) UIView *rigthView;
@property (nonatomic, strong) UIView *topView;

@end

@implementation DQFormCollectionViewCell
- (UILabel *)Textlab{
    if (!_Textlab) {
        _Textlab = [UILabel new];
        _Textlab.font = [UIFont systemFontOfSize:13];
        _Textlab.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.Textlab];
        _Textlab.hidden = NO;
        _Textlab.textAlignment = NSTextAlignmentCenter;
        [_Textlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.height.mas_equalTo(14);
        }];
        
    }

    return _Textlab;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        [self DQAddSubViewFunction];
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
    }
    return self;
}
- (void)DQAddSubViewFunction{

    UIView *sub  = self.contentView;
    self.leftView = [UIView new];
    self.leftView.backgroundColor = [UIColor blackColor];
    [sub addSubview:self.leftView];
    self.leftView.hidden = YES;
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sub.mas_left).offset(0.5);
        make.top.equalTo(sub.mas_top).offset(0.5);
        make.bottom.equalTo(sub.mas_bottom).offset(-0.5);
        make.width.mas_equalTo(0.5);
    }];
    
    self.BottoView = [UIView new];
    self.BottoView.backgroundColor = [UIColor blackColor];
    [sub addSubview:self.BottoView];
    self.BottoView.hidden = YES;
    [self.BottoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sub.mas_left).offset(0.5);
        make.right.equalTo(sub.mas_right).offset(-0.5);
        make.bottom.equalTo(sub.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
    
    self.rigthView = [UIView new];
    self.rigthView.backgroundColor = [UIColor blackColor];
    [sub addSubview:self.rigthView];
    self.rigthView.hidden = YES;
    [self.rigthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(0.5);
        make.right.equalTo(sub.mas_right).offset(-0.5);
        make.bottom.equalTo(sub.mas_bottom).offset(-0.5);
        make.width.mas_equalTo(0.5);
    }];
    
    self.topView = [UIView new];
    self.topView.backgroundColor = [UIColor blackColor];
    [sub addSubview:self.topView];
    self.topView.hidden = YES;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(0.5);
        make.right.equalTo(sub.mas_right).offset(-0.5);
        make.left.equalTo(sub.mas_left).offset(0.5);
        make.height.mas_equalTo(0.5);
    }];

}

- (void)setDataFunction:(NSIndexPath *)path andTotalPath:(NSIndexPath *)TotalPath andTitle:(NSString *)title{
    
    self.Textlab.hidden = NO;
    self.Textlab.text = title;
    [self HiddenAllSpaceViewFunction];
    [self ViewIsHiddenAndShowFuntion:path andTotalPath:TotalPath];

}
- (void)HiddenAllSpaceViewFunction{
    self.topView.hidden = YES;
    self.BottoView.hidden = YES;
    self.rigthView.hidden = YES;
    self.leftView.hidden = YES;
}

- (void)ViewIsHiddenAndShowFuntion:(NSIndexPath *)path andTotalPath:(NSIndexPath *)TotalPath{
    NSInteger DQSection = 0;
    NSInteger DQRow = 0;
    if (TotalPath.section>=0) {//防止为负数
        DQSection = TotalPath.section;
    }
    
    if (TotalPath.row>=0) {
        DQRow = TotalPath.row;
    }
    
    if (DQSection == 0) { //只有一组
        self.leftView.hidden = NO;
        self.rigthView.hidden = NO;
        [self fristShowleftViewAndLastShowRightView:path andTatolPath:TotalPath];
        
    }else{//两组或者两组以上
        
        if (path.section == 0) {//第一组
            self.leftView.hidden = NO;
            
            [self fristShowleftViewAndLastShowRightView:path andTatolPath:TotalPath];
            
        }else if (path.section >= DQSection) {//最后一组
            self.rigthView.hidden = NO;
            
            [self fristShowleftViewAndLastShowRightView:path andTatolPath:TotalPath];
            
            
        }else{//中间的
            
            [self fristShowleftViewAndLastShowRightView:path andTatolPath:TotalPath];
        
        }
    
    }
    

}
- (void)fristShowleftViewAndLastShowRightView:(NSIndexPath *)path andTatolPath:(NSIndexPath *)TotalPath{
    NSInteger DQRow = 0;
    if (TotalPath.row>=0) {//防止为负数
        DQRow = TotalPath.row;
    }
    if (path.row == 0) {
        self.topView.hidden = NO;
    }
    if (path.row >= DQRow) {
        self.BottoView.hidden = NO;
    }

}
@end
