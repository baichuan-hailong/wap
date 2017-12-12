//
//  MJOutAlertView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/10.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJOutAlertView.h"

@interface MJOutAlertView()
@property (nonatomic , strong) UIView  *outView;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIView  *middle_line;
@property (nonatomic , strong) UIView  *middleLine;

@property (nonatomic , strong) UIButton  *cancleBtn;
@property (nonatomic , strong) UIButton  *sureBtn;
@end

@implementation MJOutAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"000000"];
        self.alpha = 0;
    }
    return self;
}

- (void)outAlertShow{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [keyWindow addSubview:self.outView];
    
    [UIView animateWithDuration:0.28 animations:^{
        self.alpha = 0.6;
    }];
    
    [self.outView addSubview:self.middle_line];
    [self.outView addSubview:self.middleLine];
    [MJLabelManager setLabel:self.titleLabel
                        text:@"确定退出登录？"
                   textColor:[UIColor colorWithHex:@"2c2c35"]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*48]];
    [self.outView addSubview:self.titleLabel];
    
    [MJBtnManager setButton:self.cancleBtn
                       text:@"取消"
                  textColor:[UIColor colorWithHex:@"2c2c35"]
                       font:[UIFont systemFontOfSize:em*42]
                      image:[UIImage imageWithColor:[UIColor whiteColor]]
                     radius:0];
    [self.outView addSubview:self.cancleBtn];
    
    [MJBtnManager setButton:self.sureBtn
                       text:@"确定"
                  textColor:[UIColor colorWithHex:@"e71a1d"]
                       font:[UIFont systemFontOfSize:em*42]
                      image:[UIImage imageWithColor:[UIColor whiteColor]]
                     radius:0];
    [self.outView addSubview:self.sureBtn];
    
    
    [self.cancleBtn addTarget:self action:@selector(cancleBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(sureBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancleBtnDidClick{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(outClick:)]) {
        [self.delegate outClick:0];
    }
}

- (void)sureBtnDidClick{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(outClick:)]) {
        [self.delegate outClick:1];
    }
}

- (void)outAlertHide{
    [UIView animateWithDuration:0.38 animations:^{
        [self removeFromSuperview];
        self.alpha = 0;
        [self.outView removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self.middleLine removeFromSuperview];
        [self.middle_line removeFromSuperview];
    }];
}


//touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch            = [touches anyObject];
    CGPoint currentPosition   = [touch locationInView:self];
    CGFloat currentY          = currentPosition.y;
    CGFloat currentX          = currentPosition.x;
    if (currentY<em*943||
        currentY>(em*943+em*420)||
        currentX<(SCREEN_WIDTH-em*826)/2||
        currentX>(SCREEN_WIDTH-em*826)/2+em*826){
        [UIView animateWithDuration:0.38 animations:^{
            self.alpha = 0;
            [self removeFromSuperview];
            [self.outView removeFromSuperview];
            [self.titleLabel removeFromSuperview];
            [self.middleLine removeFromSuperview];
            [self.middle_line removeFromSuperview];
        }];
    }
}

//lazy
- (UIView *)outView{
    if (_outView==nil) {
        _outView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*826)/2, em*943, em*826, em*420)];
        _outView.backgroundColor     = [UIColor colorWithHex:@"FFFFFF"];
        _outView.layer.cornerRadius  = 5;
        _outView.layer.masksToBounds = YES;
    }
    return _outView;
}

- (UIView *)middle_line{
    if (_middle_line==nil) {
        _middle_line = [[UIView alloc] initWithFrame:CGRectMake(0, em*283, em*826, 1)];
        _middle_line.backgroundColor     = [UIColor colorWithHex:@"dddde5"];
    }
    return _middle_line;
}

- (UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, em*50, em*826, em*183)];
    }
    return _titleLabel;
}

- (UIView *)middleLine{
    if (_middleLine==nil) {
        _middleLine = [[UIView alloc] initWithFrame:CGRectMake((em*826-1)/2, em*283, 1, em*137)];
        _middleLine.backgroundColor     = [UIColor colorWithHex:@"dddde5"];
    }
    return _middleLine;
}

- (UIButton *)cancleBtn{
    if (_cancleBtn==nil) {
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(1, em*283+1, (em*826-1)/2-2, em*137-1)];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn{
    if (_sureBtn==nil) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((em*826-1)/2+2, em*283+1, (em*826-1)/2-2, em*137-1)];
    }
    return _sureBtn;
}
@end
