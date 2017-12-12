//
//  MJMJRefreshManage.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJMJRefreshManage : NSObject
+ (void)headerWithRefreshingTarget:(UIViewController *)target_id tableView:(UITableView *)target_tableView sel:(SEL)sel;

//footer load more
+ (void)footerWithRefreshingTarget:(UIViewController *)target_id tableView:(UITableView *)target_tableView sel:(SEL)sel;
@end
