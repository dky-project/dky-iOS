//
//  DKYImageLisViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2019/9/2.
//  Copyright © 2019 haKim. All rights reserved.
//

#import "DKYFabricViewController.h"
#import "DkYFabricHeaderView.h"
#import "FabricCollectionViewCell.h"
#import "DKYFabricImageViewController.h"
#import "DKYProductImgCategoryModel.h"
#import "DKYProductImgModel.h"

@interface DKYFabricViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, copy) NSMutableArray *productImageList;

@end

@implementation DKYFabricViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didInitialize{
    [super didInitialize];
    
    [self commonInit];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    WeakSelf(weakSelf);
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - 网络接口
- (void)getProductImgListFromServer{
    WeakSelf(weakSelf);

    DKYHttpRequestParameter *p = [[DKYHttpRequestParameter alloc] init];
    self.pageNum = 1;
    p.pageNo = @(self.pageNum);
    p.pageSize = @(kPageSize);
    
    [[DKYHttpRequestManager sharedInstance] getProductImgListwithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        
        [weakSelf.collectionView.mj_header endRefreshing];
        
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            NSArray *prodcuts = [DKYProductImgCategoryModel mj_objectArrayWithKeyValuesArray:result.data];
            [self.productImageList removeAllObjects];
            
            [self.productImageList addObjectsFromArray:prodcuts];
            [weakSelf.collectionView reloadData];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [weakSelf.collectionView.mj_header endRefreshing];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

- (void)loadMoreProductImgListFromServer{
    WeakSelf(weakSelf);
    DKYHttpRequestParameter *p = [[DKYHttpRequestParameter alloc] init];
    NSInteger pageNum = self.pageNum;
    p.pageNo = @(++pageNum);
    p.pageSize = @(kPageSize);
    
    [[DKYHttpRequestManager sharedInstance] getProductImgListwithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        [weakSelf.collectionView.mj_footer endRefreshing];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            NSArray *prodcuts = [DKYProductImgCategoryModel mj_objectArrayWithKeyValuesArray:result.data];
            [weakSelf.productImageList addObjectsFromArray:prodcuts];
            weakSelf.pageNum++;
            [weakSelf.collectionView reloadData];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [weakSelf.collectionView.mj_footer endRefreshing];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

#pragma mark - delegate
- (nullable UIImage *)navigationBarBackgroundImage{
    return [UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]];
}

- (nullable UIColor *)titleViewTintColor{
    return [UIColor whiteColor];
}

#pragma mark - collectionView delegate & datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return self.productImageList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    DKYProductImgCategoryModel *category = [self.productImageList objectOrNilAtIndex:section];
    
    return category.imgList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FabricCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FabricCollectionViewCell class]) forIndexPath:indexPath];
    DKYProductImgCategoryModel *category = [self.productImageList objectOrNilAtIndex:indexPath.section];
    cell.imgModel = [category.imgList objectOrNilAtIndex:indexPath.item];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(170, 105);
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
    minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 39;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
    minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 21;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = {0,90,0,90};
    return insets;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DKYFabricImageViewController *vc = [[DKYFabricImageViewController alloc] init];
    DKYProductImgCategoryModel *category = [self.productImageList objectOrNilAtIndex:indexPath.section];
    vc.productImgModel = [category.imgList objectOrNilAtIndex:indexPath.item];
    
    [self.navigationController qmui_pushViewController:vc animated:YES completion:^{
        
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return CGSizeMake(SCREEN_WIDTH, 90);
    }
    
    return CGSizeMake(SCREEN_WIDTH, 84.5);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        DkYFabricHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([DkYFabricHeaderView class]) forIndexPath:indexPath];
        
        DKYProductImgCategoryModel *category = [self.productImageList objectOrNilAtIndex:indexPath.section];
        header.title = category.dimText;
        return header;
    }
    
    return nil;
}

#pragma common init
- (void)commonInit{
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupCollectionView];
}

- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 28;
    flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.bounces = YES;
    collectionView.alwaysBounceVertical = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
    
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [collectionView registerClass:[FabricCollectionViewCell class]forCellWithReuseIdentifier:NSStringFromClass([FabricCollectionViewCell class])];
    
    [collectionView registerClass:[DkYFabricHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([DkYFabricHeaderView class])];
    
    WeakSelf(weakSelf);
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
    }];
    
    self.collectionView = collectionView;
    [self setupRefreshControl];
}

-(void)setupRefreshControl{
    WeakSelf(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(){
        [weakSelf getProductImgListFromServer];
    }];
    header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@Key",[self class]];
    self.collectionView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
        [weakSelf loadMoreProductImgListFromServer];
    }];
    footer.automaticallyHidden = YES;
    self.collectionView.mj_footer = footer;
    
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - getter
- (NSMutableArray *)productImageList{
    if(_productImageList== nil){
        _productImageList = [NSMutableArray array];
    }
    return _productImageList;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
