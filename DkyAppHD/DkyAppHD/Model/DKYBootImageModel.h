//
//  DKYBootImageModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYBootImageModel : NSObject

@property (nonatomic, assign) NSInteger adClientId;
@property (nonatomic, assign) NSInteger adOrgId;
@property (nonatomic, copy) NSString * creationdate;
@property (nonatomic, copy) NSString * enddate;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString * imageurl;
@property (nonatomic, copy) NSString * isactive;
@property (nonatomic, copy) NSString * modifieddate;
@property (nonatomic, assign) NSInteger modifierid;
@property (nonatomic, assign) NSInteger ownerid;
@property (nonatomic, copy) NSString * startdate;
@property (nonatomic, copy) NSString *jumpurl;

@end
