//
//  DKYSampleVarietyView.m
//  DkyAppHD
//
//  Created by 胡金丽 on 2017/12/16.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYSampleOrderPatternItemView.h"

@interface DKYSampleOrderPatternItemView()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *optionsBtn;

@end

@implementation DKYSampleOrderPatternItemView

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
    
    if(itemModel.content.length > 0){
        [self.optionsBtn setTitle:itemModel.content forState:UIControlStateNormal];
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
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textFrame.size.width + 10);
    }];
    
    if(itemModel.zoomed){
        self.titleLabel.font = [UIFont systemFontOfSize:24];
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
        }];
    }
}

- (void)setMadeInfoByProductName:(DKYMadeInfoByProductNameModel *)madeInfoByProductName{
    [super setMadeInfoByProductName:madeInfoByProductName];
    
    [self clear];
    
    if(!madeInfoByProductName) return;
    
    if(self.madeInfoByProductName.productMadeInfoView.mDimNew12Id > 0){
        NSArray *models = self.customOrderDimList.DIMFLAG_NEW12;
        if(self.madeInfoByProductName ){
            models = self.madeInfoByProductName.productCusmptcateView.syShow;
        }
        for (DKYDimlistItemModel *model in models) {
            if([model.ID integerValue] == self.madeInfoByProductName.productMadeInfoView.mDimNew12Id){
                [self.optionsBtn setTitle:model.attribname forState:UIControlStateNormal];
                break;
            }
        }
    }
}

- (void)fetchAddProductApproveInfo{
    
}

- (void)clear{
    // 逻辑属性
    
    // UI 清空
    [self.optionsBtn setTitle:self.optionsBtn.originalTitle forState:UIControlStateNormal];
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
    NSArray *models = nil;
    
    switch (sender.tag) {
        case 0:{
            models = self.customOrderDimList.DIMFLAG_NEW12;
            if(self.madeInfoByProductName){
                models = self.madeInfoByProductName.productCusmptcateView.syShow;
            }
        }
    }
    
    for (DKYDimlistItemModel *model in models) {
        [item addObject:model.attribname];
    }
    
    
    DLog(@"sender.extraInfo = %@",sender.extraInfo);
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
                                                           [weakSelf actionSheetSelected:sender.tag index:buttonIndex];
                                                       }
                                         otherButtonTitleArray:item];
    actionSheet.scrolling = item.count > 10;
    actionSheet.visibleButtonCount = 10;
    actionSheet.destructiveButtonIndexSet = [NSIndexSet indexSetWithIndex:0];
    [actionSheet show];
}

- (void)actionSheetSelected:(NSInteger)tag index:(NSInteger)index{
    NSArray *models = nil;
    DKYDimlistItemModel *model = nil;
    switch (tag) {
        case 0:
            // 清除
            if(index == 0){
                self.addProductApproveParameter.mDimNew12Id = nil;
                return;
            }
            
            models = self.customOrderDimList.DIMFLAG_NEW12;
            if(self.madeInfoByProductName ){
                models = self.madeInfoByProductName.productCusmptcateView.syShow;
            }
            model = [models objectOrNilAtIndex:index - 1];
            self.addProductApproveParameter.mDimNew12Id = @([model.ID integerValue]);
            DLog(@"样式 = %@",self.addProductApproveParameter.mDimNew12Id);
            [self dealWithmDimNew12IdSelected];
            break;
        default:
            break;
    }
}
- (void)dealWithmDimNew12IdSelected{
    self.canEdit = YES;
    self.addProductApproveParameter.needGjxf = YES;
    
    if(self.mDimNew12IdBlock){
        self.mDimNew12IdBlock(nil,0);
    }
    
    if(self.addProductApproveParameter.mDimNew12Id == nil){
        [self clear];
        self.addProductApproveParameter.needGjxf = NO;
        return;
    }
}

#pragma mark - mark

- (void)commonInit{
    // 第一行
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
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(40);
    }];
    label.adjustsFontSizeToFitWidth = YES;
}

- (void)setupOptionsBtn{
    WeakSelf(weakSelf);
    UIButton *btn = [UIButton buttonWithCustomType:UIButtonCustomType_Eleven];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(optionsBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.titleLabel);
        make.top.mas_equalTo(weakSelf);
        
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right);
        //        make.right.mas_equalTo(weakSelf);
        make.width.mas_equalTo(140);
    }];
    self.optionsBtn = btn;
    [btn setTitle:@"点击选择式样" forState:UIControlStateNormal];
    btn.originalTitle = [btn currentTitle];
    btn.tag = 0;
    if(btn.currentTitle.length > 2){
        btn.extraInfo = [btn.currentTitle substringFromIndex:2];
    }
}

@end
