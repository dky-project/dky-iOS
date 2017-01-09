//
//  DKYOrderInquiryViewController.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/8.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYOrderInquiryViewController.h"
#import "DKYOrderInquiryHeaderView.h"
#import "WGBDatePickerView.h"
#import "DKYDatePickerView.h"
#import "MMPopupItem.h"
#import "MMSheetView.h"
#import "MMPopupWindow.h"
#import "DKYOrderInfoHeaderView.h"
#import "DKYOrderInquiryViewCell.h"
#import "DKYOrderBrowseViewController.h"
#import "DKYOrderBrowseView.h"

@interface DKYOrderInquiryViewController ()<UITableViewDelegate,UITableViewDataSource,WGBDatePickerViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) DKYOrderInquiryHeaderView *headerView;

@property (nonatomic, strong) DKYOrderInfoHeaderView *sectionHeaderView;

@property (nonatomic,strong) WGBDatePickerView *datePickView;

@end

@implementation DKYOrderInquiryViewController

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

- (void)showFaxDateSelectedPicker{
    //        DKYDatePickerView *pic = [[DKYDatePickerView alloc] init];
    //        pic.doneBlock = ^(DKYDatePickerView *picker, DkyButtonStatusType type){
    //            DLog(@"%@",picker.selectedDate);
    //        };
    //        [pic show];
    [self.datePickView show];
}

- (void)showAuditStatusSelectedPicker{
    MMPopupItemHandler block = ^(NSInteger index){
        DLog(@"clickd %@ button",@(index));
        if(index == 3){
            [[DKYAccountManager sharedInstance] deleteAccesToken];
        }
    };
    NSArray *items =
    @[MMItemMake(@"审核中", MMItemTypeNormal, block),
      MMItemMake(@"审核成功", MMItemTypeNormal, block),
      MMItemMake(@"审核失败", MMItemTypeNormal, block),
      MMItemMake(@"未审核", MMItemTypeHighlight, block)];
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"审核状态"
                                                          items:items];
//    sheetView.attachedView = self.view;
    [MMPopupWindow sharedWindow].touchWildToHide = YES;
    [sheetView show];
}

- (void)showOrderPreview{
//    DKYOrderBrowseViewController *vc = [[DKYOrderBrowseViewController alloc] init];
//    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    vc.modalPresentationStyle = UIModalPresentationPopover;
//    vc.preferredContentSize = CGSizeMake(514, 610);
//    UIPopoverPresentationController *popover = vc.popoverPresentationController;
//    popover.sourceView = self.view;
//    [self presentViewController:vc animated:YES completion:nil];
    
    [DKYOrderBrowseView show];
}

#pragma mark - UI

- (void)commonInit{
    self.navigationItem.title = nil;
    
    [self setupCustomTitle:@"订单查询"];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor colorWithHex:0x2D2D33]];
    
    [self setupTableView];
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor whiteColor];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    WeakSelf(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    DKYOrderInquiryHeaderView *header = [DKYOrderInquiryHeaderView orderInquiryHeaderView];
    header.bounds = CGRectMake(0, 0, kScreenWidth, 300);
    self.tableView.tableHeaderView = header;
    self.headerView = header;
    
    
    header.faxDateBlock = ^(id sender){
        [weakSelf showFaxDateSelectedPicker];
    };
    
    header.auditStatusBlock = ^(id sender){
        [weakSelf showAuditStatusSelectedPicker];
    };
    
    header.batchPreviewBtnClicked = ^(id sender){
        [weakSelf showOrderPreview];
    };
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
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKYOrderInquiryViewCell *cell = [DKYOrderInquiryViewCell orderInquiryViewCellWithTableView:tableView];
    cell.headerView = self.headerView;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark- <WGBDatePickerViewDelegate>
//当时间改变时触发
- (void)changeTime:(NSDate *)date{
   
}

//确定时间
- (void)determine:(NSDate *)date{
    DLog(@"选中时间 = %@",[self.datePickView stringFromDate:date]);
    self.headerView.faxDateLabel.text = [NSString stringWithFormat:@"   %@",[self.datePickView stringFromDate:date]];
}

#pragma mark - get & set method
- (WGBDatePickerView *)datePickView{
    if (!_datePickView) {
        _datePickView =[[WGBDatePickerView alloc] initWithFrame:self.view.bounds type:UIDatePickerModeDate];
        _datePickView.delegate = self;
        _datePickView.title =@"传真日期";
    }
    return _datePickView;
}

- (DKYOrderInfoHeaderView*)sectionHeaderView{
    if(_sectionHeaderView == nil){
        DKYOrderInfoHeaderView *header = [DKYOrderInfoHeaderView orderInfoHeaderViewWithTableView:nil];
        self.sectionHeaderView = header;
    }
    return _sectionHeaderView;
}

@end
