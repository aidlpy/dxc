//
//  AAlertView.h
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^InputBlock)(UITextField *inputTF);

@interface AAlertView : NSObject
+(void)alert:(id)controller message:(NSString *)message confirm:(void (^) (void))resultBlock completion:( void (^) (void))completionBlock;
+(void)alert:(id)controller message:(NSString *)message setTextFiled:(InputBlock)inputBlock confirm:(void (^)(void))resultBlock completion:(void(^)(void))completionBlock;
@end
