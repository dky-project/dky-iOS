//
//  YYCache+Utility.h
//  DycApp
//
//  Created by HaKim on 16/9/13.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "YYCache.h"

@interface YYCache (Utility)

/**
 *  鼎有财默认的缓存器
 *
 *  @return 返回YYCache缓存对象
 */
+ (instancetype)defaultCache;

/**
 *  保存数组对象
 *
 */
- (void)addObjectArray:(NSArray*)array forKey:(NSString*)key;

@end
