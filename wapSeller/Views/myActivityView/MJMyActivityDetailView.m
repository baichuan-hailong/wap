//
//  MJMyActivityDetailView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/1.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMyActivityDetailView.h"

@implementation MJMyActivityDetailView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.activityDetailTableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.activityDetailTableView.showsVerticalScrollIndicator = NO;
    self.activityDetailTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:248/255.0 alpha:1];
    [self addSubview:self.activityDetailTableView];
}

-(UITableView *)activityDetailTableView{
    
    if (_activityDetailTableView==nil) {
        _activityDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    }
    return _activityDetailTableView;
}

//successful
- (MJSuccessfulPopView *)successfulPopView{
    if (_successfulPopView==nil) {
        _successfulPopView = [[MJSuccessfulPopView alloc] initWithFrame:SCREEN_BOUNDS];
        _successfulPopView.alpha = 0;
    }
    return _successfulPopView;
}

//failed
- (MJFailedPopView *)failedPopView{
    if (_failedPopView==nil) {
        _failedPopView = [[MJFailedPopView alloc] initWithFrame:SCREEN_BOUNDS];
        _failedPopView.alpha = 0;
    }
    return _failedPopView;
}
@end
