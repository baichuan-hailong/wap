//
//  NSDictionary+mj.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/30.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (mj)

//完善
- (NSDictionary *)prefectWithDic;

//签名验证
- (NSDictionary *)signWithSecurityKey;



@end
