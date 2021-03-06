//
//  DKYMultipleSelectPopupViewCell.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/2/19.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYMultipleSelectPopupViewCell.h"
#import "DKYMultipleSelectPopupItemModel.h"

@interface DKYMultipleSelectPopupViewCell ()

@property (weak, nonatomic) UIImageView *rectImageView;
@property (nonatomic, weak) UILabel *countLabel;

@property (nonatomic, weak) UILabel *contentLabel;
// image
@property (nonatomic, strong) UIImage *normalImage;

@property (nonatomic, copy) UIImage *selectedImage;

@property (nonatomic, weak) UIButton *cancelBtn;

@end

@implementation DKYMultipleSelectPopupViewCell

+ (instancetype)multipleSelectPopupViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYMultipleSelectPopupViewCell";
    DKYMultipleSelectPopupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[DKYMultipleSelectPopupViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

- (void)setItemModel:(DKYDahuoOrderColorModel *)itemModel{
    _itemModel = itemModel;
    
//    self.rectImageView.image = itemModel.selected ? self.selectedImage : self.normalImage;
    self.contentLabel.text = [NSString stringWithFormat:@"%@(%@)",itemModel.colorName,itemModel.colorDesc];
    self.countLabel.text = itemModel.selected ? [NSString stringWithFormat:@"%@",@(itemModel.selectedCount)] : nil;
    self.cancelBtn.hidden = !itemModel.selected;
}

#pragma mark - UI
- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupRectImageView];
    [self setupContentLabel];
    [self setupCancleBtn];
}

- (void)setupRectImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    
    UIImage *image = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(11, 11)];
    self.normalImage = [image imageByRoundCornerRadius:0 borderWidth:0.5 borderColor:[UIColor blackColor]];
    
//    self.selectedImage = [UIImage imageNamed:@"select_icon"];
    self.selectedImage = [UIImage imageWithColor:[UIColor colorWithHex:0x3c3562] size:CGSizeMake(11, 11)];
    
    imageView.image = self.normalImage;
    imageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:imageView];
    self.rectImageView = imageView;
    
    WeakSelf(weakSelf);
    [self.rectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.left.mas_equalTo(weakSelf.contentView).with.offset(32);
        make.centerY.mas_equalTo(weakSelf.contentView);
    }];
    
    self.rectImageView.hidden = YES;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor colorWithHex:0x3c3562];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:label];
    self.countLabel = label;
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.rectImageView);
    }];
}

- (void)setupContentLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor colorWithHex:0x666666];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:label];
    self.contentLabel = label;
    WeakSelf(weakSelf);
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.rectImageView.mas_right).with.offset(35);
        make.top.mas_equalTo(weakSelf.contentView);
        make.bottom.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.contentView);
    }];
}

- (void)setupCancleBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn customButtonWithTypeEx:UIButtonCustomType_Ten];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.selected = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    btn.layer.cornerRadius = 14;
    
    [self.contentView addSubview:btn];
    self.cancelBtn = btn;
    WeakSelf(weakSelf);
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(28);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.contentView).with.offset(-32);
    }];
    
    weakSelf.cancelBtn.hidden = YES;
    
    [weakSelf.cancelBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton*  _Nonnull sender) {
        if(weakSelf.cancelBtnClicked){
            weakSelf.cancelBtnClicked(sender);
        }
    }];
}

@end
