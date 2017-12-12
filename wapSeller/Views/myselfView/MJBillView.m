//
//  MJBillView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJBillView.h"

@implementation MJBillView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.billTableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.billTableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.billTableView];
}

-(UITableView *)billTableView{
    if (_billTableView==nil) {
        _billTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        if (iPhoneX) {
            _billTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-24);
        }
    }
    return _billTableView;
}

@end
