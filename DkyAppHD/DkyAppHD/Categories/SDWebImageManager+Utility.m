//
//  SDWebImageManager+Utility.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "SDWebImageManager+Utility.h"

@implementation SDWebImageManager (Utility)

- (UIImage*)diskImageForUrl:(NSString*)url{
    return [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:url]]];
}

@end
