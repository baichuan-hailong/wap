//
//  MJUpdateUserInfo.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/1.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJUpdateUserInfo.h"

@implementation MJUpdateUserInfo

+ (void)updateInfo{
    NSString *user_id    =  [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
    if (![user_id isNull]) {
        
        //um 账号统计
        [UM_Manager profileSignInWithPUID:user_id];
        
        NSDictionary *data   = @{@"oid":user_id};
        NSDictionary *pradic = [data signWithSecurityKey];
        NSString *testurl    = [NSString stringWithFormat:@"%@/client/getById",API];
        
        [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"client user info --- %@",object);
            NSString *s = [NSString stringWithFormat:@"%@",object[@"s"]];
            if ([s isEqualToString:@"1"]) {
                
                //0-1-2 升级状态 未-成功-失败
                NSString *sellerAuditResult = [NSString stringWithFormat:@"%@",object[@"data"][@"sellerAuditResult"]];
                [[NSUserDefaults standardUserDefaults] setObject:sellerAuditResult forKey:Seller_AuditResult];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateuserinfo" object:object[@"data"]];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",object[@"data"][@"sellerAuditResult"]] forKey:Seller_AuditResult];
                
                if (![[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
                    MJLoginViewController *loginVC = [[MJLoginViewController alloc] init];
                    UINavigationController *logNC  = [[UINavigationController alloc] initWithRootViewController:loginVC];
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:logNC animated:NO completion:nil];
                }else{
                    //logined
                    NSString *sellerAuditResult = [[NSUserDefaults standardUserDefaults] stringForKey:Seller_AuditResult];
                    //sellerAuditResult = @"1";
                    if ([sellerAuditResult isEqualToString:@"0"]) {
                        //0 未升级 等待状态
                        MJUpWaitingViewController *upWairing = [[MJUpWaitingViewController alloc] init];
                        upWairing.isSuccessful = YES;
                        UINavigationController *upWaitingNV = [[UINavigationController alloc] initWithRootViewController:upWairing];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:upWaitingNV animated:NO completion:nil];
                    }else if ([sellerAuditResult isEqualToString:@"1"]){
                        //1 升级成功
                    }else{
                        //2 升级失败
                        MJUpWaitingViewController *upWairing = [[MJUpWaitingViewController alloc] init];
                        upWairing.isSuccessful = NO;
                        UINavigationController *upWaitingNV = [[UINavigationController alloc] initWithRootViewController:upWairing];
                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:upWaitingNV animated:NO completion:nil];
                    }
                }
            }
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"updateuserinfo" object:nil];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }
}








+ (void)checkSysUp{
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"有新版本，前往更新？"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去升级"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         NSLog(@"sure");
                                                         //1326736470
                                                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://geo.itunes.apple.com/cn/app/id1326736470"]];
                                                     }];
    
    UIAlertAction *cancle  = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action) {
                                                        NSLog(@"cancle");
                                                    }];
    [cancle setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [okAction setValue:[UIColor colorWithHex:primaryColor] forKey:@"titleTextColor"];
    
    
    
    
    
    NSDictionary *data   = @{@"appid":@"VIP",@"appos":@"IOS",@"appversion":VERSION_MJ};
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/version/getLatestVersion",API];
    
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        //NSLog(@"sys up --- %@",object);
        NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
        if ([status isEqualToString:@"1000"]) {
            NSString *latestVersion  = [NSString stringWithFormat:@"%@",object[@"data"][@"latestVersion"]];
            NSString *mustUpdateFlag = [NSString stringWithFormat:@"%@",object[@"data"][@"mustUpdateFlag"]];
            if ([mustUpdateFlag integerValue]==1) {
                //strong
                //[alertDialog addAction:okAction];
                //[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertDialog animated:YES completion:nil];
            }else{
                if ([latestVersion floatValue]>[VERSION_MJ floatValue]) {
                    [alertDialog addAction:cancle];
                    [alertDialog addAction:okAction];
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertDialog animated:YES completion:nil];
                }
            }
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



+ (void)checkSysStrongUp{
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"有新版本，前往更新？"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去升级"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         NSLog(@"sure");
                                                         //1326736470
                                                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://geo.itunes.apple.com/cn/app/id1326736470"]];
                                                     }];
    
    UIAlertAction *cancle  = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action) {
                                                        NSLog(@"cancle");
                                                    }];
    [cancle setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [okAction setValue:[UIColor colorWithHex:primaryColor] forKey:@"titleTextColor"];
    
    
    
    
    
    NSDictionary *data   = @{@"appid":@"VIP",@"appos":@"IOS",@"appversion":VERSION_MJ};
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/version/getLatestVersion",API];
    
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"sys up --- %@",object);
        NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
        if ([status isEqualToString:@"1000"]) {
            NSString *mustUpdateFlag = [NSString stringWithFormat:@"%@",object[@"data"][@"mustUpdateFlag"]];
            if ([mustUpdateFlag integerValue]==1) {
                //strong
                [alertDialog addAction:okAction];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertDialog animated:YES completion:nil];
            }
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

@end
