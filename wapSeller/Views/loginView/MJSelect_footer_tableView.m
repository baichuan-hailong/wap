//
//  MJSelect_footer_tableView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/27.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJSelect_footer_tableView.h"


@interface MJSelect_footer_tableView()

@property(nonatomic,strong)UIView      *line_view;

@end

@implementation MJSelect_footer_tableView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.line_view.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
    self.line_view.alpha = 0.6;
    [self addSubview:self.line_view];
}

- (UIView *)line_view{
    if (_line_view==nil) {
        _line_view = [[UIView alloc] initWithFrame:CGRectMake(em*30, em*0, em*640-em*60, 1)];
    }
    return _line_view;
}

@end
