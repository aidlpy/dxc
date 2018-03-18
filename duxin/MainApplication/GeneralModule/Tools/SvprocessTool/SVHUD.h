//
//  SVHUD.h
//  duxin
//
//  Created by 37duxin on 24/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVHUD : NSObject
+(void)showSuccessWithDelay:(NSString *)message time:(CGFloat)time;
+(void)showErrorWithDelay:(NSString *)message time:(CGFloat)time;
+(void)showSuccessWithDelay:(NSString *)message time:(CGFloat)time blockAction:(void(^)(void))compeletionBlock;
@end
