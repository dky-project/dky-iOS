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

@interface DKYDataAnalysisViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) DKYDataAnalysisSummarizingView *header;

@property (nonatomic, strong) DKYGetDataAnalysisListModel *getDataAnalysisListModel;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) NSArray *ganweiArray;

@end

@implementation DKYDataAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getDataAnalysisListFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didInitialize{
    [super didInitialize];
    
    [self setupGanweiArray];

    [self commonInit];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    WeakSelf(weakSelf);
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
        make.top.mas_equalTo(0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(weakSelf.header.mas_bottom);
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
    return 5;
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
                newcell.DataArr = [self.ganweiArray mutableCopy];
                break;
            case 1:
                newcell.DataArr = [self.ganweiArray mutableCopy];
                break;
            case 2:
                newcell.DataArr = [self.ganweiArray mutableCopy];
                break;
            case 3:
                newcell.DataArr = [self.ganweiArray mutableCopy];
                break;
            case 4:
                newcell.DataArr = [self.ganweiArray mutableCopy];
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
    
    
    cell.DataArr = [self.ganweiArray mutableCopy];
    
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
    
    self.ganweiArray = [ganwei mutableCopy];
}

#pragma common init
- (void)commonInit{
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self setupHeaderView];
    [self setupTableView];
}

- (void)setupHeaderView{
    DKYDataAnalysisSummarizingView *view = [[DKYDataAnalysisSummarizingView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:view];
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
}
@end
