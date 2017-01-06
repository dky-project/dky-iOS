//
//  DKYHomeItemView.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/6.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHomeItemView.h"

@interface DKYHomeItemView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DKYHomeItemView

+ (instancetype)homeItemView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self commonInit];
}

#pragma mark - UI
- (void)commonInit{
    self.imageView.image = [UIImage imageNamed:@"image1"];
}


@end
