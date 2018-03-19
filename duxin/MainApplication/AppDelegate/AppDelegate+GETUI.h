//
//  AppDelegate+GETUI.h
//  37duxinB
//
//  Created by Zhang Xinrong on 25/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AppDelegate.h"
#import <GTSDK/GeTuiSdk.h>
#import <PushKit/PushKit.h> //VOIP支持需要导入PushKit库,实现 PKPushRegistryDelegate

// 杭州个推官网
#define kGtAppId @"76cPgvjp449byoix0T93T5"
#define kGtAppKey @"j2Sz02NbB16wPkL7pAkXb8"
#define kGtAppSecret @"7fLgT8fYya8BmDrBmg1JP6"

@interface AppDelegate (GETUI)<GeTuiSdkDelegate>
-(void)getuiApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(void)getTuiApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
-(void)getTuiApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
@end
