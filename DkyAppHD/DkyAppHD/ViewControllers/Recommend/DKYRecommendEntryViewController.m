//
//  DKYRecommendEntryViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/9/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYRecommendEntryViewController.h"
#import "DKYRecommendViewController.h"
#import "DKYRecommendEntryViewCell.h"
#import "DKYSearchView.h"
#import "DKYRecommendFilterView.h"
#import "DKYGetProductListGhPageParameter.h"
#import "DKYGetProductListGhPageModel.h"

@interface DKYRecommendEntryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) DKYSearchView *searchView;

@property (nonatomic, weak) DKYRecommendFilterView *filtrateView;

@property (nonatomic, weak) UIButton *backgroundBtn;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, strong) NSMutableArray *productList;

// 返回按钮回调的block
@property (nonatomic, copy)TWBaseViewControllerRightBtnClickedBlock rightBtnClicked;

@property (nonatomic, strong) TWNavBtnItem *rightBtnItem;

@property (nonatomic, strong) dispatch_group_t group;

@end

@implementation DKYRecommendEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBtnClicked:(UIButton*)sender{
    if(self.rightBtnClicked){
        self.rightBtnClicked(sender);
    }
}

- (void)setRightBtnItem:(TWNavBtnItem *)rightBtnItem{
    _rightBtnItem = rightBtnItem;
    
    [self setupRightButton];
}

#pragma mark - 网络请求
- (void)getProductListGhPageFromServer{
    WeakSelf(weakSelf);

    dispatch_group_enter(self.group);
    
    DKYGetProductListGhPageParameter *p = [[DKYGetProductListGhPageParameter alloc] init];
    p.gh = self.filtrateView.name;
    p.hallName = self.filtrateView.hallName;
    p.pageSize = @(kPageSize);
    self.pageNum = 1;
    p.pageNo = @(self.pageNum);
    
    
    [[DKYHttpRequestManager sharedInstance] getProductListGhPageWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            NSArray* array = [DKYGetProductListGhPageModel mj_objectArrayWithKeyValuesArray:page.items];
            [weakSelf.productList removeAllObjects];
            [weakSelf.productList addObjectsFromArray:array];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
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

- (void)loadMoreGetProductListGhPageFromServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    
    DKYGetProductListGhPageParameter *p = [[DKYGetProductListGhPageParameter alloc] init];
    p.gh = self.filtrateView.name;
    p.hallName = self.filtrateView.hallName;
    p.pageSize = @(kPageSize);
    NSInteger pageNo = self.pageNum;
    p.pageNo = @(++pageNo);
    
    [[DKYHttpRequestManager sharedInstance] getProductListGhPageWithParameter:p Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        
        [weakSelf.collectionView.mj_footer endRefreshing];
        [DKYHUDTool dismiss];
        if (retCode == DkyHttpResponseCode_Success) {
            DKYPageModel *page = [DKYPageModel mj_objectWithKeyValues:result.data];
            if(page.items.count == 0) return;
            
            NSArray* array = [DKYGetProductListGhPageModel mj_objectArrayWithKeyValuesArray:page.items];
            [weakSelf.productList addObjectsFromArray:array];
            
            [weakSelf.collectionView reloadData];
            ++weakSelf.pageNum;
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
        [DKYHUDTool dismiss];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

-(void)getAttribnameListFromServe{
    WeakSelf(weakSelf);
    
    dispatch_group_enter(self.group);
    
    [[DKYHttpRequestManager sharedInstance] getAttribnameListWithParameter:nil Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.filtrateView.thArrays = result.data;
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
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

- (void)doHttpRequest{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    
    [self getProductListGhPageFromServer];
    [self getAttribnameListFromServe];
    
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        [DKYHUDTool dismiss];
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView reloadData];
    });
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
    return self.productList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DKYRecommendEntryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DKYRecommendEntryViewCell class]) forIndexPath:indexPath];
    cell.getProductListGhPageModel = [self.productList objectOrNilAtIndex:indexPath.item];
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
    DKYRecommendViewController *vc = [[DKYRecommendViewController alloc] init];
    DKYGetProductListGhPageModel *model = [self.productList objectOrNilAtIndex:indexPath.item];
    vc.gh = model.gh;
    vc.hallName = model.hallName;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UI
- (void)commonInit{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.group = dispatch_group_create();
    
    [self setupCustomTitle:@"套系下单"];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]] forBarMetrics:UIBarMetricsDefault];
    
    [self setupCollectionView];
    
    [self setupBackgroundBtn];
    [self setupSearchView];
    [self setupFiltrateView];
    
    [self setupLogoutBtn];
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
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DKYRecommendEntryViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DKYRecommendEntryViewCell class])];
    
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
        [weakSelf doHttpRequest];
    }];
    header.lastUpdatedTimeKey = [NSString stringWithFormat:@"%@Key",[self class]];
    self.collectionView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^(){
        [weakSelf loadMoreGetProductListGhPageFromServer];
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
    DKYRecommendFilterView *view = [[DKYRecommendFilterView alloc] initWithFrame:CGRectZero];
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

- (void)setupLogoutBtn{
    TWNavBtnItem *rightBtnItem = [[TWNavBtnItem alloc]init];
    
    rightBtnItem.itemType = TWNavBtnItemType_Text;
    rightBtnItem.title = kSignOutText;
    rightBtnItem.normalImage = nil;
    rightBtnItem.hilightedImage = nil;
    self.rightBtnItem = rightBtnItem;
    
    self.rightBtnClicked = ^(UIButton *sender) {
        QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:kNoText style:QMUIAlertActionStyleDefault handler:NULL];
        
        QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:kYesText style:QMUIAlertActionStyleDestructive handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
        }];
        
        QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:kHintText message:kSignOutContent preferredStyle:QMUIAlertControllerStyleAlert];
        
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController showWithAnimated:YES];
    };
}

- (void)setupRightButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = self.rightBtnItem.titleFont;
    btn.titleLabel.font = font;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:self.rightBtnItem.normalTitleColor forState:UIControlStateNormal];
    [btn setTitle:self.rightBtnItem.title forState:UIControlStateNormal];
    [btn setTitle:self.rightBtnItem.title forState:UIControlStateHighlighted];
    
    UIImage *image = self.rightBtnItem.normalImage;
    if(image){
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [btn setImage:image forState:UIControlStateNormal];
    }
    
    UIImage *himage = self.rightBtnItem.hilightedImage;
    himage = [himage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if(himage){
        [btn setImage:himage forState:UIControlStateHighlighted];
    }
    
    [btn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    CGRect textFrame = CGRectMake(0, 6, 40, 40);
    
    
    switch (self.rightBtnItem.itemType) {
        case TWNavBtnItemType_Text:{
            CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
            UIColor *foregroundColor = self.rightBtnItem.normalTitleColor;
            NSDictionary *attributes = @{NSFontAttributeName : font,
                                         NSForegroundColorAttributeName: foregroundColor};
            NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect titleFrame = [self.rightBtnItem.title boundingRectWithSize:size
                                                                      options:options
                                                                   attributes:attributes
                                                                      context:nil];
            textFrame.size.width = MAX(textFrame.size.width, titleFrame.size.width + 1 + self.rightBtnItem.titleOffsetX);
        }
            break;
        case TWNavBtnItemType_ImageAndText:{
            CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
            UIColor *foregroundColor = self.rightBtnItem.normalTitleColor;
            NSDictionary *attributes = @{NSFontAttributeName : font,
                                         NSForegroundColorAttributeName: foregroundColor};
            NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            CGRect titleFrame = [self.rightBtnItem.title boundingRectWithSize:size
                                                                      options:options
                                                                   attributes:attributes
                                                                      context:nil];
            CGSize imageSize = self.rightBtnItem.normalImage.size;
            textFrame.size.width += (titleFrame.size.width + imageSize.width + self.rightBtnItem.titleOffsetX);
        }
            break;
        case TWNavBtnItemType_Unset:
        case TWNavBtnItemType_Image:
            break;
        default:
            break;
    }
    
    btn.frame = textFrame;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, self.rightBtnItem.titleOffsetX, 0, 0);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    flexSpacer.width = (self.rightBtnItem.offetX - 16);  // right btn 的x坐标为10,
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:flexSpacer,rightItem, nil]];
}

#pragma mark - get & set method
- (NSMutableArray*)productList{
    if(_productList == nil){
        _productList = [NSMutableArray array];
    }
    return _productList;
}

@end
