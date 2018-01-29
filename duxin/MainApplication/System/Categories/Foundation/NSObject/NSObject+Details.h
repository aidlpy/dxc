//
//  NSObject+Details.h
//  lark
//
//  Created by Onery on 15/10/13.
//  Copyright © 2015年 quncaotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Details)
/**
 *  获取该对象所有属性和属性对应的内容
 */
+ (NSDictionary *)getAllPropertiesAndVaulesWithClass:(NSObject * )cls;
/**
 *  获取对象所有的属性
 */
+ (NSArray *)getAllPropertiesWithClass:(NSObject * )cls;

/**
 *  获取对象所有的方法
 */
+ (void)getAllMethodsWithClass:(NSObject * )cls;
@end
