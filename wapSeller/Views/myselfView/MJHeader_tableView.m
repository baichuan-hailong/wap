//
//  MJHeader_tableView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJHeader_tableView.h"

@interface MJHeader_tableView()

@property(nonatomic,strong)UIView      *line_view;

@end

@implementation MJHeader_tableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.line_view.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
    //self.line_view.alpha = 0.6;
    [self addSubview:self.line_view];
    
    //self.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
}

- (UIView *)line_view{
    if (_line_view==nil) {
        _line_view = [[UIView alloc] initWithFrame:CGRectMake(em*33, em*0, SCREEN_WIDTH-em*33, 0.5)];
    }
    return _line_view;
}

@end
