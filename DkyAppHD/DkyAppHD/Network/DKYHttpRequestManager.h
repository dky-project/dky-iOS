//
//  DKYHttpRequestManager.h
//  DkyAppHD
//
//  Created by 胡金丽 on 2016/12/29.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKYHttpRequestTool.h"

@class DKYHttpRequestParameter;
@interface DKYHttpRequestManager : NSObject

/**
 *  获取启动页
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)queryValidUrlWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  获取首页数据
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)articlePageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

// 文章详细信息
- (void)articleDetaiWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  获取查询的所有选项条件
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getDimNewListWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  样衣查询接口
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)productPageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   获取性别选项的文案和枚举值
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getSexEnumWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   获取大类选项的文案和枚举值
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getBigClassEnumWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   样衣详细信息查询
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getProductInfoWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   查询价格列表
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)queryPriceListWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   查询胸围、衣长、肩宽、袖长列表
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)queryValueWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   详情页下单品种，颜色信息
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getColorDimListWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *   根据胸围选择获取数据
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getSizeDataWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  订单查询
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)productApprovePageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  预览订单的时候，具体信息
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)productApproveInfoListWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  删除订单
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)updateProductApproveWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  定制订单获取信息
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getProductApproveTitleWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  定制订单输入款号之后获取信息
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getMadeInfoByProductNameWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  获取vipName字段
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getVipInfoWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  大货订单保存接口
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)mptApproveSaveWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  基础款下单保存接口
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)addProductApproveWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;
/**
 *  品种、组织、针型、支别下拉框操作时需要调用后台接口返回新的下拉框值给这四个下拉框重新填充
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getPzsJsonWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  生成订单接口
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)confirmProductApproveWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  品种下拉框，刷新颜色选项
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getColorListWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  样衣详情页面下单
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)addProductDefaultWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  收藏列表
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getProductCollectPageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  添加收藏
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)addProductCollectWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  取消收藏
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)delProductCollectWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  登录接口
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)LoginUserWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  大货订单查询
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)productApproveBmptPageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  搭配下单
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)addProductDpGroupWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  搭配组号查询
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
-(void)getProductListByGroupNoWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  获取价格
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getProductPriceWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  获取搭配外壳，列表
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getProductGroupPageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  陈列
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getProductListByGhWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;

/**
 *  陈列列表
 *
 *  @param parameter parameter description
 *  @param success   success description
 *  @param failure   failure description
 */
- (void)getProductListGhPageWithParameter:(DKYHttpRequestParameter*)parameter Success:(DKYHttpRequestSuccessBlock)success failure:(DKYHttpRequestErrorBlock)failure;


+(instancetype)sharedInstance;

@end
