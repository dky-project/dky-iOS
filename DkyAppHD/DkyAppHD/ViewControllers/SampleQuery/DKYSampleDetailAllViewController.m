//
//  DKYSampleDetailAllViewController.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/4/11.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleDetailAllViewController.h"
#import "DKYSampleDetailViewController.h"

@interface DKYSampleDetailAllViewController ()<VTMagicViewDataSource,VTMagicViewDelegate>

@property (nonatomic, strong) VTMagicController *magicController;

@end

@implementation DKYSampleDetailAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self commonInit];
}

#pragma mark - UI

- (void)commonInit{
    [self setupCustomTitle:@"产品详情"];
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    [_magicController.magicView reloadDataToPage:self.currentIndex];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (int i = 0; i < self.samples.count; ++i) {
        [titleList addObject:@""];
    }
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    static NSString *gridId = @"sample.identifier";
    DKYSampleDetailViewController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!viewController) {
        viewController = (DKYSampleDetailViewController*)[UIStoryboard viewControllerWithClass:[DKYSampleDetailViewController class]];
    }
    viewController.sampleModel = [self.samples objectOrNilAtIndex:pageIndex];
    return viewController;
}


- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationHeight = CGFLOAT_MIN;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

@end
