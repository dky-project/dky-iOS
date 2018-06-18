//
//  DKYDataAnalysisViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/16.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import "DKYDataAnalysisViewController.h"
#import "DKYDataAnalysisSummarizingView.h"
#import "DKYGetDataAnalysisListModel.h"
#import "DQTableViewCell.h"
#import "DKYGetDataAnalysisFormItemModel.h"

@interface DKYDataAnalysisViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) DKYDataAnalysisSummarizingView *header;

@property (nonatomic, strong) DKYGetDataAnalysisListModel *getDataAnalysisListModel;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) NSArray *MPTBELONGTYPEArray;

@property (nonatomic, copy) NSArray *DIMFLAG_NEW14Array;

@property (nonatomic, copy) NSArray *DIMFLAG_16Array;

@property (nonatomic, copy) NSArray *DIMFLAG_13Array;

@property (nonatomic, copy) NSArray *DIMFLAG_NEW13Array;

@property (nonatomic, copy) NSArray *DIMFLAG_14Array;

@property (nonatomic, copy) NSArray *DIMFLAG_NEW16Array;
@end

@implementation DKYDataAnalysisViewController

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
    
    [self getDataAnalysisListFromServer];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    WeakSelf(weakSelf);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

#pragma mark - api
- (void)getDataAnalysisListFromServer{
    WeakSelf(weakSelf);
    [DKYHUDTool show];
    
    [[DKYHttpRequestManager sharedInstance] getDataAnalysisListPageWithParameter:nil Success:^(NSInteger statusCode, id data) {
        DKYHttpRequestResult *result = [DKYHttpRequestResult mj_objectWithKeyValues:data];
        DkyHttpResponseCode retCode = [result.code integerValue];
        if (retCode == DkyHttpResponseCode_Success) {
            weakSelf.getDataAnalysisListModel = [DKYGetDataAnalysisListModel mj_objectWithKeyValues:result.data];
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
            // 将文件数据化
            NSData *data = [[NSData alloc] initWithContentsOfFile:path];
            // 对数据进行JSON格式化并返回字典形式
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSDictionary *da = [result objectForKey:@"data"];
            weakSelf.getDataAnalysisListModel = [DKYGetDataAnalysisListModel mj_objectWithKeyValues:da];
            
            [weakSelf updateUI];
        }else if (retCode == DkyHttpResponseCode_NotLogin) {
            // 用户未登录,弹出登录页面
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserNotLoginNotification object:nil];
            [DKYHUDTool showErrorWithStatus:result.msg];
        }else{
            NSString *retMsg = result.msg;
            [DKYHUDTool showErrorWithStatus:retMsg];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [DKYHUDTool dismiss];
    } failure:^(NSError *error) {
        DLog(@"Error = %@",error.description);
        [DKYHUDTool dismiss];
        [weakSelf.tableView.mj_header endRefreshing];
        [DKYHUDTool showErrorWithStatus:kNetworkError];
    }];
}

- (void)updateUI{
    [self makeFormData];
    if(self.getDataAnalysisListModel.total.isZmd){
        self.header.height = 160;
    }else{
        self.header.height = 200;
    }
    self.header.getDataAnalysisListModel = self.getDataAnalysisListModel;
    
    [self.tableView reloadData];
}

- (void)makeFormData{
    [self setupMPTBELONGTYPEArray];
    [self setupDIMFLAG_NEW14Array];
    [self setupDIMFLAG_16Array];
    [self setupDIMFLAG_13Array];
    [self setupDIMFLAG_NEW13Array];
    [self setupDIMFLAG_14Array];
    [self setupDIMFLAG_NEW16Array];
}

- (void)setupMPTBELONGTYPEArray{
    NSMutableArray *col1 = [NSMutableArray array];
    NSArray *data = self.getDataAnalysisListModel.MPTBELONGTYPE;
    
    [col1 addObject:@"所属类别"];
    
    for(DKYGetDataAnalysisFormItemModel *item in data){
        [col1 addObject:item.attribname];
    }
    
    NSArray *commonForm = [self makeCommonFormCol:data];
    
    NSMutableArray *formData = [NSMutableArray arrayWithCapacity:4];
    [formData addObject:col1];
    [formData addObjectsFromArray:commonForm];
    
    self.MPTBELONGTYPEArray = formData;
}

- (void)setupDIMFLAG_NEW14Array{
    NSMutableArray *col1 = [NSMutableArray array];
    NSArray *data = self.getDataAnalysisListModel.DIMFLAG_NEW14;
    
    [col1 addObject:@"品种"];
    
    for(DKYGetDataAnalysisFormItemModel *item in data){
        [col1 addObject:item.attribname];
    }
    
    NSArray *commonForm = [self makeCommonFormCol:data];
    
    NSMutableArray *formData = [NSMutableArray arrayWithCapacity:4];
    [formData addObject:col1];
    [formData addObjectsFromArray:commonForm];
    
    self.DIMFLAG_NEW14Array = formData;
}

- (void)setupDIMFLAG_16Array{
    NSMutableArray *col1 = [NSMutableArray array];
    NSArray *data = self.getDataAnalysisListModel.DIMFLAG_16;
    
    [col1 addObject:@"品类"];
    
    for(DKYGetDataAnalysisFormItemModel *item in data){
        [col1 addObject:item.attribname];
    }
    
    NSArray *commonForm = [self makeCommonFormCol:data];
    
    NSMutableArray *formData = [NSMutableArray arrayWithCapacity:4];
    [formData addObject:col1];
    [formData addObjectsFromArray:commonForm];
    
    self.DIMFLAG_16Array = formData;
}

- (void)setupDIMFLAG_13Array{
    NSMutableArray *col1 = [NSMutableArray array];
    NSArray *data = self.getDataAnalysisListModel.DIMFLAG_13;
    
    [col1 addObject:@"系列"];
    
    for(DKYGetDataAnalysisFormItemModel *item in data){
        [col1 addObject:item.attribname];
    }
    
    NSArray *commonForm = [self makeCommonFormCol:data];
    
    NSMutableArray *formData = [NSMutableArray arrayWithCapacity:4];
    [formData addObject:col1];
    [formData addObjectsFromArray:commonForm];
    
    self.DIMFLAG_13Array = formData;
}

- (void)setupDIMFLAG_NEW13Array{
    NSMutableArray *col1 = [NSMutableArray array];
    NSArray *data = self.getDataAnalysisListModel.DIMFLAG_NEW13;
    
    [col1 addObject:@"性别"];
    
    for(DKYGetDataAnalysisFormItemModel *item in data){
        [col1 addObject:item.attribname];
    }
    
    NSArray *commonForm = [self makeCommonFormCol:data];
    
    NSMutableArray *formData = [NSMutableArray arrayWithCapacity:4];
    [formData addObject:col1];
    [formData addObjectsFromArray:commonForm];
    
    self.DIMFLAG_NEW13Array = formData;
}

- (void)setupDIMFLAG_14Array{
    NSMutableArray *col1 = [NSMutableArray array];
    NSArray *data = self.getDataAnalysisListModel.DIMFLAG_14;
    
    [col1 addObject:@"波段"];
    
    for(DKYGetDataAnalysisFormItemModel *item in data){
        [col1 addObject:item.attribname];
    }
    
    NSArray *commonForm = [self makeCommonFormCol:data];
    
    NSMutableArray *formData = [NSMutableArray arrayWithCapacity:4];
    [formData addObject:col1];
    [formData addObjectsFromArray:commonForm];
    
    self.DIMFLAG_14Array = formData;
}

- (void)setupDIMFLAG_NEW16Array{
    NSMutableArray *col1 = [NSMutableArray array];
    NSArray *data = self.getDataAnalysisListModel.DIMFLAG_NEW16;
    
    [col1 addObject:@"针型"];
    
    for(DKYGetDataAnalysisFormItemModel *item in data){
        [col1 addObject:item.attribname];
    }
    
    NSArray *commonForm = [self makeCommonFormCol:data];
    
    NSMutableArray *formData = [NSMutableArray arrayWithCapacity:4];
    [formData addObject:col1];
    [formData addObjectsFromArray:commonForm];
    
    self.DIMFLAG_NEW16Array = formData;
}

- (NSArray*)makeCommonFormCol:(NSArray*)dataArray{
    NSMutableArray *col2 = [NSMutableArray array];
    NSMutableArray *col3 = [NSMutableArray array];
    NSMutableArray *col4 = [NSMutableArray array];
    
    [col2 addObject:@"订单件数"];
    [col3 addObject:@"占比(订单件数/下单总数)"];
    [col4 addObject:@"推荐比例(维护固定取值)"];
    
    for(DKYGetDataAnalysisFormItemModel *item in dataArray){
        NSString *count = [NSString stringWithFormat:@"%@件",item.zxQty];
        [col2 addObject:count];
        [col3 addObject:item.bfb];
        [col4 addObject:item.proportion];
    }
    
    return @[[col2 copy],[col3 copy],[col4 copy]];
}

#pragma mark - delegate
- (nullable UIImage *)navigationBarBackgroundImage{
    return [UIImage imageWithColor:[UIColor colorWithHex:0x2D2D33]];
}

- (nullable UIColor *)titleViewTintColor{
    return [UIColor whiteColor];
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    WeakSelf(weakSelf);
    identifier = NSStringFromClass([DQTableViewCell class]);
    
    return [tableView fd_heightForCellWithIdentifier:identifier configuration:^(id cell) {
        // Configure this cell with data, same as what you've done in "-tableView:cellForRowAtIndexPath:"
        DQTableViewCell *newcell = (DQTableViewCell*)cell;
        newcell.fd_enforceFrameLayout = YES;
        
        switch (indexPath.row) {
            case 0:
                newcell.DataArr = [self.MPTBELONGTYPEArray copy];
                break;
            case 1:
                newcell.DataArr = [self.DIMFLAG_NEW14Array copy];
                break;
            case 2:
                newcell.DataArr = [self.DIMFLAG_16Array copy];
                break;
            case 3:
                newcell.DataArr = [self.DIMFLAG_13Array copy];
                break;
            case 4:
                newcell.DataArr = [self.DIMFLAG_NEW13Array copy];
                break;
            case 5:
                newcell.DataArr = [self.DIMFLAG_14Array copy];
                break;
            case 6:
                newcell.DataArr = [self.DIMFLAG_NEW16Array copy];
                break;
                
            default:
                break;
        }
    }];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DQTableViewCell *cell = [DQTableViewCell tableViewCellWithTableView:tableView];
    cell.formType = DKYFormType_TypeThree;
    cell.hideBottomLine = YES;
    
    
    switch (indexPath.row) {
        case 0:
            cell.DataArr = [self.MPTBELONGTYPEArray copy];
            break;
        case 1:
            cell.DataArr = [self.DIMFLAG_NEW14Array copy];
            break;
        case 2:
            cell.DataArr = [self.DIMFLAG_16Array copy];
            break;
        case 3:
            cell.DataArr = [self.DIMFLAG_13Array copy];
            break;
        case 4:
            cell.DataArr = [self.DIMFLAG_NEW13Array copy];
            break;
        case 5:
            cell.DataArr = [self.DIMFLAG_14Array copy];
            break;
        case 6:
            cell.DataArr = [self.DIMFLAG_NEW16Array copy];
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - help method
- (void)setupGanweiArray{
    NSMutableArray *ganwei = [NSMutableArray arrayWithCapacity:6];
    NSArray *column1 = @[@"颜色",@"杆位"];
    [ganwei addObject:column1];
    
    
    NSArray *column2 = @[@"1",@"a"];
    NSArray *column3 = @[@"2",@"b"];
    NSArray *column4 = @[@"3",@"c"];
    [ganwei addObject:column2];
    [ganwei addObject:column3];
    [ganwei addObject:column4];
}

#pragma common init
- (void)commonInit{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupTableView];
}

- (void)setupHeaderView{
    DKYDataAnalysisSummarizingView *view = [[DKYDataAnalysisSummarizingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    self.tableView.tableHeaderView = view;
    self.header = view;
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorWithHex:0xf1f1f1];;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self.tableView registerClass:[DQTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DQTableViewCell class])];
    
    [self setupHeaderView];
    
    WeakSelf(weakSelf);
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [weakSelf getDataAnalysisListFromServer];
    }];
}
@end
