//
//  ShConsultantCommentModel.h
//  duxin
//
//  Created by felix on 2018/1/28.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShUserModel.h"

@interface ShConsultantCommentModel : NSObject
/**
 *  评论总条数
 */
@property (assign, nonatomic) NSInteger count;
/**
 *  页码
 */
@property (assign, nonatomic) NSInteger pageNum;

/**
 *  每页数量
 */
@property (assign, nonatomic) NSInteger limit;

/**
 *  评论数据
 */
@property (strong, nonatomic) NSArray *list;

@end
