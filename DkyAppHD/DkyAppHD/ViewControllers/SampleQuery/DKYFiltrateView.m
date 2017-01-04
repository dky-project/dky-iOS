//
//  DKYFiltrateView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYFiltrateView.h"

@implementation DKYFiltrateView

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
    self.backgroundColor = [UIColor whiteColor];
}

@end
