//
//  AppDelegate+General.h
//  37duxinB
//
//  Created by Zhang Xinrong on 25/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (General)
-(void)generalApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(BOOL)generalApplication:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

@end
