//
//  DQFormHeader.m
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/23.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import "DQFormHeader.h"
#import "DQHeader.h"

@interface DQFormHeader ()

@property (nonatomic, weak) UILabel *HeaderTitlelab;

@end
@implementation DQFormHeader
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self DQAddsubViewFunction];
    }

    return self;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self DQAddsubViewFunction];
    
    }

    return self;
}
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self DQAddsubViewFunction];
    }

    return self;
}

- (void)DQAddsubViewFunction{
    
    UIView *sub = self.contentView;
    UIView *baview = [UIView new];
    baview.backgroundColor = [UIColor whiteColor];
    [sub addSubview:baview];
    [baview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sub);
        make.bottom.equalTo(sub);
        make.right.equalTo(sub);
        make.top.equalTo(sub);
    }];
    
    
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.4f;
   
    [sub addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sub.mas_left).offset(15);
        make.right.equalTo(sub.mas_right).offset(-15);
        make.bottom.equalTo(sub);
        make.height.mas_equalTo(1);
        
    }];
    
    UILabel *titleLab = [UILabel new];
    self.HeaderTitlelab = titleLab;
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = [UIColor blackColor];
    [sub addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sub.mas_left).offset(15);
        make.right.equalTo(sub.mas_right).offset(-15);
        make.height.mas_equalTo(17);
        make.centerY.equalTo(sub);
        
    }];
    
}
- (void)setTitleText:(NSString *)title{

    self.HeaderTitlelab.text = title;
    
}

@end
