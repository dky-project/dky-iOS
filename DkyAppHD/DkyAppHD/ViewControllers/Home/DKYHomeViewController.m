//
//  DKYHomeViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHomeViewController.h"
#import "DKYHomeItemView.h"
#import "DKYHomeItemTwoView.h"
#import "DKYHomeArticleModel.h"
#import "DKYHomeCellTableViewCell.h"
#import "TWLineLayout.h"
#import "DKYHomeItemViewCell.h"
#import "DKYHomeItemTwoViewCell.h"
#import "DKYHomeArticleDetailModel.h"

@interface DKYHomeViewController ()<iCarouselDelegate,iCarouselDataSource,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,TWLineLayoutDelegate>

@property (nonatomic,weak) iCarousel *iCarousel;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) id<DKYHomeItemDelegate> previousItemView;

@property (nonatomic, strong) NSMutableArray *articels;

@property (nonatomic, copy) NSIndexPath *prevIndex;

@end

@implementation DKYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar tw_setStatusBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    [self.navigationController.navigationBar tw_hideNavigantionBarBottomLine:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar lt_reset];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.navigationController.navigationBar tw_setStatusBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 网络请求
- (void)getArticalPageFromServer{
    WeakSelf(weakSelf);
//    [DKYHUDTool show];
    [[DKYHttpRequestManager sharedInstance] articlePageWithParameter:nil Success:^(NSInteger statusCode, id data) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            [weakSelf.articels removeAllObjects];
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            NSArray *articles = [DKYHomeArticleModel mj_objectArrayWithKeyValuesArray:page.items];
            [weakSelf.articels addObjectsFromArray:articles];
            [weakSelf.collectionView reloadData];
        }else if (retCode == DkyHttpResponseCode_Unset) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
    } failure:^(NSError *error) {
        [DKYHUDTool dismiss];
        [weakSelf.collectionView.mj_header endRefreshing];
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

- (void)getArticleDetaiFromServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    DKYHttpRequestParameter *p = [[DKYHttpRequestParameter alloc] init];
    p.Id = @1;
    
    [[DKYHttpRequestManager sharedInstance] articleDetaiWithParameter:p Success:^(NSInteger statusCode, id data) {
        [DKYHUDTool dismiss];
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYHomeArticleDetailModel *detailModel = [DKYHomeArticleDetailModel mj_objectWithKeyValues:result.data];
            [weakSelf goToWebviewController:detailModel.jumpurl];
        }else if (retCode == DkyHttpResponseCode_Unset) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
    } failure:^(NSError *error) {
        [DKYHUDTool dismiss];
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

#pragma mark - private method
- (UIView*)createItemViewWithIndex:(NSInteger)index{
    UIView *view = nil;
    if(index % 2 == 0){
        view = [DKYHomeItemView homeItemView];
        if(index == 0){
            id<DKYHomeItemDelegate> itemView = (id<DKYHomeItemDelegate>)view;
            self.previousItemView = itemView;
        }
    }else{
        view = [DKYHomeItemTwoView homeItemTwoView];
        if(index == 1){
            id<DKYHomeItemDelegate> itemView = (id<DKYHomeItemDelegate>)view;
            [itemView updateFrame:NO];
        }
    }
    return view;
}

- (UIView*)checkItemViewClass:(UIView *)view index:(NSInteger)index{
    if(view == nil){
        view = [self createItemViewWithIndex:index];
    }
    
    if(index % 2 == 0){
        if(![view isKindOfClass:[DKYHomeItemView class]]){
            view = [self createItemViewWithIndex:index];
        }
        DKYHomeItemView *homeItemView = (DKYHomeItemView*)view;
        homeItemView.itemModel = [self.articels objectAtIndex:index];
    }else{
        if(![view isKindOfClass:[DKYHomeItemTwoView class]]){
            view = [self createItemViewWithIndex:index];
        }
        DKYHomeItemTwoView *homeItemView = (DKYHomeItemTwoView*)view;
        homeItemView.itemModel = [self.articels objectAtIndex:index];
    }

    
    return view;
}

- (void)goToWebviewController:(NSString*)url{
    NSURL *URL = nil;
    if([url isKindOfClass:[NSString class]]){
        if(![url hasPrefix:@"http"]){
            url = [NSString stringWithFormat:@"http://%@",url];
        }
        URL = [NSURL URLWithString:url];
    }
    
    DKYWebViewController* webViewController = [[DKYWebViewController alloc] initWithURL:URL];
    [self.navigationController pushViewController:webViewController animated:YES];
    
//    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:URL];
//    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - UI

- (void)commonInit{
    self.navigationItem.title = nil;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self setupiCarousel];
//    [self setupTableView];
    [self setupCollectionView];
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    WeakSelf(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(20);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
    }];
}

- (void)setupiCarousel{
    iCarousel *view = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth , kScreenHeight - 20)];
    [self.view addSubview:view];
    view.delegate = self;
    view.dataSource = self;
    view.bounces = YES;
    view.pagingEnabled = YES;
    view.type = iCarouselTypeCustom;
    view.vertical = YES;
    view.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
//    view.numberOfVisibleItems = 4;
    self.iCarousel = view;
//    [view scrollToItemAtIndex:1 animated:NO];
}

- (void)setupCollectionView{
    // 创建布局
    TWLineLayout *layout = [[TWLineLayout alloc] init];
    CGSize size = CGSizeMake(kScreenWidth, 384);
    layout.itemSize = size;
    layout.minimumInteritemSpacing = 2;
    layout.mydelegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor colorWithHex:0xEEEEEE];;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([DKYHomeItemViewCell class]) bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([DKYHomeItemViewCell class])];
    
    nib = [UINib nibWithNibName:NSStringFromClass([DKYHomeItemTwoViewCell class]) bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([DKYHomeItemTwoViewCell class])];
    
    WeakSelf(weakSelf);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view);
        make.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view).with.offset(20);
        make.bottom.mas_equalTo(weakSelf.view);
    }];
    
    [self setupRefreshControl];
}

-(void)setupRefreshControl{
    WeakSelf(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(){
        [weakSelf getArticalPageFromServer];
    }];
    header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@Key",[self class]];
    self.collectionView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
        
    }];
    footer.automaticallyHidden = YES;
    self.collectionView.mj_footer = footer;
    
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Tapped view number: %@", @(index));
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
//    CATransform3D transform = CATransform3DIdentity;
//    CATransform3DScale(transform, 1.0, 0.5, 1);
//    transform = CATransform3DInvert(transform);
//    [self.previousItemView updateTransform:transform];
//    
    [self.previousItemView hideReadMoreBtn:YES];
    [self.previousItemView updateFrame:YES];
    
    id<DKYHomeItemDelegate> itemView = (id<DKYHomeItemDelegate>)carousel.currentItemView;
    if([itemView respondsToSelector:@selector(hideReadMoreBtn:)]){
        [itemView hideReadMoreBtn:NO];
        [itemView updateFrame:NO];
    }
    self.previousItemView = itemView;
    NSLog(@"Index: %@", @(self.iCarousel.currentItemIndex));
}

#pragma mark - iCarousel代理
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    return [self checkItemViewClass:view index:index];
}

-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
//    NSLog(@"offset = %lf",offset);
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.5f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, 1.0, scale, 1);
    }else{
        transform = CATransform3DScale(transform, 1.0, min_scale, 1);
    }
    
    return CATransform3DTranslate(transform, 0.0, offset * self.iCarousel.itemWidth * 0.9, 0.0);
}

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.articels.count;
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight - 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKYHomeCellTableViewCell *cell = [DKYHomeCellTableViewCell homeCellWithTableView:tableView delegate:self];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.item % 2 == 0){
        DKYHomeItemViewCell *cell = (DKYHomeItemViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DKYHomeItemViewCell class]) forIndexPath:indexPath];
        cell.itemModel = [self.articels objectOrNilAtIndex:0];
        return cell;
    }else{
        DKYHomeItemTwoViewCell *cell = (DKYHomeItemTwoViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DKYHomeItemTwoViewCell class]) forIndexPath:indexPath];
        cell.itemModel = [self.articels objectOrNilAtIndex:0];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"idnexPath = %@",indexPath);
    [self getArticleDetaiFromServer];
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout cellCenteredAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"indexPath = %@",indexPath);
    
    if(self.prevIndex){
        DKYHomeItemViewCell *cell = (DKYHomeItemViewCell*)[collectionView cellForItemAtIndexPath:self.prevIndex];
        [cell hideReadMoreBtn:YES];
    }
    
    DKYHomeItemViewCell *cell = (DKYHomeItemViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell hideReadMoreBtn:NO];
    self.prevIndex = indexPath;
}

#pragma mark - get & set method

- (NSMutableArray*)articels{
    if(_articels == nil){
        _articels = [NSMutableArray array];
    }
    return _articels;
}

@end
