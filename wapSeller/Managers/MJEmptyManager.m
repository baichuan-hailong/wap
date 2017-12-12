//
//  MJEmptyManager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/3.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJEmptyManager.h"

@implementation MJEmptyManager
+ (void)check:(UITableView *)tableView dataArray:(NSArray *)dataArray emptyView:(MJEmptyView *)emptyView{
    if (dataArray.count>0) {
        [tableView.tableFooterView removeFromSuperview];
        tableView.tableFooterView = nil;
    }else{
        tableView.tableFooterView = emptyView;
    }
}
@end
