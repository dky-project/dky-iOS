//
//  DKYSampleDetailViewController.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "TWBaseViewController.h"

@class DKYSampleModel,DKYSampleProductInfoModel;
@interface DKYSampleDetailViewController : TWBaseViewController

@property (nonatomic, strong) DKYSampleModel *sampleModel;

@property (nonatomic, strong) DKYSampleProductInfoModel *sampleProductInfo;

@end
