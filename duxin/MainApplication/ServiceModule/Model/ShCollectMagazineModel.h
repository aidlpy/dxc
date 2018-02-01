//
//  ShCollectMagazineModel.h
//  duxin
//
//  Created by felix on 2018/1/31.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShCollectMagazineModel : NSObject
/**
 *  ID
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  杂志类型(0:情感,1:亲子,2:职场,3:健康,4:科普)
 */
@property (assign, nonatomic) NSInteger type;
/**
 *  标题
 */
@property (assign, nonatomic) NSString *title;
/**
 *  简述
 */
@property (assign, nonatomic) NSString *briefly;
/**
 *  收藏ID
 */
@property (assign, nonatomic) NSInteger uid;
/**
 *  头图
 */
@property (assign, nonatomic) NSString *head_figure;
/**
 *  阅读数
 */
@property (assign, nonatomic) NSInteger views;
/**
 *  发布时间
 */
@property (assign, nonatomic) NSInteger publish_time;
/**
 *  点赞数
 */
@property (assign, nonatomic) NSInteger likes;
/**
 *  文章详细内容
 */
@property (assign, nonatomic) NSString *content;
/**
 *  收藏数
 */
@property (assign, nonatomic) NSInteger collection;
/**
 *  是否在首页展示
 */
@property (assign, nonatomic) NSInteger is_home;
/**
 *  是否在发现页展示
 */
@property (assign, nonatomic) NSInteger is_discover;

@end
