//
//  DKYMultipleSelectPopupView.m
//  DkyAppHD
//
//  Created by HaKim on 17/2/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYMultipleSelectPopupView.h"
#import "KLCPopup.h"
#import "DKYMultipleSelectPopupViewCell.h"
#import "DKYMultipleSelectPopupItemModel.h"
#import "DKYDahuoOrderColorModel.h"
#import "DKYAddProductApproveParameter.h"

@interface DKYMultipleSelectPopupView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) KLCPopup *popup;

@property (nonatomic, weak) UIView *titleView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIButton *cancelBtn;

@property (nonatomic, weak) UIButton *confirmBtn;

@property (nonatomic, strong) NSNumber *colorValue;

@property (nonatomic, strong) NSMutableArray *selectedColors;

// 测试数据
//@property (nonatomic, strong) NSMutableArray *colors;

@end

@implementation DKYMultipleSelectPopupView

+ (instancetype)show{
    DKYMultipleSelectPopupView *contentView = [[DKYMultipleSelectPopupView alloc]initWithFrame:CGRectZero];
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeBounceInFromTop
                                         dismissType:KLCPopupDismissTypeBounceOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:NO
                               dismissOnContentTouch:NO];
    popup.dimmedMaskAlpha = 0.6;
    contentView.popup = popup;
    
    [popup show];
    return contentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)dismiss{
    [self.popup dismiss:YES];
}

- (void)setClrRangeArray:(NSArray *)clrRangeArray{
    _clrRangeArray = clrRangeArray;
    
    for (DKYDahuoOrderColorModel *model in self.colorViewList) {
        model.selectedCount = 0;
    }

    for (NSString *selectColor in clrRangeArray) {
        for (DKYDahuoOrderColorModel *model in self.colorViewList) {
            if([model.colorName isEqualToString:selectColor]){
                ++model.selectedCount;
                [self.selectedColors addObject:model];
                break;
            }
        }
    }

    [self fetchSelectedColorInfo];
}

#pragma mark - action method

- (void)closeBtnClicked:(UIButton*)sender{
    [self dismiss];
}

- (void)confirmBtnClicked:(UIButton*)sender{
    [self fetchSelectedColorInfo];
    if(self.confirmBtnClicked){
        self.confirmBtnClicked(self.selectedColors);
    }
    [self dismiss];
}

- (void)fetchSelectedColorInfo{
//    NSMutableArray *selectedColor = [NSMutableArray array];
//    
//    for (DKYDahuoOrderColorModel *model in self.colorViewList) {
//        if(model.selected){
//            [selectedColor addObject:model.colorName];
//            if(!self.colorValue){
//                self.colorValue = @(model.colorId);
//                self.addProductApproveParameter.colorValue = self.colorValue;
//            }
//        }
//    }
    
    // 主色
    DKYDahuoOrderColorModel *model = [self.selectedColors objectOrNilAtIndex:0];
    self.addProductApproveParameter.colorValue = @(model.colorId);
    
    NSMutableArray *selectedColor = [NSMutableArray array];
    for (DKYDahuoOrderColorModel *model in self.selectedColors) {
        if(model.selected){
            [selectedColor addObject:model.colorName];
        }
    }
    
    if(selectedColor.count > 0){
        self.addProductApproveParameter.colorArr = [selectedColor componentsJoinedByString:@";"];
    }else{
        self.addProductApproveParameter.colorArr = nil;
    }
}

#pragma mark - UI
- (void)commonInit{
    self.bounds = CGRectMake(0, 0, 514, 610);
    self.backgroundColor = [UIColor whiteColor];
    self.maxSelectedNumber = 9;
    
    [self setupTitleView];
    [self setupTitleLabel];
    [self setupTableView];
    [self setupBtns];
}

- (void)setupTitleView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:view];
    self.titleView = view;
    view.backgroundColor = [UIColor colorWithHex:0x3C3362];
    WeakSelf(weakSelf);
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(60);
    }];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.titleView addSubview:label];
    self.titleLabel = label;
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.titleView);
        make.top.mas_equalTo(weakSelf.titleView);
        make.centerX.mas_equalTo(weakSelf.titleView);
    }];
    label.text = @"颜色选择";
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorInset = UIEdgeInsetsMake(0, 32, 0, 0);
    self.tableView = tableView;
    [self addSubview:tableView];
    
    WeakSelf(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleView.mas_bottom);
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
    }];
}

- (void)setupBtns{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:btn];
    self.cancelBtn = btn;
    
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    WeakSelf(weakSelf);
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleView);
        make.bottom.mas_equalTo(weakSelf.titleView);
        make.top.mas_equalTo(weakSelf.titleView);
        make.width.mas_equalTo(60);
    }];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(confirmBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:btn];
    self.confirmBtn = btn;
    
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];

    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.titleView);
        make.bottom.mas_equalTo(weakSelf.titleView);
        make.top.mas_equalTo(weakSelf.titleView);
        make.width.mas_equalTo(60);
    }];
}

#pragma mark - UITableView 的 UITableViewDelegate 和 UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.colorViewList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(weakSelf);
    DKYMultipleSelectPopupViewCell *cell = [DKYMultipleSelectPopupViewCell multipleSelectPopupViewCellWithTableView:tableView];
    DKYDahuoOrderColorModel *item = [self.colorViewList objectOrNilAtIndex:indexPath.row];
    cell.itemModel = item;
    cell.cancelBtnClicked = ^(id sender) {
        if(item.selectedCount == 0) return ;
        
        --item.selectedCount;
        __block NSInteger index = 0;
        [weakSelf.selectedColors enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if(obj == item){
                index = idx;
                *stop = YES;
            }
        }];
        [weakSelf.selectedColors removeObjectAtIndex:index];
        [weakSelf.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DKYDahuoOrderColorModel *item = [self.colorViewList objectOrNilAtIndex:indexPath.row];
    
    if(self.selectedColors.count >= self.maxSelectedNumber){
        return;
    }
    
    // 选中
    [self.selectedColors addObject:item];
    ++item.selectedCount;
    
    [tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - get & set method
//- (NSMutableArray*)colors{
//    if(_colors == nil){
//        _colors = [NSMutableArray array];
//        for (int i = 0; i < 30; ++i) {
//            DKYMultipleSelectPopupItemModel *item = [[DKYMultipleSelectPopupItemModel alloc] init];
//            
//            item.content = [NSString stringWithFormat:@"颜色-%@",@(i)];
//            [_colors addObject:item];
//        }
//    }
//    return _colors;
//}

- (NSMutableArray*)selectedColors{
    if(_selectedColors == nil){
        _selectedColors = [NSMutableArray array];
    }
    return _selectedColors;
}


@end
