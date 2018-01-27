//
//  AAlertView.h
//  duxin
//
//  Created by 37duxin on 27/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AAlertView : NSObject
+(void)alert:(id)controller message:(NSString *)message confirm:(void (^) (void))resultBlock completion:( void (^) (void))completionBlock;
@end
