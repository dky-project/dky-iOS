//
//  DKYCustomOrderUIViewController.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYCustomOrderUIViewController.h"
#import "DKYOrderActionsView.h"
#import "DKYCustomOrderViewCell.h"
#import "MMPopupItem.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#import "DKYCustomOrderBusinessCell.h"

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

#pragma mark - private method
- (void)showOptionsPicker{
    [self.view endEditing:YES];
    MMPopupItemHandler block = ^(NSInteger index){
        DLog(@"++++++++ index = %ld",index);
    };
    
    NSArray *item = @[@"1",@"2",@"3",@"4",@"5"];
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:item.count + 1];
    for (NSString *str in item) {
        [items addObject:MMItemMake(str, MMItemTypeNormal, block)];
    }

    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"点击选择内容"
                                                          items:[items copy]];
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [sheetView show];
}

#pragma mark - UI

- (void)commonInit{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupCustomTitle:@"定制下单"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    
    [self setupTableView];
    [self setupActionView];
//    [self setupScrollView];
}

- (void)setupTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
}

- (void)setupActionView{
    DKYOrderActionsView *actionView = [DKYOrderActionsView orderActionsView];
    [self.view addSubview:actionView];
    self.actionsView = actionView;
    WeakSelf(weakSelf);
    [self.actionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view);
        make.right.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.tableView.mas_bottom);
    }];
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) return 240;
    
    return 2100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(weakSelf);
    if(indexPath.row == 0){
        DKYCustomOrderBusinessCell *cell = [DKYCustomOrderBusinessCell customOrderBusinessCellWithTableView:tableView];
        return cell;
    }
    
    DKYCustomOrderViewCell *cell= [DKYCustomOrderViewCell customOrderViewCellWithTableView:tableView];
    cell.optionsBtnClicked = ^(id sender, NSInteger index){
        [weakSelf showOptionsPicker];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
