//
//  WechatManager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/30.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "WechatManager.h"

@implementation WechatManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WechatManager *wechatmanager;
    dispatch_once(&onceToken, ^{
        wechatmanager = [[WechatManager alloc] init];
    });
    return wechatmanager;
}


//wechat pay
- (void)wechatPay:(NSDictionary *)payDic{
    
    NSString *appID           = @"wxd14a981dc10e087a";
    [WXApi registerApp:appID];
    
    
    NSString *partnerId           = [NSString stringWithFormat:@"%@",payDic[@"payParams"][@"partnerId"]];
    NSString *prepayId            = [NSString stringWithFormat:@"%@",payDic[@"payParams"][@"prepayId"]];
    //NSMutableString *stamp        = @"";
    NSString *timeStamp           = [NSString stringWithFormat:@"%@",payDic[@"payParams"][@"timeStamp"]];
    NSString *nonceStr            = [NSString stringWithFormat:@"%@",payDic[@"payParams"][@"nonceStr"]];
    NSString *package             = [NSString stringWithFormat:@"%@",payDic[@"payParams"][@"packageValue"]];
    NSString *sign                = [NSString stringWithFormat:@"%@",payDic[@"payParams"][@"sign"]];
    
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = partnerId;
    req.prepayId            = prepayId;
    req.timeStamp           = timeStamp.intValue;
    req.nonceStr            = nonceStr;
    req.package             = package;
    req.sign                = sign;
    [WXApi sendReq:req];
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    //NSLog(@"manage onResp -------------------------- %@",resp);
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                NSLog(@"manage wechat pay successful");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaySuccessful" object:nil];
                break;
            default:
                NSLog(@"manage wechat pay failed");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPayFailing" object:nil];
                break;
        }
    }
}




@end
