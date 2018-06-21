//
//  DKYRecommendViewController.m
//  DkyAppHD
//
//  Created by HaKim on 2017/8/1.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYRecommendViewController.h"
#import "DKYRecommendSmallImageViewCell.h"
#import "DKYGetProductListByGhParameter.h"
#import "DKYGetProductListByGhModel.h"
#import "DKYRecommendHeaderView.h"
#import "DKYSampleModel.h"
#import "DKYSampleDetailAllViewController.h"
#import "DKYDisplayBigImaeViewCell.h"
#include "DKYDisplayViewController.h"

@interface DKYRecommendViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) DKYRecommendHeaderView *headerView;

@property (nonatomic, strong) NSArray *productList;

@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger totalPageNum;

@property (nonatomic, assign) NSInteger gh_;

@property (nonatomic, strong) NSMutableArray *samples;

@property (nonatomic, copy) NSString *bigImageUrl;

@property (nonatomic, copy) NSArray *ghList;

@end

@implementation DKYRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
    
    [self getProductListByGhFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 网络请求
- (void)getProductListByGhFromServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    DKYGetProductListByGhParameter *p = [[DKYGetProductListByGhParameter alloc] init];
    p.gh = self.gh;
    p.hallName = self.hallName;
    
    [[DKYHttpRequestManager sharedInstance] getProductListByGhWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            weakSelf.productList = [DKYGetProductListByGhModel mj_objectArrayWithKeyValuesArray:page.items];
            weakSelf.bigImageUrl = [result.data objectForKey:@"bigImageUrl"];
            [weakSelf setupSanmples];
            
            weakSelf.pageNo = page.pageNo;
            weakSelf.totalPageNum = page.totalPageNum;
            
            weakSelf.ghList = page.ghList;
            weakSelf.gh = p.gh;
            
            NSInteger index = 0;
            for(NSString* gp in page.ghList){
                if([weakSelf.gh isEqualToString:gp]){
                    weakSelf.gh_ = index;
                    break;
                }
                ++index;
            }
            
            weakSelf.headerView.gh = weakSelf.gh;
            [weakSelf.collectionView reloadData];
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
        [DKYHUDTool dismiss];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

#pragma mark - private method
- (void)setupSanmples{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.productList.count];
    
    for(DKYGetProductListByGhModel *model in self.productList){
        DKYSampleModel *sample = [[DKYSampleModel alloc] init];
        sample.name = model.productName;
        sample.mProductId = [model.mProductId integerValue];
        sample.imgUrl1 = model.imgUrl;
        sample.iscollect = model.iscollect;
        
        sample.sampleId = [NSString stringWithFormat:@"%@",@(sample.mProductId)];
        
        sample.collected = ([sample.iscollect integerValue] == 2) ? YES : NO;
        [array addObject:sample];
    }
    
    self.samples = [array copy];
}

#pragma mark - collectionView delegate & datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    
    return self.productList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        DKYDisplayBigImaeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DKYDisplayBigImaeViewCell class]) forIndexPath:indexPath];
        cell.bigImageUrl = self.bigImageUrl;
        return cell;
    }
    
    DKYRecommendSmallImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DKYRecommendSmallImageViewCell class]) forIndexPath:indexPath];
    
    cell.getProductListByGhModel = [self.productList objectOrNilAtIndex:indexPath.item];
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeZero;
    if(indexPath.section == 0 && indexPath.item == 0) {
        size = CGSizeMake(683, 512);
        return size;
    }
    
    
    size = CGSizeMake(174, 273.5);
    
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    
    if(section == 0){
        insets = UIEdgeInsetsMake(28, 0, 0, 0);
        return insets;
    }
    
    insets = UIEdgeInsetsMake(12, 26, 0, 26);
    
    return insets;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
//        DKYSampleDetailAllViewController *vc = [[DKYSampleDetailAllViewController alloc] init];
//        vc.samples = self.samples;
//        vc.currentIndex = indexPath.item;
//        vc.issource = @2;
//        [self.navigationController pushViewController:vc animated:YES];
        
        DKYDisplayViewController *vc = [[DKYDisplayViewController alloc] init];
        DKYGetProductListByGhModel *model = [self.productList objectOrNilAtIndex:indexPath.item];
    
        vc.groupNo = model.groupNo;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UI
- (void)commonInit{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCustomTitle:@"FAB下单"];
    
    self.pageNo = 1;
    //self.gh_ = [self.gh integerValue];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]] forBarMetrics:UIBarMetricsDefault];
    
    [self setupHeaderView];
    [self setupCollectionView];
}

- (void)setupHeaderView{
    DKYRecommendHeaderView *headerView = [[DKYRecommendHeaderView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:headerView];
    
    self.headerView = headerView;
    
    WeakSelf(weakSelf);
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view);
        make.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(110);
    }];
    
    self.headerView.preBtnClicked = ^(id sender) {
//        if(self.pageNo <= 1) return;
//        --self.pageNo;
        
        NSInteger gh = self.gh_;
        --gh;
        if(gh < 0 || gh > self.ghList.count) return;
        
        self.gh = [self.ghList objectAtIndex:gh];
        
        [self getProductListByGhFromServer];
    };
    
    self.headerView.nextBtnClicked = ^(id sender) {
//        if(self.pageNo >= self.totalPageNum) return ;
//        ++self.pageNo;
        
        NSInteger gh = self.gh_;
        ++gh;
        
        if(gh < 0 || gh > self.ghList.count) return;
        
        self.gh = [self.ghList objectAtIndex:gh];
        [self getProductListByGhFromServer];
    };
}

- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumInteritemSpacing = 2;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.bounces = YES;
    collectionView.alwaysBounceVertical = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [collectionView registerClass:[DKYRecommendSmallImageViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DKYRecommendSmallImageViewCell class])];
    
//    [collectionView registerClass:[DKYDisplayBigImaeViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DKYDisplayBigImaeViewCell class])];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DKYDisplayBigImaeViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DKYDisplayBigImaeViewCell class])];
    
    WeakSelf(weakSelf);
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.top.mas_equalTo(weakSelf.headerView.mas_bottom);
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    }];
    header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@Key",[self class]];
    self.collectionView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
    footer.automaticallyHidden = YES;
    self.collectionView.mj_footer = footer;
    
    [self.collectionView.mj_header beginRefreshing];
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
