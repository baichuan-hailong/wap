//
//  AliPayManager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/30.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "AliPayManager.h"


@implementation AliPayManager
+(instancetype)defaultAli{
    static dispatch_once_t onceToken;
    static AliPayManager *alipay;
    dispatch_once(&onceToken, ^{
        alipay = [[AliPayManager alloc] init];
    });
    return alipay;
}

- (void)rechargeOrder:(NSString *)order{
    
    //应用注册scheme,在Info.plist定义URL types
    NSString *appScheme = @"wapyugouAliPayScheme";
    [[AlipaySDK defaultService] payOrder:order fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSString *stateStr = [NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]];
        if ([stateStr isEqualToString:@"9000"]) {
            //successful
            NSLog(@"block aliPay successful");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaySuccessful" object:nil];
        }else{
            //faile
            NSLog(@"block aliPay failed");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayFailing" object:nil];
        }
    }];
}



@end
