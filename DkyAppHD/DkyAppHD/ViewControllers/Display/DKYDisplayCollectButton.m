//
//  DKYDisplayCollectButton.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayCollectButton.h"

@implementation DKYDisplayCollectButton

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if(selected){
        self.qmui_borderPosition = QMUIViewBorderPositionNone;
    }else{
        self.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionLeft | QMUIViewBorderPositionBottom | QMUIViewBorderPositionRight;
        self.qmui_borderWidth = 1;
        self.qmui_borderColor = [UIColor colorWithHex:0x686868];
    }
}

@end
