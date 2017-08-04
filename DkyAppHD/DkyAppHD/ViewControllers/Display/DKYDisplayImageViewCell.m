//
//  DKYDisplayImageViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayImageViewCell.h"
#import "DKYDisplaySmallImageView.h"

@interface DKYDisplayImageViewCell ()

@property (nonatomic, weak) UIImageView *bigImageView;

@property(nonatomic, strong) QMUIGridView *gridView;

@end

@implementation DKYDisplayImageViewCell

+ (instancetype)displayImageViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYDisplayImageViewCell";
    DKYDisplayImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYDisplayImageViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bigImageView setNeedsLayout];
    [self.bigImageView layoutIfNeeded];
    
    DLog(@"%@",NSStringFromCGRect(self.bigImageView.frame));
    
    self.gridView.frame = CGRectMake(kScreenWidth - 32 - 400, 0, 400, 436);
}

#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    
    [self setupBigImageView];
    [self setupGridView];
}

- (void)setupBigImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:imageView];
    self.bigImageView = imageView;
    
    WeakSelf(weakSelf);
    [self.bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).with.offset(32);
        make.top.mas_equalTo(weakSelf.contentView);
        make.bottom.mas_equalTo(weakSelf.contentView);
        make.width.mas_equalTo(300);
    }];
    
    self.bigImageView.backgroundColor = [UIColor randomColor];
}

- (void)setupGridView{
    QMUIGridView *gridView = [[QMUIGridView alloc] init];
    [self.contentView addSubview:gridView];
    self.gridView = gridView;
    
    
    NSInteger count = (arc4random() % 8 + 3 - 1) % 3;
    count = 3;
    
    self.gridView.columnCount = 3;
    self.gridView.rowHeight = (436 - 5 * 2) / 3;
    self.gridView.separatorWidth = 5;
    self.gridView.separatorColor = [UIColor whiteColor];
    self.gridView.separatorDashed = NO;
    
//    WeakSelf(weakSelf);
//    [self.gridView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(weakSelf.bigImageView);
//        make.centerY.mas_equalTo(weakSelf.contentView);
//        make.left.mas_equalTo(weakSelf.bigImageView.mas_right).with.offset(52);
//    }];
    
    for (NSInteger i = 0; i < 8; ++i) {
        DKYDisplaySmallImageView *imageView = [[DKYDisplaySmallImageView alloc]initWithFrame:CGRectZero];
        imageView.kuanhao = [NSString stringWithFormat:@"款号%@",@(i)];
        [self.gridView addSubview:imageView];
    }
}

@end
