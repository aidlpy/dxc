//
//  CallMobileTool.m
//  duxin
//
//  Created by Zhang Xinrong on 15/03/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "CallMobileTool.h"

@implementation CallMobileTool

+(void)callwithoutAlert:(NSString *)phoneNumber
{
    NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+(void)callwithSystemAlert:(NSString *)phoneNumber viewController:(UIViewController *)vc
{
    NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",phoneNumber];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [vc.view addSubview:callWebview];
}

+(void)callwithSystemURL:(NSString *)phoneNumber
{
    NSMutableString* str=[[NSMutableString alloc]initWithFormat:@"telprompt://%@",phoneNumber];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}

+(void)callwithCustomAlert:(NSString *)phoneNumber alertTitle:(NSString *)title alertMessage:(NSString *)message controller:(UIViewController *)vc
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                          
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [CallMobileTool callwithSystemURL:phoneNumber];

    }];
                          
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    [vc presentViewController:alertController animated:YES completion:nil];
}



@end
