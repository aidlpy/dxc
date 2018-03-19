//
//  ShLinkModel.h
//  duxin
//
//  Created by felix on 2018/2/7.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShLinkModel : NSObject
/**
 *  当前页url
 */
//@property (nonatomic ,assign) NSString *self;
/**
 *  下一页url
 */
@property (nonatomic ,assign) NSString *next;
/**
 *  最后一页url
 */
@property (nonatomic ,assign) NSString *last;
@end
