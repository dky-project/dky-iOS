//
//  DKYProductApproveTitleModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/21.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYProductApproveTitleModel.h"

@implementation DKYProductApproveTitleModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    self.dimList = @"{ 'DIMFLAG_NEW24':[{'id':'32','attribname':'17-85' }]}";
    
    NSString *test1 =  @"{ \"DIMFLAG_NEW24\":[{\"id\":\"32\",\"attribname\":\"17-85\" }]}";
    
    self.dimListDict = [self.dimList jsonValueDecoded];
    
    NSDictionary *dict = [test1 jsonValueDecoded];
    NSLog(@"dict = %@",dict);
}

@end
