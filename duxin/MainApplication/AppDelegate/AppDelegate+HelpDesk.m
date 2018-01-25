//
//  AppDelegate+EaseMob.m
//  EasMobSample
//
//  Created by dujiepeng on 12/5/14.
//  Copyright (c) 2014 dujiepeng. All rights reserved.
//

#import "AppDelegate+HelpDesk.h"
#import "LocalDefine.h"
#import "SCLoginManager.h"
#import <Bugly/Bugly.h>
#import "ChatViewController.h"


/**
 *  本类中做了EaseMob初始化和推送等操作
 */


@implementation AppDelegate (HelpDesk)
- (void)easemobApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *deviceID = [[UIDevice currentDevice] identifierForVendor].UUIDString;
        CacheDeviceID(deviceID);
    });
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        //ios8注册apns
        [self registerRemoteNotification];
        [self initHuanXinCustomer];
        [self initIMchat];
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
        [audioSession setActive:YES error:nil];
    
        /*
         环信的注册和登录
         */
        // 环信注册和登录
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerEMCustomerService) name:LOGINEMUSER object:nil];
    
        /*
         注册IM用户【注意:注册建议在服务端创建，而不要放到APP中，可以在登录自己APP时从返回的结果中获取环信账号再登录环信服务器。】
         */
        // 注册环信监听
        [self setupNotifiers];
        
    });
}

-(void)initHuanXinCustomer{
    
    //表情
    [[HDEmotionEscape sharedInstance] setEaseEmotionEscapePattern:@"\\[[^\\[\\]]{1,3}\\]"];
    [[HDEmotionEscape sharedInstance] setEaseEmotionEscapeDictionary:[HDConvertToCommonEmoticonsHelper emotionsDictionary]];
    
    HOptions *option = [[HOptions alloc] init];
    option.appkey = kDefaultAppKey; // 必填项，appkey获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“AppKey”
    option.tenantId = kDefaultTenantId;// 必填项，tenantId获取地址：kefu.easemob.com，“管理员模式 > 设置 > 企业信息”页面的“租户ID”
    //推送证书名字
    option.apnsCertName = @"1221";//(集成离线推送必填)
    //Kefu SDK 初始化,初始化失败后将不能使用Kefu SDK
    HError *initError = [[HChatClient sharedClient] initializeSDKWithOptions:option];
 
    if (!initError) {
        NSLog(@"初始化成功!");
        [self registerEMCustomerService];
    }
    else
    {
        NSLog(@"initError初始化失败!");
        NSLog(@"%d",initError.code);
        
    }
    

}

-(void)initIMchat{
    
    EMOptions *options = [EMOptions optionsWithAppkey:kDefaultAppKey];
    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [self registerIMChat];

}

-(void)registerIMChat{
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:@"iostest" password:@"123456"];
    if (error==nil) {
        NSLog(@"IM注册成功");
    }
    else
    {
        NSLog(@"IM注册失败%d",error.code);
        
    }
    
    EMError *error1= [[EMClient sharedClient] loginWithUsername:@"iostest" password:@"123456"];
    if (!error1) {
        NSLog(@"IM登录成功");
    }
    else
    {
        NSLog(@"IM登录失败%d",error1.code);
        
    }
    
}

-(void)registerEMCustomerService{
    
    NSLog(@"FetchEMUsername==>%@FetchEMPassword==>%@",FetchEMUsername,FetchEMPassword);
    NSString *username = FetchEMUsername;
    NSString *emps = FetchEMPassword;
    
    HError *error =  [[HChatClient sharedClient] registerWithUsername:username password:emps];
    if (error) {
        [self loginEMUserResult];
    }
    else
    {
        NSLog(@"注册%d",error.code);
        [self loginEMUserResult];
    }
    
    [self registerIMChat];
    
}


-(void)loginEMUserResult{
    
    HChatClient *client = [HChatClient sharedClient];
    if (client.isLoggedInBefore != YES) {
        
        NSString *username = FetchEMUsername;
        NSString *emps = FetchEMPassword;
        HError *error = [client loginWithUsername:username password:emps];
        if (!error) { //登录成功
        } else { //登录失败

            NSLog(@"登录%d",error.code);
            return;
        }
    }
    
}


//初始化客服sdk
- (void)initializeCustomerServiceSdk {
    
    //表情
    [[HDEmotionEscape sharedInstance] setEaseEmotionEscapePattern:@"\\[[^\\[\\]]{1,3}\\]"];
    [[HDEmotionEscape sharedInstance] setEaseEmotionEscapeDictionary:[HDConvertToCommonEmoticonsHelper emotionsDictionary]];

#warning SDK注册 APNS文件的名字, 需要与3后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"customer_dev";
#else
    apnsCertName = @"customer";
#endif
    //注册kefu_sdk
    SCLoginManager *lgM = [SCLoginManager shareLoginManager]; //
    HOptions *option = [[HOptions alloc] init];
    option.appkey = lgM.appkey;
    option.showAgentInputState = YES;
    option.tenantId = lgM.tenantId;
    option.enableConsoleLog = YES; //是否打开日志信息
    option.apnsCertName = apnsCertName;
    option.visitorWaitCount = YES; //打开待接入访客排队人数功能
    option.showAgentInputState = YES; //
//    option.kefuRestServer = @"http://sandbox.kefu.easemob.com";
//    option.kefuRestServer = @"http://vpc10.kefu.easemob.com";
    HChatClient *client = [HChatClient sharedClient];
    HError *initError = [client initializeSDKWithOptions:option];
    if (initError) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"initialization_error", @"Initialization error!") message:initError.errorDescription delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self registerEaseMobNotification];

}


//修改关联app后需要重新初始化
- (void)resetCustomerServiceSDK {
    //如果在登录状态,账号要退出
    HChatClient *client = [HChatClient sharedClient];
    HError *error = [client logout:NO];
    if (error != nil) {
            NSLog(@"登出出错:%@",error.errorDescription);
    }
//    SCLoginManager *lgM = [SCLoginManager shareLoginManager];
//#warning "changeAppKey 为内部方法，不建议使用"
//    HError *er = [client changeAppKey:lgM.appkey];
//    if (er == nil) {
////        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"appkey_updated", @"Appkey has been updated")];
////        [SVProgressHUD dismissWithDelay:1.0];
//        NSLog(@"appkey 已更新");
//    } else {
//        NSLog(@"appkey 更新失败,请手动重启");
//    }
}

// 监听系统生命周期回调，以便将需要的事件传给SDK
- (void)setupNotifiers{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterBackgroundNotif:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidFinishLaunching:)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActiveNotif:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActiveNotif:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidReceiveMemoryWarning:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillTerminateNotif:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataWillBecomeUnavailableNotif:)
                                                 name:UIApplicationProtectedDataWillBecomeUnavailable
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataDidBecomeAvailableNotif:)
                                                 name:UIApplicationProtectedDataDidBecomeAvailable
                                               object:nil];
}

#pragma mark - notifiers
- (void)appDidEnterBackgroundNotif:(NSNotification*)notif{
    [[HChatClient sharedClient] applicationDidEnterBackground:notif.object];
    
}

- (void)appWillEnterForeground:(NSNotification*)notif
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[HChatClient sharedClient] applicationWillEnterForeground:notif.object];
}

- (void)appDidFinishLaunching:(NSNotification*)notif
{
//    [[HChatClient sharedClient] applicationdidfinishLounching];
 //   [[EaseMob sharedInstance] applicationDidFinishLaunching:notif.object];
}

- (void)appDidBecomeActiveNotif:(NSNotification*)notif
{
  //  [[EaseMob sharedInstance] applicationDidBecomeActive:notif.object];
}

- (void)appWillResignActiveNotif:(NSNotification*)notif
{
 //   [[EaseMob sharedInstance] applicationWillResignActive:notif.object];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeRecording" object:nil];
}

- (void)appDidReceiveMemoryWarning:(NSNotification*)notif
{
 //   [[EaseMob sharedInstance] applicationDidReceiveMemoryWarning:notif.object];
}

- (void)appWillTerminateNotif:(NSNotification*)notif
{
//    [[EaseMob sharedInstance] applicationWillTerminate:notif.object];
}

- (void)appProtectedDataWillBecomeUnavailableNotif:(NSNotification*)notif
{
}

- (void)appProtectedDataDidBecomeAvailableNotif:(NSNotification*)notif
{
}

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HChatClient sharedClient] bindDeviceToken:deviceToken];
    });
}

// 注册deviceToken失败，此处失败，与环信SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns)
                                                    message:error.description
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
}

// 注册推送
- (void)registerRemoteNotification{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
}

#pragma mark - registerEaseMobNotification

- (void)registerEaseMobNotification
{
    // 将self 添加到SDK回调中，以便本类可以收到SDK回调
    [[HChatClient sharedClient] addDelegate:self delegateQueue:nil];
}

- (void)unRegisterEaseMobNotification{
    [[HChatClient sharedClient] removeDelegate:self];
}


#pragma mark - IChatManagerDelegate

- (void)connectionStateDidChange:(HConnectionState)aConnectionState {
    switch (aConnectionState) {
        case HConnectionConnected: {
            break;
        }
        case HConnectionDisconnected: {
            break;
        }
        default:
            break;
    }
}

- (void)userAccountDidRemoveFromServer {
    [self userAccountLogout];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompta", @"Prompt") message:NSLocalizedString(@"loginUserRemoveFromServer", @"your login account has been remove from server") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)userAccountDidLoginFromOtherDevice {
    [self userAccountLogout];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompta", @"Prompt") message:NSLocalizedString(@"loginAtOtherDevice", @"your login account has been in other places") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)userDidForbidByServer {
    [self userAccountLogout];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompta", @"Prompt") message:NSLocalizedString(@"userDidForbidByServer", @"your login account has been forbid by server") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)userAccountDidForcedToLogout:(HError *)aError {
    [self userAccountLogout];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompta", @"Prompt") message:NSLocalizedString(@"userAccountDidForcedToLogout", @"your login account has been forced logout") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
}

//退出当前
- (void)userAccountLogout {
    [[HChatClient sharedClient] logout:YES];
    ChatViewController *chat = [SCLoginManager shareLoginManager].curChat;
    if (chat) {
        [chat backItemClicked];
    }
}

@end
