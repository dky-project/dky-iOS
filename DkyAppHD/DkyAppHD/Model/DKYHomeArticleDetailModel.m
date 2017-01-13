//
//  DKYHomeArticleDetailModel.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/12.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHomeArticleDetailModel.h"

@implementation DKYHomeArticleDetailModel

+ (NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"Id" : @"id"};
}

- (NSURL*)getHtmlStringFile{
    NSString *htmlString = [self getHtmlString];
    
    NSString *path = [NSString applicationCacheDirectory];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.html",@(self.Id),self.title];
    path = [path stringByAppendingPathComponent:fileName];
    [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *fileUrl = [NSURL fileURLWithPath:path];
    
    BOOL bret = [htmlString writeToURL:fileUrl atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(!bret){
        DLog(@"htmlString write fo file fail");
    }
    return bret ? fileUrl : nil;
}

- (NSString *)getHtmlString{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<title>%@</title>",self.title];
    [html appendString:@"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"SXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#f6f6f6\">"];
    [html appendString:[self getBodyString]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    return html;
}

- (NSString*)getBodyString{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.title];
    [body appendString:@"<!--IMG#0-->"];
    [body appendFormat:@"<p>%@</p>",self.decription];
    
    if (self.imageurl.length > 0 ) {
        NSMutableString *imgHtml = [NSMutableString string];
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        CGFloat width = kScreenWidth - 50;
        CGFloat height = kScreenHeight - 200;

        [imgHtml appendFormat:@"<img style=\"max-width:%@ max-height:%@\" src=\"%@\">",@(width),@(height),self.imageurl];
        [imgHtml appendString:@"</div>"];
        [body replaceOccurrencesOfString:@"<!--IMG#0-->" withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    
    
    return body;
}

@end
