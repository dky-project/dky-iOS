//
//  DQFormCollectionViewCell.h
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/23.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DQFormCollectionViewCell : UICollectionViewCell//row line

@property (nonatomic, strong) UILabel *Textlab;
//添加UI的方法 给子类调用
- (void)DQAddSubViewFunction;

//隐藏 上 左 下 右的边框
- (void)HiddenAllSpaceViewFunction;

//上 左 下 右的边框的具体显示或者隐藏的方法 提供子类调用的
- (void)ViewIsHiddenAndShowFuntion:(NSIndexPath *)path andTotalPath:(NSIndexPath *)TotalPath;

//赋值的方法
- (void)setDataFunction:(NSIndexPath *)path andTotalPath:(NSIndexPath *)TotalPath andTitle:(NSString *)title;
@end
