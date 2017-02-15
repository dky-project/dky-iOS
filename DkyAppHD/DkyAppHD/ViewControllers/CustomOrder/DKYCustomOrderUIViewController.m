//
//  DKYCustomOrderUIViewController.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderUIViewController.h"
#import "DKYOrderActionsView.h"

@interface DKYCustomOrderUIViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)TWScrollView  *scrollView;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) DKYOrderActionsView *actionsView;

@end

@implementation DKYCustomOrderUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI

- (void)commonInit{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCustomTitle:@"定制下单"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    
    [self setupTableView];
//    [self setupScrollView];
}

- (void)setupTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    DKYOrderActionsView *actionView = [DKYOrderActionsView orderActionsView];
    actionView.frame = CGRectMake(0, 0, kScreenWidth, 450);
    self.tableView.tableFooterView = actionView;
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

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 350;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"testCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"测试数据";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Test
- (void)setupScrollView{
    TWScrollView *scrollView = [[TWScrollView alloc]init];
    scrollView.scrollViewType = TWScrollViewType_Vertical;
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentView.backgroundColor = [UIColor whiteColor];
    WeakSelf(weakSelf);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    [self.scrollView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(kScreenHeight - kNavigationBarHeight));
    }];
    
    [self setupActionsView];
}

- (void)setupActionsView{
    DKYOrderActionsView *actionView = [DKYOrderActionsView orderActionsView];
    [self.scrollView.contentView addSubview:actionView];
    self.actionsView = actionView;
    
    WeakSelf(weakSelf);
    [self.actionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.scrollView.contentView);
        make.right.mas_equalTo(weakSelf.scrollView.contentView);
        make.bottom.mas_equalTo(weakSelf.scrollView.contentView).with.offset(-40);
        make.height.mas_equalTo(115);
    }];
}

@end
