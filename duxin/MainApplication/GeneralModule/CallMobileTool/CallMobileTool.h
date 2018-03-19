//
//  CallMobileTool.h
//  duxin
//
//  Created by Zhang Xinrong on 15/03/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallMobileTool : NSObject
+(void)callwithoutAlert:(NSString *)phoneNumber;
+(void)callwithSystemAlert:(NSString *)phoneNumber viewController:(UIViewController *)vc;
+(void)callwithSystemURL:(NSString *)phoneNumber;
+(void)callwithCustomAlert:(NSString *)phoneNumber alertTitle:(NSString *)title alertMessage:(NSString *)message controller:(UIViewController *)vc;
@end
