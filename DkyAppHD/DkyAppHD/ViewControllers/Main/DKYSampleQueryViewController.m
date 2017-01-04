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

@interface DKYSampleQueryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) DKYSearchView *searchView;

@property (nonatomic, weak) DKYFiltrateView *filtrateView;

@property (nonatomic, weak) UIButton *backgroundBtn;

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

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


#pragma mark - action method

- (void)backgroundBtnClicked:(UIButton*)sender{
    [self hideBackgroundMask:YES animated:YES];
    [self hideFilterView:YES animated:YES];
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
        [self.view bringSubviewToFront:self.filtrateView];
        [self.view bringSubviewToFront:self.searchView];
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
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar tw_setStatusBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    [self.navigationController.navigationBar tw_hideNavigantionBarBottomLine:YES];
    
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
            self.sampleCount = 20;
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView reloadData];
        });
    }];
    header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@Key",[self class]];
    self.collectionView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.sampleCount += 20;
            [weakSelf.collectionView.mj_footer endRefreshing];
            [weakSelf.collectionView reloadData];
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
    return self.sampleCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DKYSampleQueryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DKYSampleQueryViewCell class]) forIndexPath:indexPath];
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
    
}


@end
