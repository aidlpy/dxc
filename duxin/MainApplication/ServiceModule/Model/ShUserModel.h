//
//  ShUserModel.h
//  duxin
//
//  Created by felix on 2018/1/28.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShUserModel : NSObject
/**
 *  用户ID
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  用户头像
 */
@property (strong, nonatomic) NSString *avatar;
/**
 *  用户昵称
 */
@property (strong, nonatomic) NSString *nickname;
/**
 *  性别(1:男,2:女,0:保密)
 */
@property (assign, nonatomic) NSInteger gender;
/**
 *  注册设备来源(0:Android,1:iOS,2:PC)
 */
@property (assign, nonatomic) NSInteger device;
@end
