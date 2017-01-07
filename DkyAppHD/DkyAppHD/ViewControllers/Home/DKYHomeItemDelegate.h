//
//  DKYHomeItemDelegate.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/7.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DKYHomeItemDelegate <NSObject>

@optional
- (void)hideReadMoreBtn:(BOOL) hide;

- (void)updateTransform:(CATransform3D)transform;

@end
