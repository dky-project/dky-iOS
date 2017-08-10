//
//  DKYDisplayImageViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayImageViewCell.h"
#import "DKYDisplaySmallImageView.h"
#import "DKYGetProductListByGroupNoModel.h"

#define kSmallImageWidth           (174.5)
#define kSmallImageHeight          (273.5)
#define kMargin                    (2)

@interface DKYDisplayImageViewCell ()

@property (nonatomic, weak) UIImageView *bigImageView;

@property(nonatomic, strong) QMUIGridView *gridView;

@property(nonatomic, strong) QMUIGridView *lineGridView;

@property (nonatomic, strong) NSMutableArray *topImageViews;

@property (nonatomic, strong) NSMutableArray *bottomImageViews;
@property (nonatomic, strong) NSArray *smallImages;

@property (nonatomic, strong) NSMutableArray *imageViews;

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

- (void)setProductList:(NSArray *)productList{
    _productList = productList;
    
    NSMutableArray *marr = [NSMutableArray arrayWithCapacity:productList.count];
    [self.productList enumerateObjectsUsingBlock:^(DKYGetProductListByGroupNoModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [marr addObject:obj.imgUrl];
    }];
    
    self.smallImages = marr.copy;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger count = self.productList.count > 4 ? 4 : self.productList.count;
    
    for (NSInteger i = 0; i < count; ++i) {
        DKYDisplaySmallImageView *imageView = [self.imageViews objectAtIndex:i];
        imageView.getProductListByGroupNoModel = [self.productList objectAtIndex:i];
        
        imageView.hidden = NO;
    }
    
    for (NSInteger i = count; i < 4; ++i) {
        DKYDisplaySmallImageView *imageView = [self.imageViews objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    // 下面一行
    if(self.productList.count <= 4){
        self.lineGridView.hidden = YES;
        return;
    }
    
    self.lineGridView.hidden = NO;
    
    for (NSInteger i = count; i < self.productList.count; ++i) {
        DKYDisplaySmallImageView *imageView = [self.imageViews objectAtIndex:i];
        imageView.getProductListByGroupNoModel = [self.productList objectAtIndex:i];
        imageView.hidden = NO;
    }
    
    for (NSInteger i = self.productList.count; i < 8; ++i) {
        DKYDisplaySmallImageView *imageView = [self.imageViews objectAtIndex:i];
        imageView.hidden = YES;
    }
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
    
    gridView = [[QMUIGridView alloc] init];
    [self.contentView addSubview:gridView];
    self.lineGridView = gridView;
    
    CGFloat height = kSmallImageHeight * 2 + kMargin;
    
    self.gridView.columnCount = 2;
    self.gridView.rowHeight = (height - kMargin) / 2;
    self.gridView.separatorWidth = 2;
    self.gridView.separatorColor = [UIColor whiteColor];
    self.gridView.separatorDashed = NO;

    // 1行 4个
    self.lineGridView.columnCount = 4;
    self.lineGridView.rowHeight = kSmallImageHeight;
    self.lineGridView.separatorWidth = 2;
    self.lineGridView.separatorColor = [UIColor whiteColor];
    self.lineGridView.separatorDashed = NO;
    
    
    height = kSmallImageHeight * 2 + kMargin;
    CGFloat width = kSmallImageWidth * 2 + kMargin;
    self.gridView.frame = CGRectMake(kScreenWidth - 32 - width, 0, width, height);
    self.lineGridView.frame = CGRectMake(32, height + kMargin, kScreenWidth - 32 * 2, kSmallImageHeight);
    
    for (NSInteger i = 0; i < 4; ++i) {
        DKYDisplaySmallImageView *imageView = [[DKYDisplaySmallImageView alloc]initWithFrame:CGRectZero];
        [self.gridView addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
    
    for (NSInteger i = 0; i < 4; ++i) {
        DKYDisplaySmallImageView *imageView = [[DKYDisplaySmallImageView alloc]initWithFrame:CGRectZero];
        [self.lineGridView addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
}

#pragma mark - get & set method

- (NSMutableArray*)imageViews{
    if(_imageViews == nil){
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (NSMutableArray*)topImageViews{
    if(_topImageViews == nil){
        _topImageViews = [NSMutableArray array];
    }
    return _topImageViews;
}

- (NSMutableArray*)bottomImageViews{
    if(_bottomImageViews == nil){
        _bottomImageViews = [NSMutableArray array];
    }
    return _bottomImageViews;
}

@end
