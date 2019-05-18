//
//  DKYQueryPriceModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYQueryPriceModel : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) CGFloat floatRate;
@property (nonatomic, copy) NSString * mDimNew13Text;
@property (nonatomic, strong) NSString * mDimNew14Text;
@property (nonatomic, strong) NSString * mDimNew16Text;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger price1;
@property (nonatomic, assign) NSInteger price2;
@property (nonatomic, assign) NSInteger price3;
@property (nonatomic, assign) NSInteger price4;
@property (nonatomic, assign) NSInteger price5;
@property (nonatomic, assign) NSInteger price6;
@property (nonatomic, assign) NSInteger price8;

@property (nonatomic, assign) NSInteger mProductId;
@property (nonatomic, assign) NSInteger mDimNew13Id;
@property (nonatomic, assign) NSInteger mDimNew14Id;
@property (nonatomic, assign) NSInteger mDimNew16Id;
@property (nonatomic, copy) NSString *xwValue;
@property (nonatomic, copy) NSString *ycValue;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger closeStatus;
@property (nonatomic, assign) NSInteger ownerid;
@property (nonatomic, assign) NSInteger *modifierid;
@property (nonatomic, copy) NSString *creationdate;
@property (nonatomic, copy) NSString *modifieddate;
@property (nonatomic, copy) NSString *isactive;

@property (nonatomic, assign) NSInteger adClientId;
@property (nonatomic, assign) NSInteger adOrgId;


@end
