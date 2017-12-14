//
//  UM_Manager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/14.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "UM_Manager.h"

@implementation UM_Manager
+ (void)initUm{
    
    //科大讯飞
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", @"5a2e27ba"];
    [IFlySpeechUtility createUtility:initString];
    
    
    //um
    UMConfigInstance.appKey = UMAppKey;
    UMConfigInstance.channelId = @"App Store";
    //UMConfigInstance.eSType = E_UM_GAME;
    //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //NSLog(@"%@",version);
    [MobClick setAppVersion:version];
}

+ (void)profileSignInWithPUID:(NSString *)puid{
    [MobClick profileSignInWithPUID:puid];
}
@end
