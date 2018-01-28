//
//  LMModel.h
//  duxin
//
//  Created by felix on 2018/1/26.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMModel : NSObject
/**
 *  数据
 */
@property (nonatomic ,strong) id data;
/**
 *  状态码
 */
@property (nonatomic ,assign) NSInteger code;
/**
 *  错误信息
 */
@property (nonatomic ,assign) NSString *message;
/**
 *  是否来自缓存
 */
@property (nonatomic ,assign) BOOL isCache;
@end
