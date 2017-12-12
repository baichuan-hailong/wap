//
//  MJPayViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/25.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJPayViewController.h"
#import "MJPayView.h"


@interface MJPayViewController ()
{
    BOOL isWechatPayBool;
}
@property(nonatomic,strong)MJPayView     *payView;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation MJPayViewController

- (void)loadView{
    self.payView = [[MJPayView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view = self.payView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    
    isWechatPayBool = YES;
    
    [self addAction];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fnishPay) name:@"fnishPay" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPaySuccessful) name:@"aliPaySuccessful" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPayFailing) name:@"aliPayFailing" object:nil];
}


- (void)addAction{
    [self.payView.wechatBtn addTarget:self action:@selector(wechatBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.payView.aliBtn addTarget:self action:@selector(aliBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.payView.commitBtn addTarget:self action:@selector(commitBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.payView.moneyTextField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction:)];
    [self.payView addGestureRecognizer:tapGR];
}

- (void)tapGRAction:(UITapGestureRecognizer *)sender{
    [self.view endEditing:YES];
}

- (void)fnishPay{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - DELEGATE
-(void)textField1TextChange:(UITextField *)textField{
    if (self.payView.moneyTextField.text.length>0) {
        self.payView.commitBtn.alpha = 1;
        self.payView.commitBtn.userInteractionEnabled = YES;
    }else{
        self.payView.commitBtn.alpha = 0.6;
        self.payView.commitBtn.userInteractionEnabled = NO;
    }
}



#pragma mark - pay successful
- (void)aliPaySuccessful{
    MJPaySuccessfulViewController *successfulVC= [[MJPaySuccessfulViewController alloc] init];
    successfulVC.moneyStr = [NSString stringWithFormat:@"%@",self.payView.moneyTextField.text];
    UINavigationController *succNV = [[UINavigationController alloc] initWithRootViewController:successfulVC];
    [self presentViewController:succNV animated:NO completion:nil];
}

#pragma mark - pay failing
- (void)aliPayFailing{
    MJPayFailedViewController *failedVC= [[MJPayFailedViewController alloc] init];
    UINavigationController *failedNV = [[UINavigationController alloc] initWithRootViewController:failedVC];
    [self presentViewController:failedNV animated:NO completion:nil];
}

#pragma mark - wechat
- (void)wechatBtnDidClicked:(UIButton *)sender{
    [self.view endEditing:YES];
    isWechatPayBool = YES;
    [self.payView.wechatBtn setImage:[UIImage imageNamed:@"selecte_ture"] forState:UIControlStateNormal];
    [self.payView.aliBtn setImage:[UIImage imageNamed:@"selecte_false"] forState:UIControlStateNormal];
}

#pragma mark - ali
- (void)aliBtnDidClicked:(UIButton *)sender{
    [self.view endEditing:YES];
    isWechatPayBool = NO;
    [self.payView.wechatBtn setImage:[UIImage imageNamed:@"selecte_false"] forState:UIControlStateNormal];
    [self.payView.aliBtn setImage:[UIImage imageNamed:@"selecte_ture"] forState:UIControlStateNormal];
}

#pragma mark - 充值
- (void)commitBtnDidClicked:(UIButton *)sender{
    [self.view endEditing:YES];
    
    NSString *money = [NSString stringWithFormat:@"%@",self.payView.moneyTextField.text];
    if (![money isNull]&&[money floatValue]*100>=1) {
        [self showProgress];
        NSDictionary *data;
        if (isWechatPayBool) {
            data   = @{@"channelId":@"WX_APP",@"amount":[NSString stringWithFormat:@"%.f",[money floatValue]*100]};
        }else{
            data   = @{@"channelId":@"ALIPAY_MOBILE",@"amount":[NSString stringWithFormat:@"%.f",[money floatValue]*100]};
        }
        NSDictionary *pradic = [data signWithSecurityKey];
        NSString *testurl    = [NSString stringWithFormat:@"%@/accountbill/getRechargeOrder",API];
        
        [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"pay --- %@",object);
            NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
            if ([status isEqualToString:@"1000"]) {
                //NSLog(@"pay --- %@",object[@"data"][@"payParams"]);
                NSString *payStr = [NSString stringWithFormat:@"%@",object[@"data"]];
                NSDictionary *payDic = [payStr dictionaryWithJsonString:payStr];
                NSLog(@"%@",payDic);
                if (isWechatPayBool) {
                    [[WechatManager sharedManager] wechatPay:payDic];
                }else{
                    [[AliPayManager defaultAli] rechargeOrder:payDic[@"payParams"]];
                }
            }else{
                [ProgressHUD_Manager showTo:self.view tipText:object[@"message"]];
            }
            [self.hud hideAnimated:YES];
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.hud hideAnimated:YES];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        [ProgressHUD_Manager showTo:self.view tipText:@"请输入大于1分的金额"];
    }
}


- (void)showProgress{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    self.hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    self.hud.bezelView.backgroundColor = [UIColor clearColor];
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.margin         = 0.f;
    [self.view addSubview:self.hud];
    [self.hud showAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
