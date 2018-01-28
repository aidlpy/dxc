//
//  SHModel.h
//  duxin
//
//  Created by felix on 2018/1/26.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHModel : NSObject
/**
 *  数据
 */
@property (nonatomic ,strong) id result;
/**
 *  逻辑码
 */
@property (nonatomic ,assign) NSInteger error_code;
/**
 *  错误信息
 */
@property (nonatomic ,assign) NSString *msg;
@end
