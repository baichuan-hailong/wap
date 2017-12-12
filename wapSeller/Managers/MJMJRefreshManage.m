//
//  MJMJRefreshManage.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMJRefreshManage.h"

@implementation MJMJRefreshManage
//header refresh
+ (void)headerWithRefreshingTarget:(UIViewController *)target_id tableView:(UITableView *)target_tableView sel:(SEL)sel{
    
    MJRefreshNormalHeader  *header = [MJRefreshNormalHeader  headerWithRefreshingTarget:target_id refreshingAction:sel];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"下拉刷新"   forState:MJRefreshStateIdle];
    [header setTitle:@"释放更新"   forState:MJRefreshStatePulling];
    [header setTitle:@"加载中..."  forState:MJRefreshStateRefreshing];
    target_tableView.mj_header = header;
    
    /**Gif
     MJRefreshGifHeader *git_header = [MJRefreshGifHeader headerWithRefreshingTarget:target_id refreshingAction:sel];
     git_header.lastUpdatedTimeLabel.hidden = YES;
     git_header.stateLabel.hidden = YES;
     
     NSArray *gitArray = @[[UIImage imageNamed:@"git0"],[UIImage imageNamed:@"git1"],[UIImage imageNamed:@"git2"],[UIImage imageNamed:@"git3"],[UIImage imageNamed:@"git4"],[UIImage imageNamed:@"git5"],[UIImage imageNamed:@"git6"],[UIImage imageNamed:@"git7"]];
     
     [git_header setImages:@[[UIImage imageNamed:@"git0"]] forState:MJRefreshStateIdle];
     [git_header setImages:@[[UIImage imageNamed:@"git1"]] forState:MJRefreshStatePulling];
     [git_header setImages:gitArray forState:MJRefreshStateRefreshing];
     target_tableView.mj_header = git_header;
     **/
}


//footer load more
+ (void)footerWithRefreshingTarget:(UIViewController *)target_id tableView:(UITableView *)target_tableView sel:(SEL)sel{
    
    MJRefreshBackNormalFooter *footer;
    footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target_id refreshingAction:sel];
    [footer setTitle:@"正在努力加载更多数据..." forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"已经加载全部数据" forState:MJRefreshStateNoMoreData];
    target_tableView.mj_footer = footer;
    
    /**Gif  gifmore0
     MJRefreshBackGifFooter *gif_footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:target_id refreshingAction:sel];
     gif_footer.stateLabel.hidden = YES;
     
     NSArray *gitArray = @[[UIImage imageNamed:@"gifmore0"],[UIImage imageNamed:@"gifmore1"],[UIImage imageNamed:@"gifmore2"],[UIImage imageNamed:@"gifmore3"],[UIImage imageNamed:@"gifmore4"],[UIImage imageNamed:@"gifmore5"],[UIImage imageNamed:@"gifmore6"],[UIImage imageNamed:@"gifmore7"]];
     
     [gif_footer setImages:@[[UIImage imageNamed:@"gifmore0"]] forState:MJRefreshStateIdle];
     [gif_footer setImages:@[[UIImage imageNamed:@"gifmore0"]] forState:MJRefreshStateWillRefresh];
     [gif_footer setImages:@[[UIImage imageNamed:@"gifmore0"]] forState:MJRefreshStateNoMoreData];
     [gif_footer setImages:gitArray forState:MJRefreshStateRefreshing];
     target_tableView.mj_footer = gif_footer;
     **/
    
    
}



@end
