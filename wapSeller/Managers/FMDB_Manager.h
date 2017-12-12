//
//  FMDB_Manager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/4.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDB_Manager : NSObject
+ (instancetype)defaultManager;
- (void)open;

- (void)addData:(NSDictionary *)activityDic;

- (NSMutableArray *)searchData;

- (void)close;

- (void)clear;
@end
