//
//  YYCache+Utility.m
//  DycApp
//
//  Created by HaKim on 16/9/13.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "YYCache+Utility.h"

static YYCache *defaultCache = nil;

@implementation YYCache (Utility)

+ (instancetype)defaultCache{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCache = [[YYCache alloc] initWithName:@"defaultCache"];
    });
    return defaultCache;
}

- (void)addObjectArray:(NSArray*)array forKey:(NSString*)key{
    if(![array isKindOfClass:[NSArray class]]) return;
    
    NSMutableArray *marray = [NSMutableArray array];
    if([defaultCache containsObjectForKey:key]){
        id cacheObject = [defaultCache objectForKey:key];
        if([cacheObject isKindOfClass:[NSArray class]]){
            [marray addObjectsFromArray:cacheObject];
        }
    }
    
    NSMutableArray *newArray = [array mutableCopy];
    if(marray.count){
        for (id obj in array) {
            for (id oldObj in marray) {
                if([oldObj isEqual:obj]){
                    [newArray removeObject:obj];
                    break;
                }
            }
        }
    }else{
        
    }
    
    [marray addObjectsFromArray:newArray];
    
    [defaultCache setObject:[marray copy] forKey:key];
}

@end
