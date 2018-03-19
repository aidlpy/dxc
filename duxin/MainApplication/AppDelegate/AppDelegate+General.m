//
//  AppDelegate+General.m
//  37duxinB
//
//  Created by Zhang Xinrong on 25/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AppDelegate+General.h"
#import "WXApi.h"
#import "Growing.h"


#define WXAPPID @"wx58d13dc9d936cb41"
#define GrowingID @"89eccb6b53e7c822"

@implementation AppDelegate (General)
-(void)generalApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *deviceID = [[UIDevice currentDevice] identifierForVendor].UUIDString;
        CacheDeviceID(deviceID);
        NSLog(@"deviceID==>%@",deviceID);
    });
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    [WXApi registerApp:WXAPPID];
    [Growing startWithAccountId:GrowingID];
}

-(BOOL)generalApplication:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if ([Growing handleUrl:url]) {
        NSLog(@"初始化成功==>%@",@"Growing初始化成功");
        return YES;
        
    }
    return NO;
}
@end
