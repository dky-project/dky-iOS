//
//  DKYSampleDetailViewController.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/4.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleDetailViewController.h"
#import "DKYSampleDetailTypeViewCell.h"

@interface DKYSampleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)IBOutlet UITableView *tableView;

@end

@implementation DKYSampleDetailViewController

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
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
}

#pragma mark - UI

- (void)commonInit{
    [self setupCustomTitle:@"产品详情"];
    
    [self setupTableView];
}

- (void)setupTableView{
//    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.showsVerticalScrollIndicator = NO;
//
//    UINib *nib = [UINib nibWithNibName:NSStringFromClass([DKYSampleDetailTypeViewCell class]) bundle:nil];
//    
//    [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([DKYSampleDetailTypeViewCell class])];
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
//    nib = [UINib nibWithNibName:NSStringFromClass([MKJTableViewCell class]) bundle:nil];
//    [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([MKJTableViewCell class])];
//    
//    self.tableView = tableView;
//    [self.view addSubview:tableView];
//    tableView.backgroundColor = [UIColor colorWithHex:0xEFEFF5];
//    
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsZero);
//    }];
    
    NSString *identify = NSStringFromClass([DKYSampleDetailTypeViewCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:identify bundle:nil] forCellReuseIdentifier:identify];
    
//    UINib *nib = [UINib nibWithNibName:NSStringFromClass([MKJTableViewCell class]) bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([MKJTableViewCell class])];
}

//- (void)configCell:(MKJTableViewCell *)cell indexpath:(NSIndexPath *)index{
//    cell.headImageView.image = [UIImage imageWithColor:[UIColor randomColor]];
//    cell.userName.text = @"哈哈哈";
//    cell.mainImageView.image = [UIImage imageNamed:@"test1"];
//    cell.descLabel.text = @"阿凡达方法方面的的发放的卷发家里发呆事实上事实上事实上事实上事实上事实上事实上事实上事实上发的顶顶顶顶顶大";
//}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    switch (indexPath.row) {
        case 0:
            identifier = NSStringFromClass([DKYSampleDetailTypeViewCell class]);
            break;
            
        default:
            identifier = NSStringFromClass([DKYSampleDetailTypeViewCell class]);
            break;
    }
    return [tableView fd_heightForCellWithIdentifier:identifier configuration:^(id cell) {
        // Configure this cell with data, same as what you've done in "-tableView:cellForRowAtIndexPath:"
        DKYSampleDetailTypeViewCell *newCell = (DKYSampleDetailTypeViewCell*)cell;
        newCell.model = [[NSObject alloc] init];
    }];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:{
            cell = [DKYSampleDetailTypeViewCell sampleDetailTypeViewCellWithTableView:tableView];
        }
            break;
        case 1:{
            cell = [DKYSampleDetailTypeViewCell sampleDetailTypeViewCellWithTableView:tableView];
        }
            break;
        case 2:{
            cell = [DKYSampleDetailTypeViewCell sampleDetailTypeViewCellWithTableView:tableView];
        }
            break;
            
        default:
            break;
    }
    DKYSampleDetailTypeViewCell *newCell = (DKYSampleDetailTypeViewCell*)cell;
    newCell.model = [[NSObject alloc] init];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
