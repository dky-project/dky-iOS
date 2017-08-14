//
//  DKYSampleProductInfoModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleProductInfoModel.h"

//@property (nonatomic, strong) NSArray *imgList;
//@property (nonatomic, copy) NSString * mDimNew11Text;
//@property (nonatomic, copy) NSString * mDimNew13Text;
//@property (nonatomic, copy) NSString * mptbelongtypeText;
//@property (nonatomic, copy) NSString * name;
//
//// 温馨提示
//@property (nonatomic, copy) NSString *description3;
//
//// 设计说明
//@property (nonatomic, copy) NSString *description5;

@implementation DKYSampleProductInfoModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    if(!self.mDimNew11Text){
        self.mDimNew11Text = @"";
    }
    if(!self.mDimNew13Text){
        self.mDimNew13Text = @"";
    }
    if(!self.mptbelongtypeText){
        self.mptbelongtypeText = @"";
    }
    if(!self.name){
        self.name = @"";
    }
    if(!self.description3){
        self.description3 = @"";
    }
    if(!self.description5){
        self.description5 = @"";
    }
    
    if(!self.description4){
        self.description4 = @"";
    }
    
    if(!self.gw){
        self.gw = @"";
    }
    
    self.isBigOrder = ([self.mptbelongtype caseInsensitiveCompare:@"C"] == NSOrderedSame);
}

@end
