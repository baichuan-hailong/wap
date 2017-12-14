//
//  Define.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

/**
 
 *  完美解决Xcode NSLog打印不全的宏 亲测目前支持到8.2bate版
 
 */
#ifdef DEBUG
//#define NSLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSLog(format, ...)
#endif





#ifndef Define_h
#define Define_h


//server
#define API         @"http://192.168.199.14:9080/mjyg-purchase-web-client-mobile/app"
//#define API         @"http://192.168.199.106:8080/mjyg-purchase-web-client-mobile/app"

//Base
#define primaryColor @"F11E27"

//em
#define em SCREEN_WIDTH/1242

//VERSION
#define VERSION_MJ           @"1.0"
#define IS_First             @"is_login_mjyg"    //是否登录

//User INFO
#define IS_LOGIN             @"is_login_mjyg"    //是否登录
#define SecurityKey          @"securityKey_mj"   //SecurityKey
#define UserID               @"useridoid"        //用户id
#define LoginTel             @"logintel"         //账户
#define PromoterId           @"promoterId"       //邀请码

#define IS_Seller             @"isSeller"          //up提交与否
#define Seller_AuditResult    @"sellerAuditResult" //up审核结果
#define IS_HaveUPCommit       @"ishaveupcommit"    //up是否有提交


//科大讯飞APPID
#define APPID_VALUE_KD        @"5a2e27ba"

//JPUSH AppKey
#define JPushAppKey           @"3e26e3867227f1dc272ad9c2"
#define JPregistrationId      @"jp_registrationId"

//MU
#define UMAppKey              @"5a31d0768f4a9d5cc100018b" //dev
//#define UMAppKey            @"5a31d134f43e4823610000c1" //dev


//*** 屏幕尺寸 ***//
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

//Devices
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080,1920), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)

//宏定义，判断是否是 iOS10.0以上
#define iOS10_mj ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)

#endif /* Define_h */





