//
//  QMUILogManagerViewController.m
//  QMUIKit
//
//  Created by MoLice on 2018/1/24.
//  Copyright © 2018年 QMUI Team. All rights reserved.
//

#import "QMUILogManagerViewController.h"
#import "QMUICore.h"
#import "QMUILog.h"
#import "QMUIStaticTableViewCellData.h"
#import "QMUIStaticTableViewCellDataSource.h"
#import "UITableView+QMUIStaticCell.h"
#import "QMUITableView.h"
#import "QMUIPopupMenuView.h"
#import "UITableView+QMUI.h"
#import "QMUITableViewCell.h"
#import "QMUISearchController.h"
#import "UIBarItem+QMUI.h"

@interface QMUILogManagerViewController ()

@property(nonatomic, copy) NSDictionary<NSString *, NSNumber *> *allNames;
@property(nonatomic, copy) NSArray<NSString *> *sortedLogNames;
@property(nonatomic, copy) NSArray<NSString *> *sectionIndexTitles;
@end

@implementation QMUILogManagerViewController

- (void)didInitializeWithStyle:(UITableViewStyle)style {
    [super didInitializeWithStyle:style];
    self.rowCountWhenShowSearchBar = 10;
}

- (void)initTableView {
    [super initTableView];
    [self setupDataSource];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkEmptyView];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    if (self.allNames.count) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleMenuItemEvent)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)setupDataSource {
    self.allNames = [QMUILogger sharedInstance].logNameManager.allNames;
    
    NSArray<NSString *> *logNames = self.allNames.allKeys;
    
    self.sortedLogNames = [logNames sortedArrayUsingComparator:^NSComparisonResult(NSString *logName1, NSString *logName2) {
        logName1 = [self formatLogNameForSorting:logName1];
        logName2 = [self formatLogNameForSorting:logName2];
        return [logName1 caseInsensitiveCompare:logName2];
    }];
    self.sectionIndexTitles = ({
        NSMutableArray<NSString *> *titles = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < self.sortedLogNames.count; i++) {
            NSString *logName = self.sortedLogNames[i];
            NSString *sectionIndexTitle = [[self formatLogNameForSorting:logName] substringToIndex:1];
            if (![titles containsObject:sectionIndexTitle]) {
                [titles addObject:sectionIndexTitle];
            }
        }
        [titles copy];
    });
    
    NSMutableArray<NSArray<QMUIStaticTableViewCellData *> *> *cellDataSections = [[NSMutableArray alloc] init];
    NSMutableArray<QMUIStaticTableViewCellData *> *currentSection = nil;
    for (NSInteger i = 0; i < self.sortedLogNames.count; i++) {
        NSString *logName = self.sortedLogNames[i];
        NSString *formatedLogName = [self formatLogNameForSorting:logName];
        NSString *sectionIndexTitle = [formatedLogName substringToIndex:1];
        NSUInteger section = [self.sectionIndexTitles indexOfObject:sectionIndexTitle];
        if (section != NSNotFound) {
            if (cellDataSections.count <= section) {
                // 说明这个 section 还没被创建过
                currentSection = [[NSMutableArray alloc] init];
                [cellDataSections addObject:currentSection];
            }
            [currentSection addObject:({
                QMUIStaticTableViewCellData *d = [[QMUIStaticTableViewCellData alloc] init];
                d.text = logName;
                d.accessoryType = QMUIStaticTableViewCellAccessoryTypeSwitch;
                d.accessoryValueObject = self.allNames[logName];
                d.accessoryTarget = self;
                d.accessoryAction = @selector(handleSwitchEvent:);
                d;
            })];
        }
    }
    
    // 超过一定数量则出搜索框，先设置好搜索框的显隐，以便其他东西可以依赖搜索框的显隐状态来做判断
    NSInteger rowCount = logNames.count;
    self.shouldShowSearchBar = rowCount >= self.rowCountWhenShowSearchBar;
    
    QMUIStaticTableViewCellDataSource *dataSource = [[QMUIStaticTableViewCellDataSource alloc] initWithCellDataSections:cellDataSections];
    self.tableView.qmui_staticCellDataSource = dataSource;
}

- (void)reloadData {
    [self setupDataSource];
    [self checkEmptyView];
    [self.tableView reloadData];
}

- (void)checkEmptyView {
    if (self.allNames.count <= 0) {
        [self showEmptyViewWithText:@"暂无 QMUILog 产生" detailText:nil buttonTitle:nil buttonAction:NULL];
    } else {
        [self hideEmptyView];
    }
    [self setupNavigationItems];
}

- (NSArray<NSString *> *)sortedLogNameArray {
    NSArray<NSString *> *logNames = self.allNames.allKeys;
    NSArray<NSString *> *sortedArray = [logNames sortedArrayUsingComparator:^NSComparisonResult(NSString *logName1, NSString *logName2) {
        
        return NSOrderedAscending;
    }];
    return sortedArray;
}

- (NSString *)formatLogNameForSorting:(NSString *)logName {
    if (self.formatLogNameForSortingBlock) {
        return self.formatLogNameForSortingBlock(logName);
    }
    return logName;
}

- (void)handleSwitchEvent:(UISwitch *)switchControl {
    UITableView *tableView = self.searchController.active ? self.searchController.tableView : self.tableView;
    NSIndexPath *indexPath = [tableView qmui_indexPathForRowAtView:switchControl];
    QMUIStaticTableViewCellData *cellData = [tableView.qmui_staticCellDataSource cellDataAtIndexPath:indexPath];
    cellData.accessoryValueObject = @(switchControl.on);
    [[QMUILogger sharedInstance].logNameManager setEnabled:switchControl.on forLogName:cellData.text];
}

- (void)handleMenuItemEvent {
    QMUIPopupMenuView *menuView = [[QMUIPopupMenuView alloc] init];
    menuView.automaticallyHidesWhenUserTap = YES;
    menuView.preferLayoutDirection = QMUIPopupContainerViewLayoutDirectionBelow;
    menuView.maximumWidth = 124;
    menuView.safetyMarginsOfSuperview = UIEdgeInsetsSetRight(menuView.safetyMarginsOfSuperview, 6);
    menuView.items = @[
                       [QMUIPopupMenuItem itemWithImage:nil title:@"开启全部" handler:^(QMUIPopupMenuView *aMenuView, QMUIPopupMenuItem *aItem) {
                           for (NSString *logName in self.allNames) {
                               [[QMUILogger sharedInstance].logNameManager setEnabled:YES forLogName:logName];
                           }
                           [self reloadData];
                           [aMenuView hideWithAnimated:YES];
                       }],
                       [QMUIPopupMenuItem itemWithImage:nil title:@"禁用全部" handler:^(QMUIPopupMenuView *aMenuView, QMUIPopupMenuItem *aItem) {
                           for (NSString *logName in self.allNames) {
                               [[QMUILogger sharedInstance].logNameManager setEnabled:NO forLogName:logName];
                           }
                           [self reloadData];
                           [aMenuView hideWithAnimated:YES];
                       }],
                       [QMUIPopupMenuItem itemWithImage:nil title:@"清空全部" handler:^(QMUIPopupMenuView *aMenuView, QMUIPopupMenuItem *aItem) {
                           [[QMUILogger sharedInstance].logNameManager removeAllNames];
                           [self reloadData];
                           [aMenuView hideWithAnimated:YES];
                       }]];
    [menuView layoutWithTargetView:self.navigationItem.rightBarButtonItem.qmui_view];
    [menuView showWithAnimated:YES];
}

#pragma mark - <QMUITableViewDataSource, QMUITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUITableViewCell *cell = [tableView.qmui_staticCellDataSource cellForRowAtIndexPath:indexPath];
    QMUIStaticTableViewCellData *cellData = [tableView.qmui_staticCellDataSource cellDataAtIndexPath:indexPath];
    NSString *logName = cellData.text;
    
    NSAttributedString *string = nil;
    if (self.formatCellTextBlock) {
        string = self.formatCellTextBlock(logName);
    } else {
        NSString *formatedLogName = [self formatLogNameForSorting:logName];
        NSRange range = [logName rangeOfString:formatedLogName];
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:logName attributes:@{NSFontAttributeName: UIFontMake(16), NSForegroundColorAttributeName: UIColorGray}];
        [mutableString setAttributes:@{NSForegroundColorAttributeName: UIColorBlack} range:range];
        string = [mutableString copy];
    }
    cell.textLabel.attributedText = string;
    
    if ([cell.accessoryView isKindOfClass:[UISwitch class]]) {
        BOOL enabled = self.allNames[logName].boolValue;
        UISwitch *switchControl = (UISwitch *)cell.accessoryView;
        switchControl.on = enabled;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return tableView == self.tableView ? self.sectionIndexTitles[section] : nil;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return tableView == self.tableView && self.shouldShowSearchBar ? self.sectionIndexTitles : nil;
}

#pragma mark - <QMUISearchControllerDelegate>

- (void)searchController:(QMUISearchController *)searchController updateResultsForSearchString:(NSString *)searchString {
    NSArray<NSArray<QMUIStaticTableViewCellData *> *> *dataSource = self.tableView.qmui_staticCellDataSource.cellDataSections;
    NSMutableArray<QMUIStaticTableViewCellData *> *resultDataSource = [[NSMutableArray alloc] init];// 搜索结果就不需要分 section 了
    for (NSInteger section = 0; section < dataSource.count; section ++) {
        for (NSInteger row = 0; row < dataSource[section].count; row ++) {
            QMUIStaticTableViewCellData *cellData = dataSource[section][row];
            NSString *text = cellData.text;
            if ([text.lowercaseString containsString:searchString.lowercaseString]) {
                [resultDataSource addObject:cellData];
            }
        }
    }
    searchController.tableView.qmui_staticCellDataSource = [[QMUIStaticTableViewCellDataSource alloc] initWithCellDataSections:@[resultDataSource.copy]];
    
    if (resultDataSource.count > 0) {
        [searchController hideEmptyView];
    } else {
        [searchController showEmptyViewWithText:@"无结果" detailText:nil buttonTitle:nil buttonAction:NULL];
    }
}

- (void)willPresentSearchController:(QMUISearchController *)searchController {
    [QMUIHelper renderStatusBarStyleDark];
}

- (void)willDismissSearchController:(QMUISearchController *)searchController {
    
    // 在搜索状态里可能修改了 switch 的值，则退出时强制刷新一下默认状态的列表
    [self reloadData];
    
    BOOL oldStatusbarLight = NO;
    if ([self respondsToSelector:@selector(shouldSetStatusBarStyleLight)]) {
        oldStatusbarLight = [self shouldSetStatusBarStyleLight];
    }
    if (oldStatusbarLight) {
        [QMUIHelper renderStatusBarStyleLight];
    } else {
        [QMUIHelper renderStatusBarStyleDark];
    }
}

@end
