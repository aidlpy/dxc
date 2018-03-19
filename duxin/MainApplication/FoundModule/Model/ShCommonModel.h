//
//  ShCommonModel.h
//  duxin
//
//  Created by felix on 2018/2/7.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShLinkModel.h"
#import "ShMetaModel.h"
@interface ShCommonModel : NSObject
/**
 *  列表数据
 */
@property (nonatomic ,strong) NSArray *result;
/**
 *  逻辑码
 */
@property (nonatomic ,assign) NSInteger error_code;
/**
 *  错误信息
 */
@property (nonatomic ,assign) NSString *msg;
/**
 *  返回查询的链接结果集
 */
@property (nonatomic ,assign) ShLinkModel *_links;
/**
 *  返回查询分页信息结果集
 */
@property (nonatomic ,assign) ShMetaModel *_meta;
@end
