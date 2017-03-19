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
    DLog(@"DKYCustomOrderBasicItemView ,subclass must br implemtioned")
}

@end
