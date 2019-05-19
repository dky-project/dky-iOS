//
//  DQTableViewCell.m
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/23.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import "DQTableViewCell.h"
#import "DQFormCollectionView.h"
#import "DQFormCollectionViewCell.h"

static NSString *DQCollectionCellID = @"DQCollectionCellID";
@interface DQTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) DQFormCollectionView *DQCollectionView;

@property (nonatomic, strong) NSIndexPath *TotalPath;

@property (nonatomic, strong) NSArray *lineWidthArray;

@property (nonatomic, weak) UIView *bottomLine;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *markLabel;

@end
@implementation DQTableViewCell
+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DQTableViewCell";
    DQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        self.contentView.backgroundColor = [UIColor colorWithHex:0xF1F1F1];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self DQAddSubViewFunction];
        [self setupLine];
        self.formType = DKYFormType_Default;
    }
    return self;
}

- (void)setHideBottomLine:(BOOL)hideBottomLine{
    _hideBottomLine = hideBottomLine;
    
    self.bottomLine.hidden = hideBottomLine;
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    if(self.titleLabel == nil){
        [self setupTitleLabel];
    }
    
    self.titleLabel.text = title;
    
    UIView *sub = self.contentView;
    double topPadding = 15;
    if(title.length > 0){
        topPadding = 40;
    }
    [self.DQCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_top).offset(topPadding);
    }];
}

- (void)setMark:(NSString *)mark{
    _mark = [mark copy];
    if(self.markLabel == nil){
        [self setupMarkLabel];
    }
    
    self.markLabel.text = mark;
    
    UIView *sub = self.contentView;
    double topPadding = -15;
    if(mark.length > 0){
        topPadding = -40;
    }
    [self.DQCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(sub.mas_bottom).offset(topPadding);
    }];
}

- (void)DQAddSubViewFunction{
    UIView *sub = self.contentView;
    self.DQCollectionView = [[DQFormCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
    [sub addSubview:self.DQCollectionView];
    
    WeakSelf(weakSelf);
    [self.DQCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(sub.mas_left).offset(70);
        //        make.right.equalTo(sub.mas_right).offset(-70);
        make.width.mas_equalTo(400);
        make.centerX.mas_equalTo(weakSelf.contentView);
        make.top.equalTo(sub.mas_top).offset(15);
        make.bottom.equalTo(sub.mas_bottom).offset(-15);
    }];
    self.DQCollectionView.scrollsToTop = NO;
    self.DQCollectionView.dataSource = self;
    self.DQCollectionView.delegate = self;
    [self.DQCollectionView registerClass:[DQFormCollectionViewCell class] forCellWithReuseIdentifier:DQCollectionCellID];
    
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:label];
    self.titleLabel = label;
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).with.offset(53);
        make.top.mas_equalTo(weakSelf.contentView).with.offset(10);
        make.height.mas_equalTo(14);
    }];
    
    label.text = self.title;
}

- (void)setupMarkLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:label];
    self.markLabel = label;
    WeakSelf(weakSelf);
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView).with.offset(32);
        make.bottom.mas_equalTo(weakSelf.contentView).with.offset(-10);
        make.height.mas_equalTo(14);
    }];
    
    label.text = self.mark;
}

- (void)setupLine{
    UIView *line = [[UIView alloc]initWithFrame:CGRectZero];
    line.backgroundColor = [UIColor colorWithHex:0x666666];
    [self.contentView addSubview:line];
    self.bottomLine = line;
    WeakSelf(weakSelf);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(kOnePixLine);
    }];
}

-(void)setDataArr:(NSMutableArray *)DataArr{
    _DataArr = DataArr;
    NSArray *arr = [_DataArr firstObject];
    _TotalSection = _DataArr.count;
    
    if (!arr.count||!_DataArr.count) {//防空判断
        return;
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat totalWidth = 0;
    NSMutableArray *mwidth = [NSMutableArray arrayWithCapacity:_TotalSection];
    
    switch (self.formType) {
        case DKYFormType_Default:{
            for (NSArray *array in DataArr) {
                CGFloat width = 100;
                for (NSString *title in array) {
                    if(title.length > 2){
                        width = 160;
                        break;
                    }
                }
                totalWidth += width;
                [mwidth addObject:@(width)];
            }
        }
            break;
        case DKYFormType_TypeOne:{
            CGFloat minWidth = 100;
            CGFloat maxWidth = 514 - 32;
            
            UIFont *font = [UIFont systemFontOfSize:13];
            CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
            NSDictionary *attributes = @{NSFontAttributeName : font};
            NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            
            for (NSArray *array in DataArr) {
                CGFloat maxw = 0;
                
                for (NSString *title in array) {
                    CGRect textFrame = [title boundingRectWithSize:size
                                                           options:options
                                                        attributes:attributes
                                                           context:nil];
                    if(textFrame.size.width > maxw){
                        maxw = textFrame.size.width;
                    }
                }
                
                maxw += 50;
                maxw = MIN(MAX(minWidth, maxw), maxWidth);
                maxWidth -= maxw;
                totalWidth += maxw;
                [mwidth addObject:@(maxw)];
            }
        }
            break;
        case DKYFormType_TypeTwo:{
            CGFloat minWidth = 100;
            CGFloat maxWidth = 768 - 32;
            
            UIFont *font = [UIFont systemFontOfSize:13];
            CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
            NSDictionary *attributes = @{NSFontAttributeName : font};
            NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            
            for (NSArray *array in DataArr) {
                CGFloat maxw = 0;
                
                for (NSString *title in array) {
                    CGRect textFrame = [title boundingRectWithSize:size
                                                           options:options
                                                        attributes:attributes
                                                           context:nil];
                    if(textFrame.size.width > maxw){
                        maxw = textFrame.size.width;
                    }
                }
                
                maxw += 10;
                maxw = MIN(MAX(minWidth, maxw), maxWidth);
                maxWidth -= maxw;
                totalWidth += maxw;
                [mwidth addObject:@(maxw)];
            }
            self.contentView.backgroundColor = [UIColor colorWithHex:0xf1f1f1];
        }
            break;
        case DKYFormType_TypeThree:
            totalWidth = 768 - 64 * 2;
            CGFloat lineWidth = totalWidth / DataArr.count;
            for(NSInteger i = 0; i < DataArr.count; ++i){
                [mwidth addObject:@(lineWidth)];
            }
            self.contentView.backgroundColor = [UIColor colorWithHex:0xf1f1f1];
            break;
        case DKYFormType_TypeFour:{
            totalWidth = 768 - 32 * 2;
            CGFloat lineWidth = totalWidth / DataArr.count;
            for(NSInteger i = 0; i < DataArr.count; ++i){
                if(i < 3){
                    [mwidth addObject:@(lineWidth - 40)];
                }else if(i != DataArr.count - 1){
                     [mwidth addObject:@(lineWidth + 20)];
                }else{
                    [mwidth addObject:@(lineWidth + 40)];
                }
            }
        }
            break;
        case DKYFormType_TypeFive:{
            CGFloat lineWidth = 100;
            totalWidth = lineWidth * DataArr.count;
            
            for(NSInteger i = 0; i < DataArr.count; ++i){
                [mwidth addObject:@(lineWidth)];
            }
        }
            break;
        default:
            
            self.contentView.backgroundColor = [UIColor whiteColor];
            break;
    }
    
    self.lineWidthArray = [mwidth copy];
    
    [self.DQCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(totalWidth);
    }];
    
    self.TotalPath = [NSIndexPath indexPathForRow:arr.count-1 inSection:self.TotalSection-1];
    [self.DQCollectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _TotalSection;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.DataArr[section];
    return arr.count;
    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DQFormCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DQCollectionCellID forIndexPath:indexPath];
    NSArray *arr = self.DataArr[indexPath.section];
    [cell setDataFunction:indexPath andTotalPath:self.TotalPath andTitle:arr[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [[self.lineWidthArray objectOrNilAtIndex:indexPath.section] floatValue];
    return CGSizeMake(width, 30);
}


- (CGSize)sizeThatFits:(CGSize)size {
    NSArray *array = [self.DataArr firstObject];
    NSInteger extra = 0;
    if(self.title.length > 0){
        extra = 25;
    }else if(self.mark.length > 0){
        extra = 25;
    }
    return CGSizeMake(size.width, array.count * 30 + 30 + 0.5 + extra);
}

@end
