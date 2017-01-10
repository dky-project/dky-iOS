//
//  DKYOrderBrowserLineItemModel.h
//  DkyAppHD
//
//  Created by HaKim on 17/1/10.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKYOrderBrowserLineItemModel : NSObject

@property (nonatomic, copy) NSString *firstTitle;

@property (nonatomic, copy) NSString *firstContent;

@property (nonatomic, copy) NSString *secondTitle;

@property (nonatomic, copy) NSString *secondContent;

@property (nonatomic, assign) DkyOrderBrowserLineViewType type;

@property (nonatomic, assign) BOOL showBottomLine;

@end
