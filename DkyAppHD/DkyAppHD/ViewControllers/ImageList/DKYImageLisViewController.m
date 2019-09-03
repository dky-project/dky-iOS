//
//  DKYImageLisViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2019/9/2.
//  Copyright © 2019 haKim. All rights reserved.
//

#import "DKYImageLisViewController.h"
#import "QMUITableView.h"

@interface DKYImageLisViewController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property (nonatomic, weak) QMUITableView *tableView;

@end
//@interface DKYImageLisViewController ()<UITableViewDelegate,UITableViewDataSource>
//
//@property (nonatomic, weak) UITableView *tableView;
//
//
//@end

@implementation DKYImageLisViewController

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
    return 300;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //给每个cell设置ID号（重复利用时使用）
    static NSString *cellID = @"cellID";
    
    //从tableView的一个队列里获取一个cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    //判断队列里面是否有这个cell 没有自己创建，有直接使用
    if (cell == nil) {
        //没有,创建一个
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    //使用cell
    cell.textLabel.text = @"哈哈哈！！！";
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma common init
- (void)commonInit{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupTableView];
}

- (void)setupTableView{
    QMUITableView *tableView = [[QMUITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorWithHex:0xf1f1f1];;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
    WeakSelf(weakSelf);
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
