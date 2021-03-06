//
//  DKYTongkuan5MatchItemView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/12/3.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYTongkuan5MatchItemView.h"

@interface DKYTongkuan5MatchItemView ()

@property (nonatomic, weak) UILabel *titleLabel;

// 袖边
@property (nonatomic, weak) UIButton *optionsBtn;

@end

@implementation DKYTongkuan5MatchItemView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setItemModel:(DKYCustomOrderItemModel *)itemModel{
    [super setItemModel:itemModel];
    
    if(itemModel.title.length > 0){
        self.titleLabel.text = itemModel.title;
    }
    
    if(itemModel.title.length >0 && [itemModel.title hasPrefix:@"*"]){
        NSDictionary *dict = @{NSForegroundColorAttributeName : self.titleLabel.textColor,
                               NSFontAttributeName : self.titleLabel.font};
        NSMutableAttributedString *atitle = [[NSMutableAttributedString alloc] initWithString:itemModel.title attributes:dict];
        
        [atitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
        self.titleLabel.attributedText = atitle;
    }
    
    
    UIFont *font = self.titleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
    UIColor *foregroundColor = self.titleLabel.textColor;
    
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSForegroundColorAttributeName: foregroundColor};
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect textFrame = [itemModel.title boundingRectWithSize:size
                                                     options:options
                                                  attributes:attributes
                                                     context:nil];
    CGFloat offset = itemModel.textFieldLeftOffset > 0 ? itemModel.textFieldLeftOffset : 10;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textFrame.size.width + offset);
    }];
}

- (void)setMadeInfoByProductName:(DKYMadeInfoByProductNameModel *)madeInfoByProductName{
    [super setMadeInfoByProductName:madeInfoByProductName];
//    [self clear];
    if(madeInfoByProductName == nil)  return;
    
    if(self.madeInfoByProductName.productMadeInfoView.mDimNew41Id > 0){
        for (DKYDimlistItemModel *model in self.customOrderDimList.DIMFLAG_NEW41) {
            if([model.ID integerValue] == self.madeInfoByProductName.productMadeInfoView.mDimNew41Id){
                [self.optionsBtn setTitle:model.attribname forState:UIControlStateNormal];
                break;
            }
        }
    }
    
//    if((madeInfoByProductName.productMadeInfoView.mDimNew13Id == 364||
//        madeInfoByProductName.productMadeInfoView.mDimNew13Id == 365)&&
//       madeInfoByProductName.productMadeInfoView.mDimNew12Id == 367){
//        self.optionsBtn.enabled = NO;
//    }else{
//        self.optionsBtn.enabled = YES;
//    }
}

- (void)dealwithMDimNew12IdSelected{
//    if(([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
//        [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
//       ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
//        [self.addProductApproveParameter.mDimNew12Id integerValue] == 368)){
//           self.canEdit = NO;
//       }else{
//           self.canEdit = YES;
//       }
}

- (void)dealwithMDimNew13IdSelected{
//    if(([self.addProductApproveParameter.mDimNew13Id integerValue] == 364||
//        [self.addProductApproveParameter.mDimNew13Id integerValue] == 365)&&
//       ([self.addProductApproveParameter.mDimNew12Id integerValue] == 367||
//        [self.addProductApproveParameter.mDimNew12Id integerValue] == 368)){
//           self.optionsBtn.enabled = NO;
//       }else{
//           self.optionsBtn.enabled = YES;
//       }
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    self.canEdit = YES;
    
    [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
}

- (void)setCanEdit:(BOOL)canEdit{
    [super setCanEdit:canEdit];
    self.optionsBtn.enabled = canEdit;
}

#pragma mark - action method
- (void)optionsBtnClicked:(UIButton*)sender{
    //    if(self.optionsBtnClicked){
    //        self.optionsBtnClicked(sender,sender.tag);
    //    }
    [self showOptionsPicker:sender];
}

#pragma mark - private method
- (void)showOptionsPicker:(UIButton *)sender{
    [self.superview endEditing:YES];
    
    NSMutableArray *item = @[].mutableCopy;
    
    for (DKYDimlistItemModel *model in self.customOrderDimList.DIMFLAG_NEW41) {
        [item addObject:model.attribname];
    }
    
    WeakSelf(weakSelf);
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:sender.extraInfo
                                             cancelButtonTitle:kDeleteTitle
                                                       clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
                                                           DLog(@"buttonIndex = %@ clicked",@(buttonIndex));
                                                           if(buttonIndex != 0){
                                                               [sender setTitle:[item objectOrNilAtIndex:buttonIndex - 1] forState:UIControlStateNormal];
                                                           }else{
                                                               [sender setTitle:sender.originalTitle forState:UIControlStateNormal];
                                                           }
                                                           [weakSelf actionSheetSelected:0 index:buttonIndex];
                                                       }
                                         otherButtonTitleArray:item];
    actionSheet.scrolling = item.count > 10;
    actionSheet.visibleButtonCount = 10;
    actionSheet.destructiveButtonIndexSet = [NSIndexSet indexSetWithIndex:0];
    [actionSheet show];
}

- (void)actionSheetSelected:(NSInteger)tag index:(NSInteger)index{
    NSArray *models = nil;
    models = self.customOrderDimList.DIMFLAG_NEW41;
    
    // 清除
    if(index == 0){
        self.addProductApproveParameter.mDimNew41Id = nil;
        return;
    }
    
    DKYDimlistItemModel *model = [models objectOrNilAtIndex:index - 1];
    self.addProductApproveParameter.mDimNew41Id = @([model.ID integerValue]);
}

#pragma mark - mark
- (void)commonInit{
    [self setupTitleLabel];
    [self setupOptionsBtn];
}

- (void)setupTitleLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:label];
    self.titleLabel = label;
    WeakSelf(weakSelf);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(40);
    }];
}

- (void)setupOptionsBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Six];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.width.mas_equalTo(DKYCustomOrderItemWidth);
    }];
    self.optionsBtn = btn;
    [btn setTitle:@"点击选择配套" forState:UIControlStateNormal];
    btn.originalTitle = btn.currentTitle;
    
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

@end
