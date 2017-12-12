//
//  MJMyselfView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMyselfView.h"




@implementation MJMyselfView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.myselfTableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.myselfTableView.showsVerticalScrollIndicator = NO;
    //self.myselfTableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    //self.myselfTableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    [self addSubview:self.myselfTableView];
}

-(UITableView *)myselfTableView{
    
    if (_myselfTableView==nil) {
        _myselfTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    }
    return _myselfTableView;
}

- (MJOutAlertView *)outAlertView{
    if (_outAlertView==nil) {
        _outAlertView = [[MJOutAlertView alloc] initWithFrame:SCREEN_BOUNDS];
    }
    
    return _outAlertView;
}
@end
