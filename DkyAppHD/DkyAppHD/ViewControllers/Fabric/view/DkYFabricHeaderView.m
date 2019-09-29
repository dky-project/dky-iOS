//
//  DkYFabricHeaderView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2019/9/10.
//  Copyright © 2019 haKim. All rights reserved.
//

#import "DkYFabricHeaderView.h"

@interface DkYFabricHeaderView ()

@property (nonatomic, weak) TTTAttributedLabel *titleLabel;

@end

@implementation DkYFabricHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    
    self.titleLabel.text = title;
}

- (void)commonInit{
    //self.backgroundColor = [UIColor randomColor];
    [self setupTitleLabel];
}

- (void)setupTitleLabel{
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:35];
    [self addSubview:label];
    self.titleLabel = label;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(92);
        make.bottom.mas_equalTo(-6);
    }];
}

@end
