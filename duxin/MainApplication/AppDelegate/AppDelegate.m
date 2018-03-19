//
//  AppDelegate.m
//  duxin
//
//  Created by 37duxin on 18/01/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabbarVC.h"
#import "AppDelegate+GETUI.h"
#import "AppDelegate+HelpDesk.h"
#import "AppDelegate+General.h"
#import "PaymentViewController.h"
#import "UPPaymentControl.h"
#import "DemoCallManager.h"
#import "UMSPPPayUnifyPayPlugin.h"
#import "WXApi.h"
#import "LaunchIntroductionView.h"

#define BUGTAGS @"2956004978540e1221154bcc6a7ab4d2"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    BugtagsOptions *options = [[BugtagsOptions alloc] init];
    options.trackingUserSteps = YES; // 具体可设置的属性请查看 Bugtags.h
    [Bugtags startWithAppKey:BUGTAGS invocationEvent:BTGInvocationEventNone options:options];
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self generalApplication:application didFinishLaunchingWithOptions:launchOptions];
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    self.window.backgroundColor = [UIColor whiteColor];
    [self tabbarView];
    
    
    return YES;
}



-(void)tabbarView
{
    
    MainTabbarVC *vc = [[MainTabbarVC alloc] init];
    [[DemoCallManager sharedManager] setMainController:vc];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setHidden:YES];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
 
    
    
#if 1
    [LaunchIntroductionView sharedWithImages:@[Image(@"launch0.png"),Image(@"launch1.png"),Image(@"launch2.png"),Image(@"launch3.png")]];
#elif 0
    [LaunchIntroductionView sharedWithImages:@[Image(@"launch0.png"),Image(@"launch1.png"),Image(@"launch2.png"),Image(@"launch3.png")] buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
#elif 0
    LaunchIntroductionView *launch = [LaunchIntroductionView sharedWithImages:@[Image(@"launch0.png"),Image(@"launch1.png"),Image(@"launch2.png"),Image(@"launch3.png")] buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
    launch.currentColor = [UIColor redColor];
    launch.nomalColor = [UIColor greenColor];
#else
    //只有在存在该storyboard时才调用该方法，否则会引起crash
    [LaunchIntroductionView sharedWithStoryboard:@"Main" images:@[Image(@"launch0.png"),Image(@"launch1.png"),Image(@"launch2.png"),Image(@"launch3.png")] buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
#endif
    
}

-(void)drawView{
    
//    PaySuccessfulViewController *vc = [[PaySuccessfulViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    [nav.navigationBar setHidden:YES];
//    self.window.rootViewController = nav;
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
     [[EMClient sharedClient] applicationDidEnterBackground:application];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    EMError *error = [[EMClient sharedClient] logout:YES];
//    if (!error) {
//        NSLog(@"退出成功");
//    }
    //移除登录更新通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PAYSUCCESSFUL object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOGINEMUSER object:nil];
 
}



#pragma mark -IOS9.0之前的openURL接口
-(BOOL)application:(UIApplication *)app handleOpenURL:(nonnull NSURL *)url{
    
   return [UMSPPPayUnifyPayPlugin handleOpenURL:url];
    
}

-(BOOL)application:(UIApplication *)app openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    return [UMSPPPayUnifyPayPlugin handleOpenURL:url];
    
}



#pragma mark -IOS9.0之后统一的openURL接口
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    __block NSMutableDictionary *_dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if ([url.absoluteString containsString:@"duxinvisapay"]) {
        [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
          
            if ([code isEqualToString:@"success"]) {
                [_dic setObject:@"1" forKey:@"type"];
                [_dic setObject:@"2" forKey:@"payType"];
            }
            else{
                
                [_dic setObject:@"0" forKey:@"type"];
                [_dic setObject:@"2" forKey:@"payType"];
            }
            
            NSNotification *notification =[NSNotification notificationWithName:PAYSUCCESSFUL object:nil userInfo:_dic];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }];
    }
    
    if ([url.absoluteString containsString:@"wx58d13dc9d936cb41"]) {
        NSArray *array = [url.absoluteString componentsSeparatedByString:@"&"];
        if ([array.lastObject isEqualToString:@"ret=0"]) {
            [_dic setObject:@"1" forKey:@"type"];
            [_dic setObject:@"0" forKey:@"payType"];
            NSNotification *notification =[NSNotification notificationWithName:PAYSUCCESSFUL object:nil userInfo:_dic];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
        else
        {
    
            [_dic setObject:@"0" forKey:@"type"];
            [_dic setObject:@"0" forKey:@"payType"];
            NSNotification *notification =[NSNotification notificationWithName:PAYSUCCESSFUL object:nil userInfo:_dic];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
    }
    
    [self generalApplication:app openURL:url options:options];
   
    

    return YES;
}

@end
