//
//  UIControl+AvoidMultipleClick.h
//  lark
//
//  Created by baohui.qct on 15/9/18.
//  Copyright © 2015年 quncaotech. All rights reserved.
//

/***
*
*用于防止按钮的多次点击
*/

#import <UIKit/UIKit.h>

@interface UIControl (AvoidMultipleClick)
@property (nonatomic,assign)NSTimeInterval am_acceptEventInterval;
@property (nonatomic,assign)BOOL am_ignoreEvent;
@end
