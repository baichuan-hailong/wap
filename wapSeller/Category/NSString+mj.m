//
//  NSString+mj.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/30.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "NSString+mj.h"

@implementation NSString (mj)
- (BOOL)isNull {
    
    if ([self isEqualToString:@""] ||
        [self isEqualToString:@"<null>"] ||
        [self isEqualToString:@"(null)"] ||
        [self isEqualToString:@"<NULL>"] ||
        [self isEqualToString:@"(NULL)"] ||
        [self isEqualToString:@"null"]   ||
        [self isEqualToString:@"NULL"]   ||
        self == nil) {
        
        return YES;
    } else {
        return NO;
    }
}


/**
 *  JSON字符串转NSDictionary
 *
 *  @param jsonString JSON字符串
 *
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        //NSLog(@"json解析失败：%@",error);
        return nil;
    }
    return dic;
}

@end
