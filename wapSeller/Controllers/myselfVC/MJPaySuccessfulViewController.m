//
//  MJPaySuccessfulViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/5.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJPaySuccessfulViewController.h"

@interface MJPaySuccessfulViewController ()
@property(nonatomic,strong)UIButton    *sureBtn;

@property(nonatomic,strong)UIImageView *stateImageView;
@property(nonatomic,strong)UILabel     *stateLabel;
@property(nonatomic,strong)UILabel     *moneyLabel;

@property(nonatomic, strong)UIScrollView *up_scrollView;
@end

@implementation MJPaySuccessfulViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"充值";
    
    [self.view addSubview:self.up_scrollView];
    
    [MJBtnManager setButton:self.sureBtn
                       text:@"确定"
                  textColor:[UIColor whiteColor]
                       font:[UIFont systemFontOfSize:em*48]
                      image:[UIImage imageWithColor:[UIColor colorWithHex:primaryColor]]
                     radius:4];
    [self.up_scrollView addSubview:self.sureBtn];
    
    //pay_successful_image
    [self.up_scrollView addSubview:self.stateImageView];
    
    [MJLabelManager setLabel:self.stateLabel
                        text:@"充值成功"
                   textColor:[UIColor colorWithHex:@"404047"]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.stateLabel];
    
    [MJLabelManager setLabel:self.moneyLabel
                        text:[NSString stringWithFormat:@"充值金额：%.2f元",[self.moneyStr floatValue]]
                   textColor:[UIColor colorWithHex:@"f91e1e"]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.moneyLabel];
    
    
    
    
    [self.sureBtn addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)goBackAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fnishPay" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



//lazy
- (UIButton *)sureBtn{
    if (_sureBtn==nil) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(em*35, em*796, SCREEN_WIDTH-em*70, em*131)];
    }
    return _sureBtn;
}


- (UIImageView *)stateImageView{
    if (_stateImageView==nil) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*222)/2, em*200, em*222, em*194)];
        _stateImageView.image = [UIImage imageNamed:@"pay_successful_image"];
    }
    return _stateImageView;
}

- (UILabel *)stateLabel{
    if (_stateLabel==nil) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stateImageView.frame)+em*54, SCREEN_WIDTH, em*45)];
    }
    return _stateLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stateLabel.frame)+em*56, SCREEN_WIDTH, em*45)];
    }
    return _moneyLabel;
}


@end
