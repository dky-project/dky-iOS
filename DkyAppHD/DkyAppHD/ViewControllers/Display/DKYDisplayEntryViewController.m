//
//  DKYDisplayEntryViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYDisplayEntryViewController.h"
#import "DKYDisplayViewController.h"
#import "DKYDisplayEntryViewCell.h"
#import "DKYSearchView.h"
#import "DKYDisplayFilterView.h"
#import "DKYGetProductGroupPageParameter.h"

@interface DKYDisplayEntryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) DKYSearchView *searchView;

@property (nonatomic, weak) DKYDisplayFilterView *filtrateView;

@property (nonatomic, weak) UIButton *backgroundBtn;

@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation DKYDisplayEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
- (void)getProductGroupPageFromServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    
    DKYGetProductGroupPageParameter *p = [[DKYGetProductGroupPageParameter alloc] init];
    p.groupNo = @([self.filtrateView.name integerValue]);
    p.groupNo = @1;
    p.pageSize = @(kPageSize);
    self.pageNum = 1;
    p.pageNo = @(self.pageNum);
    
    
    [[DKYHttpRequestManager sharedInstance] getProductGroupPageWithParameter:nil Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        [weakSelf.collectionView.mj_header endRefreshing];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        [DKYHUDTool dismiss];
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [weakSelf.collectionView.mj_header endRefreshing];
        [DKYHUDTool dismiss];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

- (void)loadMoreGetProductGroupPageFromServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    
    DKYGetProductGroupPageParameter *p = [[DKYGetProductGroupPageParameter alloc] init];
    p.groupNo = @([self.filtrateView.name integerValue]);
    p.groupNo = @1;
    p.pageSize = @(kPageSize);
    NSInteger pageNo = self.pageNum;
    p.pageNo = @(++pageNo);
    
    [[DKYHttpRequestManager sharedInstance] getProductGroupPageWithParameter:nil Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            
            
            ++weakSelf.pageNum;
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        [DKYHUDTool dismiss];
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [weakSelf.collectionView.mj_footer endRefreshing];
        [DKYHUDTool dismiss];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

#pragma mark - action method
- (void)backgroundBtnClicked:(UIButton*)sender{
    [self.view endEditing:YES];
    [self hideBackgroundMask:YES animated:YES];
    [self hideFilterView:YES animated:YES];
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)hideFilterView:(BOOL)hide animated:(BOOL)animated{
    CGRect frame = CGRectZero;
    if(!hide) {
        // 显示
        [self.filtrateView.superview bringSubviewToFront:self.filtrateView];
        [self.searchView.superview bringSubviewToFront:self.searchView];
        frame = CGRectMake(26, 28, kScreenWidth - 26 * 2, 120);
        self.filtrateView.alpha = hide ? 0.0 : 1.0;
    }else{
        frame = CGRectMake(self.searchView.centerX, self.searchView.centerY, 0, 0);
    }
    
    if(!animated){
        self.filtrateView.frame = frame;
        self.filtrateView.alpha = hide ? 0.0 : 1.0;
        return;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.filtrateView.frame = frame;
        self.filtrateView.alpha = hide ? 0.0 : 1.0;
    } completion:^(BOOL finished) {
    }];
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

#pragma mark - collectionView delegate & datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DKYDisplayEntryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DKYDisplayEntryViewCell class]) forIndexPath:indexPath];
    
    
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
    DKYDisplayViewController *vc = [[DKYDisplayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UI
- (void)commonInit{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCustomTitle:@"陈列"];
    self.pageNum = 1;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]] forBarMetrics:UIBarMetricsDefault];
    
    [self setupCollectionView];
    
    [self setupBackgroundBtn];
    [self setupSearchView];
    [self setupFiltrateView];
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
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DKYDisplayEntryViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DKYDisplayEntryViewCell class])];
    
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
        [weakSelf getProductGroupPageFromServer];
    }];
    header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@Key",[self class]];
    self.collectionView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
        [weakSelf loadMoreGetProductGroupPageFromServer];
    }];
    footer.automaticallyHidden = YES;
    self.collectionView.mj_footer = footer;
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)setupSearchView{
    DKYSearchView *view = [[DKYSearchView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:view];
    self.searchView = view;
    
    self.searchView.tw_width = 66;
    self.searchView.tw_height = 66;
    self.searchView.layer.cornerRadius = self.searchView.tw_height / 2.0;
    self.searchView.tw_x  = 14;
    self.searchView.tw_y = 14;
    
    WeakSelf(weakSelf);
    self.searchView.searchBtnClicked = ^(DKYSearchView *searchView){
        [weakSelf hideBackgroundMask:NO animated:YES];
        [weakSelf hideFilterView:NO animated:YES];
    };
}

- (void)setupFiltrateView{
    DKYDisplayFilterView *view = [[DKYDisplayFilterView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:view];
    self.filtrateView = view;
    
    self.filtrateView.frame = CGRectMake(26, 28, kScreenWidth - 26 * 2, 120);
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

- (void)setupCustomTitle:(NSString*)title;
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName : titleLabel.font};
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    
    titleLabel.frame = [title boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];;
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;
}

@end
