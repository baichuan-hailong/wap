//
//  MJPayView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/27.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJPayView.h"

@interface MJPayView()
@property(nonatomic, strong)UIScrollView *up_scrollView;

@property(nonatomic, strong)UIView       *moneyView;
@property(nonatomic, strong)UILabel      *moneyTipLabel;

@property(nonatomic,strong)UIView        *line_view;

//wechat
@property(nonatomic,strong)UIImageView *wechatImageView;
@property(nonatomic,strong)UILabel     *wechatLabel;

//alipay
@property(nonatomic,strong)UIImageView *aliImageView;
@end

@implementation MJPayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    [self addSubview:self.up_scrollView];
    
    [self.up_scrollView addSubview:self.moneyView];
    
    
    [MJTxFieldManager setTxfield:self.moneyTextField
                       placeText:@"请输入充值金额"
                       textColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:149/255.0 alpha:1]
                            font:[UIFont systemFontOfSize:em*48]];
    self.moneyTextField.textAlignment   = NSTextAlignmentLeft;
    self.moneyTextField.keyboardType    = UIKeyboardTypeNumbersAndPunctuation;
    [self.moneyView addSubview:self.moneyTextField];
    
    
    [MJLabelManager setLabel:self.moneyTipLabel
                        text:@"元"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    //self.moneyTipLabel.backgroundColor = [UIColor yellowColor];
    [self.moneyView addSubview:self.moneyTipLabel];
    
    
    //wechat
    [self.up_scrollView addSubview:self.wechatImageView];
    [MJLabelManager setLabel:self.wechatLabel
                        text:@"微信支付"
                           r:45
                           g:156
                           b:30
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    //self.wechatLabel.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.wechatLabel];
    
    [self.up_scrollView addSubview:self.line_view];
    
    //self.wechatBtn.backgroundColor = [UIColor lightGrayColor];
    [self.wechatBtn setImage:[UIImage imageNamed:@"selecte_ture"] forState:UIControlStateNormal];
    [self.up_scrollView addSubview:self.wechatBtn];
    
    
    
    //ali
    [self.up_scrollView addSubview:self.aliImageView];
    
    //self.aliBtn.backgroundColor = [UIColor lightGrayColor];
    [self.aliBtn setImage:[UIImage imageNamed:@"selecte_false"] forState:UIControlStateNormal];
    [self.up_scrollView addSubview:self.aliBtn];
    
    
    [MJBtnManager setButton:self.commitBtn
                       text:@"提交"
                  textColor:[UIColor whiteColor]
                       font:[UIFont systemFontOfSize:em*48]
                      image:[UIImage imageWithColor:[UIColor colorWithHex:primaryColor]]
                     radius:4];
    self.commitBtn.alpha = 0.6;
    self.commitBtn.userInteractionEnabled = NO;
    [self.up_scrollView addSubview:self.commitBtn];
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

- (UIView *)moneyView{
    if (_moneyView==nil) {
        _moneyView = [[UIView alloc] initWithFrame:CGRectMake(em*35, em*135, SCREEN_WIDTH-em*70, em*150)];
        _moneyView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255. blue:247/255. alpha:1];
        _moneyView.layer.cornerRadius = 2;
        _moneyView.layer.masksToBounds= YES;
    }
    return _moneyView;
}

- (UITextField *)moneyTextField{
    if (_moneyTextField==nil) {
        _moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(em*45, em*15, SCREEN_WIDTH-em*70-em*250, em*120)];
    }
    return _moneyTextField;
}

- (UILabel *)moneyTipLabel{
    if (_moneyTipLabel==nil) {
        _moneyTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*70-em*45-em*160, em*15, em*160, em*120)];
    }
    return _moneyTipLabel;
}


- (UIView *)line_view{
    if (_line_view==nil) {
        _line_view = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.moneyView.frame)+em*270, SCREEN_WIDTH-em*70, 1)];
        _line_view.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _line_view.alpha = 0.6;
    }
    return _line_view;
}

- (UIButton *)commitBtn{
    if (_commitBtn==nil) {
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.line_view.frame)+em*410, SCREEN_WIDTH-em*70, em*132)];
    }
    return _commitBtn;
}

//wechat
- (UIImageView *)wechatImageView{
    if (_wechatImageView==nil) {
        _wechatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*410, CGRectGetMaxY(self.moneyView.frame)+em*107, em*66, em*66)];
        _wechatImageView.image = [UIImage imageNamed:@"wechat_logo"];
    }
    return _wechatImageView;
}

- (UILabel *)wechatLabel{
    if (_wechatLabel==nil) {
        _wechatLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.wechatImageView.frame)+em*20, CGRectGetMaxY(self.moneyView.frame)+em*107, em*200, em*66)];
    }
    return _wechatLabel;
}

- (UIButton *)wechatBtn{
    if (_wechatBtn==nil) {
        _wechatBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.wechatLabel.frame)+em*35, CGRectGetMaxY(self.moneyView.frame)+em*107-em*12, em*90, em*90)];
    }
    return _wechatBtn;
}

//alipay
- (UIImageView *)aliImageView{
    if (_aliImageView==nil) {
        _aliImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*410, CGRectGetMaxY(self.line_view.frame)+em*102, em*258, em*90)];
        _aliImageView.image = [UIImage imageNamed:@"alipay_logo"];
    }
    return _aliImageView;
}

- (UIButton *)aliBtn{
    if (_aliBtn==nil) {
        _aliBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.wechatLabel.frame)+em*35, CGRectGetMaxY(self.line_view.frame)+em*102, em*90, em*90)];
    }
    return _aliBtn;
}
@end
