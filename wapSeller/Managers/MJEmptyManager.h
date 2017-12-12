//
//  MJEmptyManager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/3.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MJEmptyView;

@interface MJEmptyManager : NSObject
+ (void)check:(UITableView *)tableView dataArray:(NSArray *)dataArray emptyView:(MJEmptyView *)emptyView;
@end
