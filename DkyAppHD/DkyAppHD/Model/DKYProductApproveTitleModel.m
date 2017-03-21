//
//  DKYProductApproveTitleModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/21.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYProductApproveTitleModel.h"

@implementation DKYProductApproveTitleModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    NSDictionary *dict = [self.dimList jsonValueDecoded];
    self.dimListModel = [DKYCustomOrderDimList mj_objectWithKeyValues:dict];
    
    
    dict = [self.staticDimList jsonValueDecoded];
    self.staticDimListModel = [DKYStaticDimListModel mj_objectWithKeyValues:dict];
}

@end
