//
//  MJRegularManager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/29.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJRegularManager : NSObject
+ (BOOL) checkMobile:(NSString *)mobileNumbel;
+ (BOOL) checkUserIdCard :(NSString *)idCard;
+ (BOOL) checkPassword:(NSString *) password;
+ (BOOL) checkURL : (NSString *) url;
+ (BOOL) checkUserName : (NSString *) userName;
+ (BOOL) checkEmail:(NSString *)email;
@end
