//
//  ShCollectDetailModel.h
//  duxin
//
//  Created by felix on 2018/1/31.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShUserModel.h"
#import "ShCollectMagazineModel.h"

@interface ShCollectDetailModel : NSObject
/**
 *  收藏ID
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  用户ID
 */
@property (assign, nonatomic) NSInteger uid;
/**
 *  收藏类型
 */
@property (assign, nonatomic) NSInteger type;
/**
 *  收藏文章ID
 */
@property (assign, nonatomic) NSInteger pid;
/**
 *  收藏时间
 */
@property (assign, nonatomic) NSInteger created_at;
/**
 *  关联文章信息
 */
@property (strong, nonatomic) ShCollectMagazineModel *magazine;
/**
 *  关联文章作者信息
 */
@property (strong, nonatomic) ShUserModel *magazineUser;

@end
