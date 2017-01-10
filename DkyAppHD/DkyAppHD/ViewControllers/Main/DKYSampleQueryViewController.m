//
//  DKYSampleQueryViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleQueryViewController.h"
#import "DKYSampleQueryViewCell.h"
#import "DKYSearchView.h"
#import "DKYFiltrateView.h"
#import "DKYSampleDetailViewController.h"
#import "DKYSampleModel.h"
#import "DKYSexEnumModel.h"
#import "DKYBigClassEnumModel.h"
#import "DKYSampleQueryParameter.h"

@interface DKYSampleQueryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) DKYSearchView *searchView;

@property (nonatomic, weak) DKYFiltrateView *filtrateView;

@property (nonatomic, weak) UIButton *backgroundBtn;

@property (nonatomic, strong) NSMutableArray *samples;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, strong) dispatch_group_t group;

@property (nonatomic, strong) NSArray *sexEnums;

@property (nonatomic, strong) NSArray *bigClassEnums;

// 测试数据
@property (nonatomic, assign) NSInteger sampleCount;

@end

@implementation DKYSampleQueryViewController

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
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    self.navigationController.navigationBar.alpha = 1.0;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    self.navigationController.navigationBar.alpha = 0;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 网络请求
- (void)getProductPageFromServer{
    WeakSelf(weakSelf);
    dispatch_group_enter(self.group);
    DKYSampleQueryParameter *p = [[DKYSampleQueryParameter alloc] init];
    self.pageNum = 1;
    p.pageNo = @(self.pageNum);
    p.pageSize = @(kPageSize);
    p.mDimNew11Id = self.filtrateView.selectedBigClas;
    p.mDimNew13Id = self.filtrateView.selectedSex;

    [[DKYHttpRequestManager sharedInstance] productPageWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            NSArray *samples = [DKYSampleModel mj_objectArrayWithKeyValuesArray:page.items];
            [weakSelf.samples removeAllObjects];
            [weakSelf.samples addObjectsFromArray:samples];
        }else if (retCode == DkyHttpResponseCode_Unset) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        dispatch_group_leave(weakSelf.group);
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool showErrorWithStatus:kNetworkError];
        dispatch_group_leave(weakSelf.group);
    }];
}

- (void)loadMoreProductPageFromServer{
    WeakSelf(weakSelf);
    DKYSampleQueryParameter *p = [[DKYSampleQueryParameter alloc] init];
    NSInteger pageNum = self.pageNum;
    p.pageNo = @(++pageNum);
    p.pageSize = @(kPageSize);
    p.mDimNew11Id = self.filtrateView.selectedBigClas;
    p.mDimNew13Id = self.filtrateView.selectedSex;
    
    [[DKYHttpRequestManager sharedInstance] productPageWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        [weakSelf.collectionView.mj_footer endRefreshing];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            NSArray *samples = [DKYSampleModel mj_objectArrayWithKeyValuesArray:page.items];
            [weakSelf.samples addObjectsFromArray:samples];
            weakSelf.pageNum++;
            [weakSelf.collectionView reloadData];
        }else if (retCode == DkyHttpResponseCode_Unset) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
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

- (void)getSexEnumFromServer{
    WeakSelf(weakSelf);
    dispatch_group_enter(self.group);
    
    [[DKYHttpRequestManager sharedInstance] getSexEnumWithParameter:nil Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        [weakSelf.collectionView.mj_header endRefreshing];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.sexEnums = [DKYSexEnumModel mj_objectArrayWithKeyValuesArray:result.data];
            
        }else if (retCode == DkyHttpResponseCode_Unset) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        dispatch_group_leave(weakSelf.group);
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [weakSelf.collectionView.mj_header endRefreshing];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
        dispatch_group_leave(weakSelf.group);
    }];
    
}

- (void)getBigClassEnumFromServer{
    WeakSelf(weakSelf);
    dispatch_group_enter(self.group);
    
    [[DKYHttpRequestManager sharedInstance] getBigClassEnumWithParameter:nil Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        [weakSelf.collectionView.mj_header endRefreshing];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.bigClassEnums = [DKYBigClassEnumModel mj_objectArrayWithKeyValuesArray:result.data];
            
        }else if (retCode == DkyHttpResponseCode_Unset) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        dispatch_group_leave(weakSelf.group);
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [weakSelf.collectionView.mj_header endRefreshing];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
        dispatch_group_leave(weakSelf.group);
    }];
}

- (void)doHttpRequest{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    [self getProductPageFromServer];
    [self getSexEnumFromServer];
    [self getBigClassEnumFromServer];
    
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        [DKYHUDTool dismiss];
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView reloadData];
        weakSelf.filtrateView.sexEnums = weakSelf.sexEnums;
        weakSelf.filtrateView.bigClassEnums = weakSelf.bigClassEnums;
    });
}

#pragma mark - action method

- (void)backgroundBtnClicked:(UIButton*)sender{
    [self hideBackgroundMask:YES animated:YES];
    [self hideFilterView:YES animated:YES];
    
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - private method

- (void)hideBackgroundMask:(BOOL)hide animated:(BOOL)animated{
    if(!animated){
        self.backgroundBtn.alpha = hide ? 0.0 : 1.0;
        return;
    }
    [UIView animateWithDuration:0.7 animations:^{
        self.backgroundBtn.alpha = hide ? 0.0 : 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideFilterView:(BOOL)hide animated:(BOOL)animated{
    CGRect frame = CGRectZero;
    if(!hide) {
        // 显示
        [self.filtrateView.superview bringSubviewToFront:self.filtrateView];
        [self.searchView.superview bringSubviewToFront:self.searchView];
        frame = CGRectMake(26, 48, kScreenWidth - 26 * 2, 290);
        self.filtrateView.alpha = hide ? 0.0 : 1.0;
    }else{
        frame = CGRectMake(self.searchView.centerX, self.searchView.centerY, 0, 0);
    }
    
    if(!animated){
        self.filtrateView.frame = frame;
        self.filtrateView.alpha = hide ? 0.0 : 1.0;
        return;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.filtrateView.frame = frame;
        self.filtrateView.alpha = hide ? 0.0 : 1.0;
    } completion:^(BOOL finished) {
    }];
}


#pragma mark - UI

- (void)commonInit{
    self.navigationItem.title = nil;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.group = dispatch_group_create();
    
    [self setupCollectionView];
    
    [self setupBackgroundBtn];
    [self setupSearchView];
    [self setupFiltrateView];
    
//    for (int i = 1; i < 6; ++i) {
//        NSString *imageName = [NSString stringWithFormat:@"sampleImage%@",@(i)];
//        UIImage *image = [UIImage imageNamed:imageName];
//        [self.samples addObject:image];
//    }
}

- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 28;
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
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DKYSampleQueryViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DKYSampleQueryViewCell class])];
    
    WeakSelf(weakSelf);
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(20);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
    }];
    
    self.collectionView = collectionView;
    [self setupRefreshControl];
}

- (void)setupSearchView{
    DKYSearchView *view = [[DKYSearchView alloc] initWithFrame:CGRectZero];
//    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [self.view addSubview:view];
    self.searchView = view;
    
    self.searchView.tw_width = 66;
    self.searchView.tw_height = 66;
    self.searchView.layer.cornerRadius = self.searchView.tw_height / 2.0;
    self.searchView.tw_x  = 14;
    self.searchView.tw_y = 34;
    
    WeakSelf(weakSelf);
    self.searchView.searchBtnClicked = ^(DKYSearchView *searchView){
        [weakSelf hideBackgroundMask:NO animated:YES];
        [weakSelf hideFilterView:NO animated:YES];
    };
}

- (void)setupFiltrateView{
    DKYFiltrateView *view = [[DKYFiltrateView alloc] initWithFrame:CGRectZero];
//    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [self.view addSubview:view];
    self.filtrateView = view;

//    WeakSelf(weakSelf);
//    [self.filtrateView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.view.mas_top).with.offset(48);
//        make.left.equalTo(weakSelf.view.mas_left).with.offset(26);
//        make.right.equalTo(weakSelf.view.mas_right).with.offset(-26);
//        make.height.mas_equalTo(290);
//    }];
    
    self.filtrateView.frame = CGRectMake(26, 48, kScreenWidth - 26 * 2, 290);
    [self hideFilterView:YES animated:NO];
}

- (void)setupBackgroundBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(backgroundBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.backgroundBtn = btn;

    self.backgroundBtn.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.65];
    
    [self.backgroundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self hideBackgroundMask:YES animated:NO];
}

-(void)setupRefreshControl{
    WeakSelf(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf doHttpRequest];
        });
    }];
    header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@Key",[self class]];
    self.collectionView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf loadMoreProductPageFromServer];
        });
    }];
    footer.automaticallyHidden = YES;
    self.collectionView.mj_footer = footer;
    
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - collectionView delegate & datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.samples.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DKYSampleQueryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DKYSampleQueryViewCell class]) forIndexPath:indexPath];
    cell.itemModel = [self.samples objectOrNilAtIndex:indexPath.item];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(220, 290);
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = {28,26,0,26};
    return insets;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    DKYSampleDetailViewController *vc = [[DKYSampleDetailViewController alloc] init];
    DKYSampleDetailViewController *vc = (DKYSampleDetailViewController*)[UIStoryboard viewControllerWithClass:[DKYSampleDetailViewController class]];
    vc.sampleModel = [self.samples objectOrNilAtIndex:indexPath.item];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - get & set method

- (NSMutableArray*)samples{
    if(_samples == nil){
        _samples = [NSMutableArray array];
    }
    return _samples;
}


@end
