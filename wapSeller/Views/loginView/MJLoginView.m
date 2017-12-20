//
//  MJLoginView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJLoginView.h"

@interface MJLoginView()
@property(nonatomic,strong)UIImageView *logoImageView;

@property(nonatomic,strong)UIView *tel_line;
@property(nonatomic,strong)UIView *cod_line;

@end

@implementation MJLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    [self addSubview:self.up_scrollView];
    
    
    [MJBtnManager setButton:self.xieyiBtn
                      title:@"《用户使用协议》"
                  textColor:[UIColor colorWithRed:128/255.0 green:128/255.0 blue:139/255.0 alpha:1]
                       font:[UIFont systemFontOfSize:em*38]
                borderColor:[UIColor colorWithRed:218/255.0 green:218/255.0 blue:230/255.0 alpha:1]
                borderWidth:0
                     radius:0];
    self.xieyiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.up_scrollView addSubview:self.xieyiBtn];

    [MJBtnManager setButton:self.loginBtn
                       text:@"快速登录"
                  textColor:[UIColor whiteColor]
                       font:[UIFont systemFontOfSize:em*48]
                      image:[UIImage imageWithColor:[UIColor colorWithHex:primaryColor]]
                     radius:4];
    [self.up_scrollView addSubview:self.loginBtn];
    
    [self.up_scrollView addSubview:self.logoImageView];
    
    
    [MJTxFieldManager setTxfield:self.telTextField
                       placeText:@"请输入手机号"
                       textColor:[UIColor colorWithRed:98/255.0 green:98/255.0 blue:109/255.0 alpha:1]
                            font:[UIFont systemFontOfSize:em*44]];
    self.telTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.telTextField.tag = 2090;
    //self.telTextField.backgroundColor = [UIColor redColor];
    [self.up_scrollView addSubview:self.telTextField];
    
    
    [MJBtnManager setButton:self.coderBtn
                      title:@"发送验证码"
                  textColor:[UIColor colorWithRed:98/255.0 green:98/255.0 blue:109/255.0 alpha:1]
                       font:[UIFont systemFontOfSize:em*38]
                borderColor:[UIColor colorWithRed:218/255.0 green:218/255.0 blue:230/255.0 alpha:1]
                borderWidth:1
                     radius:4];
    //self.coderBtn.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.coderBtn];
    
    
    self.tel_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
    self.tel_line.alpha = 0.6;
    //self.tel_line.backgroundColor =[UIColor redColor];
    [self.up_scrollView addSubview:self.tel_line];
    
    
    //验证码
    //self.coderTextField.backgroundColor = [UIColor redColor];
    [MJTxFieldManager setTxfield:self.coderTextField
                       placeText:@"请输入验证码"
                       textColor:[UIColor colorWithRed:98/255.0 green:98/255.0 blue:109/255.0 alpha:1]
                            font:[UIFont systemFontOfSize:em*44]];
    self.coderTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.coderTextField.tag = 2091;
    [self.up_scrollView addSubview:self.coderTextField];
    
    self.cod_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
    self.cod_line.alpha = 0.6;
    [self.up_scrollView addSubview:self.cod_line];
    
}



- (UIScrollView *)up_scrollView{
    if (_up_scrollView==nil) {
        _up_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _up_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64+0.5);
        if (iPhoneX) {
            _up_scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-24);
            _up_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-24+0.5);
        }
    }
    return _up_scrollView;
}


- (UIButton *)xieyiBtn{
    if (_xieyiBtn==nil) {
        _xieyiBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*910)/2, em*1120, em*910, em*80)];
        
    }
    return _xieyiBtn;
}



- (UIButton *)loginBtn{
    if (_loginBtn==nil) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*910)/2, em*1270, em*910, em*132)];
    }
    return _loginBtn;
}

- (UIImageView *)logoImageView{
    if (_logoImageView==nil) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*700)/2, em*330, em*700, em*108)];
        _logoImageView.image = [UIImage imageNamed:@"login_logo_image"];
    }
    return _logoImageView;
}


- (UITextField *)telTextField{
    if (_telTextField==nil) {
        _telTextField = [[UITextField alloc] initWithFrame:CGRectMake(em*186, CGRectGetMaxY(self.logoImageView.frame)+em*315, em*521, em*88)];
        
    }
    return _telTextField;
}

- (UIButton *)coderBtn{
    if (_coderBtn==nil) {
        _coderBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*186-em*244, CGRectGetMaxY(self.logoImageView.frame)+em*315, em*244, em*88)];
    }
    return _coderBtn;
}



- (UIView *)tel_line{
    if (_tel_line==nil) {
        _tel_line = [[UIView alloc] initWithFrame:CGRectMake(em*162, CGRectGetMaxY(self.coderBtn.frame)+em*31, SCREEN_WIDTH-em*165-em*162, 1)];
    }
    return _tel_line;
}







- (UITextField *)coderTextField{
    if (_coderTextField==nil) {
        _coderTextField = [[UITextField alloc] initWithFrame:CGRectMake(em*186, CGRectGetMaxY(self.tel_line.frame)+em*59, em*620, em*88)];
        
    }
    return _coderTextField;
}


- (UIView *)cod_line{
    if (_cod_line==nil) {
        _cod_line = [[UIView alloc] initWithFrame:CGRectMake(em*162, CGRectGetMaxY(self.coderTextField.frame)+em*31, SCREEN_WIDTH-em*165-em*162, 1)];
        
    }
    return _cod_line;
}

@end
