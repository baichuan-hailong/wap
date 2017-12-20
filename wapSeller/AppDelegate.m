//
//  AppDelegate.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/23.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "AppDelegate.h"
#import <JPUSHService.h>
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<UITabBarControllerDelegate,JPUSHRegisterDelegate>
@property(nonatomic) NSInteger applicationIconBadgeNumber;
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor    = [UIColor whiteColor];
    MJTabBarController *tabBarC    = [[MJTabBarController alloc] init];
    tabBarC.delegate               = self;
    self.window.rootViewController = tabBarC;
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failedOutLogin) name:@"failedoutlogin" object:nil];
    /** net **/
    [CheckNetManage checkCurrentNetStateWindow:self.window];
    
    /** JPush **/
    //Required
    //注册
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // 获取IDFA 64D07617-13A3-4E9B-A58A-FF61B7D2FDF2
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"advertisingId --- %@",advertisingId);
    // Required --- init Push
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:@"App Store"
                 apsForProduction:NO
            advertisingIdentifier:advertisingId];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:JPregistrationId];
        }else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];

    //GP  login
    [[GuidePageManager defaultManage] checkGuidPage];
    //UM //科大讯飞
    [UM_Manager initUm];
    //login
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]&&
        [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@%@",IS_First,VERSION_MJ]]) {
        [MJUpdateUserInfo checkSysUp];
    }
    
    return YES;
}




/**JPush**/
//Required - 注册 结果 DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"jpush deviceToken --- %@",deviceToken);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

//JPUSHRegisterDelegate
//ios7 -10
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (application.applicationState !=UIApplicationStateActive) {
        NSLog(@"%@",userInfo);
        //notification fresh
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationfreshwait" object:nil];
    }else{
        //notification fresh
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationfreshwait" object:nil];
    }
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    completionHandler(UIBackgroundFetchResultNewData);
}



//url 9.0-
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"appDelegate result 9.0 = %@",resultDic);
            NSString *stateStr = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
            //pay successful
            if ([stateStr isEqualToString:@"9000"]) {
                //NSLog(@"appDelegate 9.0- pay successful");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaySuccessful" object:nil];
            }else{
                NSLog(@"appDelegate 9.0- pay failed");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayFailing" object:nil];
            }
        }];
    }else{
        return [WXApi handleOpenURL:url delegate:[WechatManager sharedManager]];
    }
    return YES;
}

//url 9.0+
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString *stateStr = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
            //pay successful
            if ([stateStr isEqualToString:@"9000"]) {
                //NSLog(@"appDelegate 9.0+ pay successful");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaySuccessful" object:nil];
            }else{
                //NSLog(@"appDelegate 9.0+ pay failed");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayFailing" object:nil];
            }
        }];
    }else{
        return [WXApi handleOpenURL:url delegate:[WechatManager sharedManager]];
    }
    return YES;
}

//wechat api
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:[WechatManager sharedManager]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (application.applicationIconBadgeNumber > 0) {
        application.applicationIconBadgeNumber = 0;
    }
    
    
    //login
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]&&
        [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@%@",IS_First,VERSION_MJ]]) {
        [MJUpdateUserInfo checkSysStrongUp];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



/*CUSTOME*/
#pragma mark - Delegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"%lu",(unsigned long)tabBarController.selectedIndex);
}


#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知");
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    //notification fresh
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationfreshwait" object:nil];
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知");
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
         
    }else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    //notification fresh
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationfreshwait" object:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    completionHandler();  // 系统要求执行这个方法
}


#endif
/**
 **/


#pragma mark - 登陆失败
- (void)failedOutLogin{
    MJLoginViewController *loginVC = [[MJLoginViewController alloc] init];
    UINavigationController *logNC  = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.window.rootViewController presentViewController:logNC animated:NO completion:nil];
}

@end
