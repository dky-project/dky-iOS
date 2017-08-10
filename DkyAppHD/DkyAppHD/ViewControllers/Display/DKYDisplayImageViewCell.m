//
//  DKYDisplayImageViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayImageViewCell.h"
#import "DKYDisplaySmallImageView.h"

#define kSmallImageWidth           (174.5)
#define kSmallImageHeight          (273.5)
#define kMargin                    (2)

@interface DKYDisplayImageViewCell ()

@property (nonatomic, weak) UIImageView *bigImageView;

@property(nonatomic, strong) QMUIGridView *gridView;

@property(nonatomic, strong) QMUIGridView *lineGridView;

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
    
    CGFloat height = kSmallImageHeight * 2 + kMargin;
    CGFloat width = kSmallImageWidth * 2 + kMargin;
    
    self.gridView.frame = CGRectMake(kScreenWidth - 32 - width, 0, width, height);
    
    self.lineGridView.frame = CGRectMake(32, height + kMargin, kScreenWidth - 32 * 2, kSmallImageHeight);
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
        make.height.mas_equalTo(kSmallImageHeight * 2 + kMargin);
        make.width.mas_equalTo(kSmallImageWidth * 2 + kMargin);
    }];
    
    self.bigImageView.backgroundColor = [UIColor randomColor];
}

- (void)setupGridView{
    QMUIGridView *gridView = [[QMUIGridView alloc] init];
    [self.contentView addSubview:gridView];
    self.gridView = gridView;
    
    
    NSInteger count = (arc4random() % 8 + 3 - 1) % 3;
    count = 2;
    
    CGFloat height = kSmallImageHeight * 2 + kMargin;
    
    self.gridView.columnCount = count;
    self.gridView.rowHeight = (height - kMargin) / 2;
    self.gridView.separatorWidth = 2;
    self.gridView.separatorColor = [UIColor whiteColor];
    self.gridView.separatorDashed = NO;
    
//    WeakSelf(weakSelf);
//    [self.gridView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(weakSelf.bigImageView);
//        make.centerY.mas_equalTo(weakSelf.contentView);
//        make.left.mas_equalTo(weakSelf.bigImageView.mas_right).with.offset(52);
//    }];
    
    for (NSInteger i = 0; i < 4; ++i) {
        DKYDisplaySmallImageView *imageView = [[DKYDisplaySmallImageView alloc]initWithFrame:CGRectZero];
        imageView.kuanhao = [NSString stringWithFormat:@"款号%@",@(i)];
        [self.gridView addSubview:imageView];
    }
    
    gridView = [[QMUIGridView alloc] init];
    [self.contentView addSubview:gridView];
    self.lineGridView = gridView;

    // 1行 4个
    self.lineGridView.columnCount = 4;
    self.lineGridView.rowHeight = kSmallImageHeight;
    self.lineGridView.separatorWidth = 2;
    self.lineGridView.separatorColor = [UIColor whiteColor];
    self.lineGridView.separatorDashed = NO;

    
    for (NSInteger i = 4; i < 8; ++i) {
        DKYDisplaySmallImageView *imageView = [[DKYDisplaySmallImageView alloc]initWithFrame:CGRectZero];
        imageView.kuanhao = [NSString stringWithFormat:@"款号%@",@(i)];
        [self.lineGridView addSubview:imageView];
    }
}

@end
