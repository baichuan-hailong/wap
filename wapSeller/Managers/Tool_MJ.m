//
//  Tool_MJ.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/30.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "Tool_MJ.h"

@implementation Tool_MJ
//时间戳传唤为标准时间
+ (NSString *)changeTime:(NSString *)timeStr {
    
    //[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeInterval time = [timeStr doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}



+ (NSString *)changeTimeToDay:(NSString *)timeStr {
    
    NSTimeInterval timeInt = [timeStr doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInt];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}

/** 自定义格式 */
+ (NSString *)changeTime:(NSString *)timeStr withFormatter:(NSString *)dataFormatter{
    
    NSTimeInterval timeInt = [timeStr doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dataFormatter];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInt];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}

@end
