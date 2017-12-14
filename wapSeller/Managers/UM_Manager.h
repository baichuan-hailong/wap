//
//  UM_Manager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/14.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UM_Manager : NSObject
+ (void)initUm;

+ (void)profileSignInWithPUID:(NSString *)puid;

@end
