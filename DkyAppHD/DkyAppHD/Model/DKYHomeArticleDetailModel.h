//
//  DKYHomeArticleDetailModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/12.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYHomeArticleDetailModel : NSObject

@property (nonatomic, assign) NSInteger adClientId;
@property (nonatomic, assign) NSInteger adOrgId;
@property (nonatomic, strong) NSString * creationdate;
@property (nonatomic, strong) NSString * decription;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, strong) NSString * imageurl;
@property (nonatomic, strong) NSString * isactive;
@property (nonatomic, strong) NSString * jumpurl;
@property (nonatomic, strong) NSString * modifieddate;
@property (nonatomic, assign) NSInteger modifierid;
@property (nonatomic, assign) NSInteger ownerid;
@property (nonatomic, strong) NSString * title;

@end
