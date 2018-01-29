//
//  ShConsultantCommentDetailModel.h
//  duxin
//
//  Created by felix on 2018/1/28.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShUserModel.h"
@interface ShConsultantCommentDetailModel : NSObject
/**
 *  ID
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  用户UID
 */
@property (assign, nonatomic) NSInteger uid;
/**
 *  咨询师ID
 */
@property (assign, nonatomic) NSInteger cid;
/**
 *  父评论ID
 */
@property (assign, nonatomic) NSInteger fid;
/**
 *  订单ID
 */
@property (assign, nonatomic) NSInteger oid;
/**
 *  评论时间
 */
@property (assign, nonatomic) NSInteger evaluation_at;
/**
 *  是否来访者主动评价(0:否,1:是)
 */
@property (assign, nonatomic) NSInteger is_initiative;
/**
 *
 */
@property (assign, nonatomic) NSInteger order_number;
/**
 *
 */
@property (strong, nonatomic) NSString *evaluation;
/**
 * 评分
 */
@property (assign, nonatomic) NSInteger start;
/**
 *
 */
@property (strong, nonatomic) NSString *reply;
/**
 *
 */
@property (assign, nonatomic) NSString *reply_at;
/**
 *  类型 (0:预约订单,1:咨询订单)
 */
@property (strong, nonatomic) NSString *type;
/**
 *
 */
@property (strong, nonatomic) NSString *is_main;
/**
 *
 */
@property (strong, nonatomic) ShUserModel *user;
@end
