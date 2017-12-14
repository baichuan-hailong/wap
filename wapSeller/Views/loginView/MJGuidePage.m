//
//  MJGuidePage.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/14.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJGuidePage.h"

@interface MJGuidePage()
@property(nonatomic, strong)UIScrollView *up_scrollView;

@property(nonatomic, strong)UIView       *oneView;
@property(nonatomic, strong)UIView       *twoView;
@property(nonatomic, strong)UIView       *threeView;
@property(nonatomic, strong)UIView       *fourView;
@end

@implementation MJGuidePage


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.up_scrollView.backgroundColor = [UIColor whiteColor];
    self.up_scrollView.showsHorizontalScrollIndicator = NO;
    self.up_scrollView.pagingEnabled = YES;
    self.up_scrollView.alwaysBounceHorizontal = NO;
    self.up_scrollView.alwaysBounceVertical = NO;
    [self addSubview:self.up_scrollView];
    
    [self.up_scrollView addSubview:self.oneView];
    [self.up_scrollView addSubview:self.twoView];
    [self.up_scrollView addSubview:self.threeView];
    [self.up_scrollView addSubview:self.fourView];
    
    self.oneView.backgroundColor = [UIColor orangeColor];
    self.twoView.backgroundColor = [UIColor whiteColor];
    self.threeView.backgroundColor=[UIColor yellowColor];
    self.fourView.backgroundColor =[UIColor orangeColor];
    
    self.startBtn.backgroundColor = [UIColor redColor];
    [self.fourView addSubview:self.startBtn];
}


- (UIScrollView *)up_scrollView{
    if (_up_scrollView==nil) {
        _up_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _up_scrollView.contentSize = CGSizeMake(4*SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _up_scrollView;
}

- (UIView *)oneView{
    if (_oneView==nil) {
        _oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _oneView;
}


- (UIView *)twoView{
    if (_twoView==nil) {
        _twoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _twoView;
}

- (UIView *)threeView{
    if (_threeView==nil) {
        _threeView = [[UIView alloc] initWithFrame:CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _threeView;
}

- (UIView *)fourView{
    if (_fourView==nil) {
        _fourView = [[UIView alloc] initWithFrame:CGRectMake(3*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _fourView;
}


- (UIButton *)startBtn{
    if (_startBtn==nil) {
        _startBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 500, 200, 50)];
    }
    return _startBtn;
}

@end
