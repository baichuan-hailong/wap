//
//  AliPayManager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/30.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

@interface AliPayManager : NSObject
+(instancetype)defaultAli;

- (void)rechargeOrder:(NSString *)order;
@end
