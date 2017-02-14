//
//  DKYOrderActionsView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/14.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderActionsView.h"

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
    
}

@end
