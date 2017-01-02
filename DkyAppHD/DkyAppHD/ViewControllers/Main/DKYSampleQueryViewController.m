//
//  DKYSampleQueryViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/1/2.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleQueryViewController.h"
#import "DKYSampleQueryViewCell.h"

@interface DKYSampleQueryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

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

#pragma mark - UI

- (void)commonInit{
    self.navigationItem.title = nil;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar tw_setStatusBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    [self.navigationController.navigationBar tw_hideNavigantionBarBottomLine:YES];
    
    [self setupCollectionView];
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

-(void)setupRefreshControl{
    WeakSelf(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.sampleCount = 20;
            [weakSelf.collectionView.mj_header endRefreshing];
            [weakSelf.collectionView reloadData];
        });
    }];
    header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@Key",[self class]];
    self.collectionView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
