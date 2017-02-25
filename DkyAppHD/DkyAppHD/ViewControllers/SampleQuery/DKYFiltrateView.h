//
//  DKYFiltrateView.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKYDimNewListModel,DKYSampleQueryParameter;
@interface DKYFiltrateView : UIView

//@property (nonatomic, strong) NSArray *sexEnums;
//@property (nonatomic, strong) NSArray *bigClassEnums;

@property (nonatomic, strong) DKYDimNewListModel *dimNewListModel;

@property (nonatomic, strong) DKYSampleQueryParameter *sampleQueryParameter;

//@property (nonatomic, assign) NSNumber *selectedSex;
//
//@property (nonatomic, assign) NSNumber *selectedBigClas;



@property (nonatomic, copy) NSString *name;

@end
