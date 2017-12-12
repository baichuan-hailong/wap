
//
//  MJMyselfFooterView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/8.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMyselfFooterView.h"

@implementation MJMyselfFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    //[UIColor colorWithHex:primaryColor]
    [MJBtnManager setButton:self.outBtn
                       text:@"退出"
                  textColor:[UIColor colorWithRed:238/255.0 green:23/255.0 blue:23/255.0 alpha:1]
                       font:[UIFont systemFontOfSize:em*48]
                      image:[UIImage imageWithColor:[UIColor whiteColor]]
                     radius:4];
    self.outBtn.layer.borderColor  = [UIColor colorWithRed:238/255.0 green:23/255.0 blue:23/255.0 alpha:1].CGColor;
    self.outBtn.layer.borderWidth  = 0.6;
    self.outBtn.layer.cornerRadius = 4;
    self.outBtn.layer.masksToBounds= YES;
    [self addSubview:self.outBtn];
}


- (UIButton *)outBtn{
    if (_outBtn==nil) {
        _outBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*500)/2, em*600-em*265, em*500, em*132)];
    }
    return _outBtn;
}

 
@end
