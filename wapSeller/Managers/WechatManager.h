//
//  WechatManager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/30.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface WechatManager : NSObject<WXApiDelegate>
+ (instancetype)sharedManager;

//wechat pay
- (void)wechatPay:(NSDictionary *)payDic;
@end
