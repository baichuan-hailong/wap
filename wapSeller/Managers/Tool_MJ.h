//
//  Tool_MJ.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/30.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool_MJ : NSObject
//*** 时间戳转换为标准时间 ***//
+ (NSString *)changeTime:(NSString *)timeStr;
+ (NSString *)changeTimeToDay:(NSString *)timeStr;
+ (NSString *)changeTime:(NSString *)timeStr withFormatter:(NSString *)dataFormatter; /* 自定义格式 */

@end
