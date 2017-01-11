//
//  DQHeader.h
//  DQTableFormView
//
//  Created by 邓琪 dengqi on 2016/12/23.
//  Copyright © 2016年 邓琪 dengqi. All rights reserved.
//

#ifndef DQHeader_h
#define DQHeader_h

#import "Masonry.h"
#import "DQFormHeader.h"
#import "DQTableViewCell.h"
#import "DQCanEditTableViewCell.h"
#import "DQTextField.h"
#import "DQCanEditCell.h"
#import "DQFormCollectionView.h"
#import "DQTextField.h"

static NSString *DQGetCellFromNotifition = @"DQGetCellFromNOTIFITION";//一开始点击表格 的通知名字

/** 16进制转RGB*/
#define HEX_COLOR(x_RGB) [UIColor colorWithRed:((float)((x_RGB & 0xFF0000) >> 16))/255.0 green:((float)((x_RGB & 0xFF00) >> 8))/255.0 blue:((float)(x_RGB & 0xFF))/255.0 alpha:1.0f]

#endif /* DQHeader_h */
