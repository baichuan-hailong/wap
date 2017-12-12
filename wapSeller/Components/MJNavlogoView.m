//
//  MJNavlogoView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJNavlogoView.h"
@interface MJNavlogoView()
@property(nonatomic,strong)UIImageView *logoImageView;
@end

@implementation MJNavlogoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{

    self.backgroundColor = [UIColor colorWithHex:primaryColor];
    [self addSubview:self.logoImageView];
}


-(UIImageView *)logoImageView{
    if (_logoImageView==nil) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-96.5)/2, 34.75, 96.5, 14.5)];
        if (iPhoneX) {
            _logoImageView.frame = CGRectMake((SCREEN_WIDTH-96.5)/2, 34.75+24, 96.5, 14.5);
        }
        _logoImageView.image = [UIImage imageNamed:@"logo_nav"];
    }
    return _logoImageView;
}

@end
