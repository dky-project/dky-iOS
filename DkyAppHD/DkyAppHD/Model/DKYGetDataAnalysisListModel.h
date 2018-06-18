//
//  DKYGetDataAnalysisListModel.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2018/6/17.
//  Copyright © 2018年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKYGetDataAnalysisListTotalModel.h"

@interface DKYGetDataAnalysisListModel : NSObject

/*
 *  所属类别
 */
@property (nonatomic, copy) NSArray *MPTBELONGTYPE;

/*
 *  品种
 */
@property (nonatomic, copy) NSArray *DIMFLAG_NEW14;

/*
 *  品类
 */
@property (nonatomic, copy) NSArray *DIMFLAG_16;

/*
 *  系列
 */
@property (nonatomic, copy) NSArray *DIMFLAG_13;

/*
 *  性别
 */
@property (nonatomic, copy) NSArray *DIMFLAG_NEW13;

/*
 *  波段
 */
@property (nonatomic, copy) NSArray *DIMFLAG_14;

/*
 *  针型
 */
@property (nonatomic, copy) NSArray *DIMFLAG_NEW16;

@property (nonatomic, strong) DKYGetDataAnalysisListTotalModel *total;

@end
