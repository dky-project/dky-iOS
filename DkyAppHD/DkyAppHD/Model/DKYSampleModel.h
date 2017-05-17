//
//  DKYSampleModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYSampleModel : NSObject

@property (nonatomic, copy) NSString * imgUrl1;
@property (nonatomic, assign) NSInteger mProductId;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString *mDimNew11Text;

// 客户端自己的属性
@property (nonatomic, copy) NSString *sampleId;
@property (nonatomic, weak) NSIndexPath *indexPath;

@end
