//
//  ShConsultantProfileModel.h
//  duxin
//
//  Created by felix on 2018/1/27.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShConsultantProfileModel : NSObject
/**
 *  ID
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  用户UID
 */
@property (assign, nonatomic) NSInteger cid;
/**
 *  证件类型(0:大陆身份证1:台胞证2:护照)
 */
@property (assign, nonatomic) NSInteger passport_type;
/**
 *  证件号
 */
@property (strong, nonatomic) NSString *passport_no;
/**
 *  证件照正面
 */
@property (strong, nonatomic) NSString *passport_positive;
/**
 *  证件照反面
 */
@property (strong, nonatomic) NSString *passport_opposite;
/**
 *  学历类型(0:小学1:初中2:高中3:大专4:本科5:硕士6:博士及以上)
 */
@property (assign, nonatomic) NSInteger education_type;
/**
 *  学历证书
 */
@property (strong, nonatomic) NSString *education_cert;
/**
 *  资质名称(0:精神科医师1:心理治疗师2:国家婚姻家庭咨询师3:国家二级心理咨询师4:国家三级心理咨询师)
 */
@property (assign, nonatomic) NSInteger qualified_name;
/**
 *  资质编号
 */
@property (strong, nonatomic) NSString *qualified_no;
/**
 *  资质证明
 */
@property (strong, nonatomic) NSString *qualified_cert;
/**
 *  从业年限
 */
@property (strong, nonatomic) NSString *working_years;
/**
 *  累计个案(时长[小时])
 */
@property (strong, nonatomic) NSString *cumulative_time;
/**
 *  受训背景
 */
@property (strong, nonatomic) NSString *trained_background;
/**
 *  职业背景
 */
@property (strong, nonatomic) NSString *professional_background;
/**
 *  擅长领域
 */
@property (strong, nonatomic) NSString *expertise_good;
/**
 *  咨询风格
 */
@property (strong, nonatomic) NSString *advisory_style;
/**
 *  真实姓名
 */
@property (strong, nonatomic) NSString *name;
/**
 *  省
 */
@property (strong, nonatomic) NSString *province;
/**
 *  市
 */
@property (strong, nonatomic) NSString *city;
/**
 *  区(县)
 */
@property (strong, nonatomic) NSString *area;
/**
 *  账户余额
 */
@property (assign, nonatomic) CGFloat amount;
/**
 *  待入账金额
 */
@property (strong, nonatomic) NSString *freeze;
/**
 *  标签
 */
@property (strong, nonatomic) NSString *tags;
/**
 *  介绍
 */
@property (strong, nonatomic) NSString *introduction;
@end

