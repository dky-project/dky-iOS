//
//  DKYCustomOrderDimList.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/21.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderDimList.h"
#import "DKYDimlistItemModel.h"

@implementation DKYCustomOrderDimList

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"DIMFLAG_NEW1" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW2" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW3" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW4" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW5" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW6" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW7" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW8" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW9" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW10" : @"DKYDimlistItemModel",
             
             @"DIMFLAG_NEW11" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW12" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW13" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW14" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW15" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW16" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW17" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW18" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW19" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW20" : @"DKYDimlistItemModel",
             
             @"DIMFLAG_NEW21" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW22" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW23" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW24" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW25" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW26" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW27" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW28" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW29" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW30" : @"DKYDimlistItemModel",
             
             @"DIMFLAG_NEW31" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW32" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW33" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW34" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW35" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW36" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW37" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW38" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW39" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW40" : @"DKYDimlistItemModel",
             
             @"DIMFLAG_NEW41" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW42" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW43" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW44" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW45" : @"DKYDimlistItemModel",
             @"DIMFLAG_NEW46" : @"DKYDimlistItemModel",
             };
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    DKYDimlistItemModel *model1 = [[DKYDimlistItemModel alloc] init];
    model1.ID = @"领边";
    model1.attribname = @"领边";
    
    DKYDimlistItemModel *model2 = [[DKYDimlistItemModel alloc] init];
    model2.ID = @"领型";
    model2.attribname = @"领型";
    
    DKYDimlistItemModel *model3 = [[DKYDimlistItemModel alloc] init];
    model3.ID = @"完全";
    model3.attribname = @"完全";
    self.lingArray = @[model1,model2,model3];
}

@end
