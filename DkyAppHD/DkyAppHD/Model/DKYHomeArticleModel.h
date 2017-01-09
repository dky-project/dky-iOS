//
//  DKYHomeArticleModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    "id": 1,
//    "ownerid": 893,
//    "modifierid": 1,
//    "creationdate": "2017-01-09 11:07:04",
//    "modifieddate": "2017-01-09 11:07:04",
//    "title": "如何构建实时日志分析系统的？",
//    "decription": "infoQ",
//    "isactive": "Y",
//    "jumpurl": "http://mp.weixin.qq.com/s/4dkaOWtEw-weLBI73A0JzQ"
//}

@interface DKYHomeArticleModel : NSObject

@property (nonatomic, copy) NSString * creationdate;
@property (nonatomic, copy) NSString * decription;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, copy) NSString * isactive;
@property (nonatomic, copy) NSString * jumpurl;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, copy) NSString * modifieddate;
@property (nonatomic, assign) NSInteger modifierid;
@property (nonatomic, assign) NSInteger ownerid;
@property (nonatomic, copy) NSString * title;


@end
