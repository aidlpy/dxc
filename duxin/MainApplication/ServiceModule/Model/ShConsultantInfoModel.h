//
//  ShConsultantInfoModel.h
//  duxin
//
//  Created by felix on 2018/1/26.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShConsultantProfileModel.h"

@interface ShConsultantInfoModel : NSObject
/**
 *  咨询师用户ID
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  咨询师头像
 */
@property (strong, nonatomic) NSString *avatar;
/**
 *  咨询师地址
 */
@property (strong, nonatomic) NSString *area;
/**
 *  咨询师真实姓名
 */
@property (strong, nonatomic) NSString *name;
/**
 *  咨询师介绍
 */
@property (strong, nonatomic) NSString *introduction;
/**
 *  咨询总数
 */
@property (assign, nonatomic) NSInteger orderCount;
/**
 *  被关注数
 */
@property (assign, nonatomic) NSInteger followCount;
/**
 *  好评度
 */
@property (strong, nonatomic) NSString *praise;
/**
 *  是否关注该咨询师
 */
@property (assign, nonatomic) BOOL IsFollow;
/**
 *  咨询师套餐信息
 */
@property (strong, nonatomic) NSArray *consultationPackage;
/**
 *  咨询师详细信息
 */
@property (strong, nonatomic) ShConsultantProfileModel *consultantProfile;


@end

