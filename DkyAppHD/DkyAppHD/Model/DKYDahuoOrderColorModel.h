//
//  DKYDahuoOrderColorModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/2/23.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

//colorDesc = 驼色,
//colorValue = 025,
//colorName = 驼色,
//colorId = 803

@interface DKYDahuoOrderColorModel : NSObject

@property (nonatomic, copy) NSString *colorDesc;
@property (nonatomic, copy) NSString *colorValue;
@property (nonatomic, copy) NSString *colorName;

@property (nonatomic, assign) NSInteger colorId;

@property (nonatomic, assign) BOOL selected;

@end
