//
//  ShConsultAttentionInfoModel.h
//  duxin
//
//  Created by felix on 2018/1/30.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShConsultAttentionInfoModel : NSObject
/**
 *  用户ID
 */
@property (assign, nonatomic) NSInteger to_user_id;
/**
 *  用户头像
 */
@property (strong, nonatomic) NSString *avatar;
/**
 *  用户昵称
 */
@property (strong, nonatomic) NSString *name;

@end
