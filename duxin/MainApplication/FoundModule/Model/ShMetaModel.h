//
//  ShMetaModel.h
//  duxin
//
//  Created by felix on 2018/2/7.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShMetaModel : NSObject
/**
 *  总条数
 */
@property (nonatomic ,assign) NSInteger totalCount;
/**
 *  总页数
 */
@property (nonatomic ,assign) NSInteger pageCount;
/**
 *  当前页数
 */
@property (nonatomic ,assign) NSInteger currentPage;
/**
 *  每页数量
 */
@property (nonatomic ,assign) NSInteger perPage;

@end
