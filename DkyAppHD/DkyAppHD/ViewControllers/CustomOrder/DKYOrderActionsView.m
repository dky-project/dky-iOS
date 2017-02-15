//
//  DKYOrderActionsView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/14.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderActionsView.h"
#import "UIButton+Custom.h"

@interface DKYOrderActionsView ()

@property (nonatomic, weak) UIButton *lastStepBtn;

@end

@implementation DKYOrderActionsView

+ (instancetype)orderActionsView{
    DKYOrderActionsView *view = [[DKYOrderActionsView alloc]initWithFrame:CGRectZero];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - UI

- (void)commonInit{
    self.backgroundColor = [UIColor randomColor];
    [self setupActionBtn];
}

- (void)setupActionBtn{
    
}

@end
