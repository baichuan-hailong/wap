//
//  MJMyActivityView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMyActivityView.h"

@interface MJMyActivityView()
@property(nonatomic,strong)MJNavlogoView *navlogoView;
@end



@implementation MJMyActivityView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self addSubview:self.navlogoView];
    self.myActivityTableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.myActivityTableView.showsVerticalScrollIndicator = NO;
    self.myActivityTableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    //self.myActivityTableView.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
    [self addSubview:self.myActivityTableView];
}

- (MJNavlogoView *)navlogoView{
    if (_navlogoView==nil) {
        _navlogoView = [[MJNavlogoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        if (iPhoneX) {
            _navlogoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64+24);
        }
    }
    return _navlogoView;
}

- (UITableView *)myActivityTableView{
    if (_myActivityTableView==nil) {
        _myActivityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
        if (iPhoneX) {
            _myActivityTableView.frame = CGRectMake(0, 64+24, SCREEN_WIDTH, SCREEN_HEIGHT-64-49-24);
        }
    }
    return _myActivityTableView;
}



@end
