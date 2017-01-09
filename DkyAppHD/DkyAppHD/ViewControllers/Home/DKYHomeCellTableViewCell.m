//
//  DKYHomeCellTableViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 17/1/9.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYHomeCellTableViewCell.h"

@interface DKYHomeCellTableViewCell ()

@property (nonatomic,weak) iCarousel *iCarousel;

@end

@implementation DKYHomeCellTableViewCell

+ (instancetype)homeCellWithTableView:(UITableView *)tableView delegate:(id)delegate{
    static NSString *cellID = @"DKYHomeCellTableViewCell";
    DKYHomeCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYHomeCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.iCarousel.delegate = delegate;
        cell.iCarousel.dataSource = delegate;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self commonInit];
    }
    return self;
}

#pragma mark - UI

- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupiCarousel];
}

- (void)setupiCarousel{
    iCarousel *view = [[iCarousel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:view];
    view.bounces = YES;
    view.pagingEnabled = YES;
    view.type = iCarouselTypeCustom;
    view.vertical = YES;
    view.backgroundColor = [UIColor colorWithHex:0xEEEEEE];
    view.bounces = NO;
    self.iCarousel = view;
    [view scrollToItemAtIndex:1 animated:NO];
    
    [self.iCarousel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

@end
