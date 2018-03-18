//
//  SVHUD.m
//  duxin
//
//  Created by 37duxin on 24/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "SVHUD.h"

@implementation SVHUD

+(void)showSuccessWithDelay:(NSString *)message time:(CGFloat)time{
    
    [SVProgressHUD showSuccessWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

+(void)showErrorWithDelay:(NSString *)message time:(CGFloat)time{
    
    [SVProgressHUD showErrorWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

+(void)showSuccessWithDelay:(NSString *)message time:(CGFloat)time blockAction:(void(^)(void))compeletionBlock{
    
    [SVProgressHUD showSuccessWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismissWithCompletion:^{
            compeletionBlock();
        }];
    });
}

@end
