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
#import "PYPhotoBrowser.h"

#define kSmallImageWidth           (174.5)
#define kSmallImageHeight          (273.5)
#define kMargin                    (2)

@interface DKYDisplayImageViewCell ()<PYPhotoBrowseViewDelegate>

@property (nonatomic, weak) UIImageView *bigImageView;

@property(nonatomic, strong) QMUIGridView *gridView;

@property(nonatomic, strong) QMUIGridView *lineGridView;

@property (nonatomic, strong) NSMutableArray *topImageViews;

@property (nonatomic, strong) NSMutableArray *bottomImageViews;
@property (nonatomic, strong) NSArray *smallImages;

@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, weak) UILabel *groupNoLabel;

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

- (void)setBigImageUrl:(NSString *)bigImageUrl{
    _bigImageUrl = bigImageUrl;
    
    WeakSelf(weakSelf);
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:bigImageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(error){
            weakSelf.bigImageView.image = [UIImage imageWithColor:[UIColor randomColor]];
        }
    }];
}

- (void)setGroupNo:(NSString *)groupNo{
    _groupNo = [groupNo copy];
    
    self.groupNoLabel.text = [NSString stringWithFormat:@"搭配组：%@",groupNo];
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

- (void)showPhotoBroseView:(NSArray*)imgList currentIndex:(NSInteger)index originView:(UIView*)originView{
    // 点击图片，显示图片浏览器
    
    // 1. 创建photoBroseView对象
    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
    
    // 2.1 设置图片源(UIImageView)数组
    photoBroseView.imagesURL = imgList;
    
    // 2.2 设置初始化图片下标（即当前点击第几张图片）
    photoBroseView.currentIndex = index;
    
    CGRect frameFormWindow = [originView.superview convertRect:originView.frame toView:[UIApplication sharedApplication].keyWindow];
    photoBroseView.frameFormWindow = frameFormWindow;
    photoBroseView.frameToWindow = frameFormWindow;
    
    // 不转屏
    photoBroseView.autoRotateImage = NO;
    
    // 动画时间
    photoBroseView.showDuration = 0.78;
    photoBroseView.hiddenDuration = 0.78;
    
    // 设置代理
    photoBroseView.delegate = self;
    
    // 3.显示(浏览)
    [photoBroseView show];

}

#pragma mark - PYPhotoBrowseViewDelegate

- (void)photoBrowseView:(PYPhotoBrowseView *)photoBrowseView didLongPressImage:(UIImage *)image index:(NSInteger)index{
    // 长按图片浏览器，相应的时间，类似微信，弹出一个action sheet，有相应的操作。
    //    [self showOptionsPicker];
}


#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    
    [self setupBigImageView];
    //[self setupGroupNoLabel];
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
    
    [self.bigImageView sd_setShowActivityIndicatorView:YES];
    [self.bigImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //self.bigImageView.backgroundColor = [UIColor randomColor];
    
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf showPhotoBroseView:@[weakSelf.bigImageUrl] currentIndex:0 originView:weakSelf.bigImageView];
    }];
    [imageView addGestureRecognizer:tap];
}

- (void)setupGroupNoLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:label];
    self.groupNoLabel = label;
    
    WeakSelf(weakSelf);
    [self.groupNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.bigImageView);
        make.top.mas_equalTo(weakSelf.bigImageView.mas_bottom).with.offset(5);
        make.bottom.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.bigImageView);
    }];
}

- (void)setupGridView{
    WeakSelf(weakSelf);
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
        imageView.tag = i;
        [self.gridView addSubview:imageView];
        [self.imageViews addObject:imageView];
        
        imageView.imageTaped = ^(UIImageView *sender) {
            NSInteger index = sender.superview.tag;
            [weakSelf showPhotoBroseView:weakSelf.smallImages currentIndex:index originView:sender];
        };
    }
    
    for (NSInteger i = 0; i < 4; ++i) {
        DKYDisplaySmallImageView *imageView = [[DKYDisplaySmallImageView alloc]initWithFrame:CGRectZero];
        imageView.tag = i + 4;
        [self.lineGridView addSubview:imageView];
        [self.imageViews addObject:imageView];
        
        imageView.imageTaped = ^(UIImageView *sender) {
            NSInteger index = sender.superview.tag;
            [weakSelf showPhotoBroseView:weakSelf.smallImages currentIndex:index originView:sender];
        };
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
