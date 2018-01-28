//
//  ShConsultantPackageModel.h
//  duxin
//
//  Created by felix on 2018/1/27.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShConsultantPackageModel : NSObject
/**
 *  ID
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  咨询标题
 */
@property (strong, nonatomic) NSString *title;
/**
 *  服务内容(描述)
 */
@property (strong, nonatomic) NSString *service_content;
/**
 *  咨询次数
 */
@property (assign, nonatomic) NSInteger service_times;
/**
 *  咨询时长(分钟)
 */
@property (assign, nonatomic) NSInteger service_hours;
/**
 *  用户UID
 */
@property (assign, nonatomic) NSInteger uid;
/**
 *  创建套餐时间
 */
@property (assign, nonatomic) NSInteger created_at;
/**
 *  更新套餐时间
 */
@property (assign, nonatomic) NSInteger updated_at;
/**
 *  服务类型(0:预约服务,1:咨询服务)
 */
@property (assign, nonatomic) NSInteger service_type;
/**
 *  咨询方式(0:电话,1:文字[多个用逗号分隔])
 */
@property (strong, nonatomic) NSString *consultation_way;
/**
 *  单次价格(元)
 */
@property (assign, nonatomic) CGFloat single_price;
/**
 *  排序
 */
@property (assign, nonatomic) NSInteger sort;
/**
 *  咨询标签(咨询服务)
 */
@property (strong, nonatomic) NSString *tags;
/**
 *  销售量
 */
@property (assign, nonatomic) NSInteger sales;
/**
 *  评分
 */
@property (assign, nonatomic) CGFloat score;

@end

