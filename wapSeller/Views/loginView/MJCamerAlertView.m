//
//  MJCamerAlertView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/4.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJCamerAlertView.h"

@interface MJCamerAlertView()

@property(nonatomic, strong)UIView *alertline;

@property(nonatomic, strong)UIView *cancletline;
@end


@implementation MJCamerAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    self.backgroundColor = [UIColor colorWithHex:@"000000"];
    self.alpha = 0.5;
    
    self.camerView.backgroundColor = [UIColor whiteColor];
    [self.camerView addSubview:self.alertline];
    [self.camerView addSubview:self.cancletline];
    [self.camerView addSubview:self.photoBtn];
    [self.camerView addSubview:self.camerBtn];
    [self.camerView addSubview:self.cancleBtn];
    
    [MJBtnManager setButton:self.photoBtn
                       text:@"选择手机相册照片"
                  textColor:[UIColor colorWithHex:@"f91e1e"]
                       font:[UIFont systemFontOfSize:em*48]
                      image:[UIImage imageWithColor:[UIColor whiteColor]]
                     radius:0];
    
    [MJBtnManager setButton:self.camerBtn
                       text:@"拍照"
                  textColor:[UIColor colorWithHex:@"3a3843"]
                       font:[UIFont systemFontOfSize:em*48]
                      image:[UIImage imageWithColor:[UIColor whiteColor]]
                     radius:0];
    
    [MJBtnManager setButton:self.cancleBtn
                       text:@"取消"
                  textColor:[UIColor colorWithHex:@"818195"]
                       font:[UIFont systemFontOfSize:em*48]
                      image:[UIImage imageWithColor:[UIColor whiteColor]]
                     radius:0];
}

//lazy
- (UIView *)camerView{
    if (_camerView==nil) {
        _camerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, em*555)];
    }
    return _camerView;
}

- (UIView *)alertline{
    if (_alertline==nil) {
        _alertline = [[UIView alloc] initWithFrame:CGRectMake(0, em*178, SCREEN_WIDTH, 1)];
        _alertline.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _alertline.alpha = 0.6;
    }
    return _alertline;
}

- (UIView *)cancletline{
    if (_cancletline==nil) {
        _cancletline = [[UIView alloc] initWithFrame:CGRectMake(0, em*356, SCREEN_WIDTH, em*20)];
        _cancletline.backgroundColor = [UIColor colorWithHex:@"f0f1f8"];
    }
    return _cancletline;
}
//photo
- (UIButton *)photoBtn{
    if (_photoBtn==nil) {
        _photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, em*5, SCREEN_WIDTH, em*168)];
        
    }
    return _photoBtn;
}

- (UIButton *)camerBtn{
    if (_camerBtn==nil) {
        _camerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, em*183, SCREEN_WIDTH, em*168)];
        
    }
    return _camerBtn;
}


- (UIButton *)cancleBtn{
    if (_cancleBtn==nil) {
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, em*382, SCREEN_WIDTH, em*168)];
        
    }
    return _cancleBtn;
}


- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [keyWindow addSubview:self.camerView];
}

- (void)hide{
    self.camerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, em*555);
    self.alpha = 0.5;
    [self.camerView removeFromSuperview];
    [self removeFromSuperview];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.camerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, em*555);
    self.alpha = 0.5;
    [self.camerView removeFromSuperview];
    [self removeFromSuperview];
}

@end
