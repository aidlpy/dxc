//
//  ShArticalModel.h
//  duxin
//
//  Created by felix on 2018/2/7.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShUserModel.h"

@interface ShArticalModel : NSObject
/**
 *  ID
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  杂志类型(0:情感,1:亲子,2:职场,3:健康,4:科普)
 */
@property (assign, nonatomic) NSInteger type;
/**
 *  用户UID
 */
@property (assign, nonatomic) NSInteger uid;
/**
 *  点赞数
 */
@property (assign, nonatomic) NSInteger likes;

/**
 *  banner
 */
@property (copy, nonatomic) NSString *banner;

/**
 *  desc
 */
@property (copy, nonatomic) NSString *page_description;

/**
 *  desc
 */
@property (copy, nonatomic) NSString *page_keywords;

/**
 *  desc
 */
@property (copy, nonatomic) NSString *page_title;

/**
 *  desc
 */
@property (copy, nonatomic) NSString *preview_text;



/**
 *  简述
 */
@property (copy, nonatomic) NSString *briefly;
/**
 *  收藏数
 */
@property (assign, nonatomic) NSInteger collection;
/**
 *  头图
 */
@property (copy, nonatomic) NSString *head_figure;
/**
 *  文章详细内容
 */
@property (copy, nonatomic) NSString *content;
/**
 *  阅读数
 */
@property (assign, nonatomic) NSInteger views;
/**
 *  发布时间
 */
@property (assign, nonatomic) NSInteger publish_time;
/**
 *  关联用户信息
 */
@property (strong, nonatomic) ShUserModel *user;

+(void)fetchData:(NSArray *)array block:(void(^)(BOOL stop,ShArticalModel *model))fetchModelBlock;

@end
