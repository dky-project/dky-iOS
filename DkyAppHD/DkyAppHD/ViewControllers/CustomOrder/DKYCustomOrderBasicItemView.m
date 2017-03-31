//
//  DKYCustomOrderBasicItemView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderBasicItemView.h"

@implementation DKYCustomOrderBasicItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.canEdit = YES;
    }
    return self;
}

- (void)clear{
    DLog(@"DKYCustomOrderBasicItemView ,subclass must be implemtioned");
}

- (void)fetchAddProductApproveInfo{
     DLog(@"DKYCustomOrderBasicItemView ,subclass must be implemtioned");
}

- (void)dealwithMDimNew12IdSelected{
    DLog(@"super do nothing");
}

- (void)dealwithMDimNew22IdSelected{
    DLog(@"super do nothing");
}

- (void)dealwithMDimNew13IdSelected{
    DLog(@"super do nothing");
}

- (void)dealwithMDimNew15IdSelected{
    DLog(@"super do nothing");
}

@end
