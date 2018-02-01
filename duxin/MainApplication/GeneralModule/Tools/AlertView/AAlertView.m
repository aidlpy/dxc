//
//  AAlertView.m
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AAlertView.h"

@implementation AAlertView

+(void)alert:(id)controller message:(NSString *)message confirm:(void (^) (void))resultBlock completion:( void (^) (void))completionBlock{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        nil;
    }];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        resultBlock();
    }];
    
    [alertVc addAction:cancle];
    [alertVc addAction:confirm];
    
    [controller presentViewController:alertVc animated:YES completion:^{
        completionBlock();
    }];
    

}

+(void)alert:(id)controller message:(NSString *)message setTextFiled:(InputBlock)inputBlock confirm:(void (^)(void))resultBlock completion:(void(^)(void))completionBlock{
    
    UIAlertController  *alertView= [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        resultBlock();
    }];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        inputBlock(textField);
    }];
    [controller presentViewController:alertView animated:YES completion:^{
         completionBlock();
    }];
}

@end
