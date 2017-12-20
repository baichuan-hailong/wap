//
//  MJPayViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/25.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJPayViewController.h"
#import "MJPayView.h"


@interface MJPayViewController ()<UITextFieldDelegate>
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
    
    self.payView.moneyTextField.delegate = self;
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
        if ([self.payView.moneyTextField.text floatValue]>9999999){
            self.payView.moneyTextField.text = @"9999999";
        }
    }else{
        self.payView.commitBtn.alpha = 0.6;
        self.payView.commitBtn.userInteractionEnabled = NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //NSLog(@"%@",string);
    if ([self.payView.moneyTextField.text floatValue]<0.01&&self.payView.moneyTextField.text.length>3&&string.length==1) {
        self.payView.moneyTextField.text = @"0.01";
        return NO;
    }
    
    if([self.payView.moneyTextField.text rangeOfString:@"."].location !=NSNotFound&&string.length==1){
        //NSLog(@"yes");
        NSArray *array = [self.payView.moneyTextField.text componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
        NSString *floatStr = [NSString stringWithFormat:@"%@",array[1]];
        //NSLog(@"%@",floatStr);
        if (floatStr.length>=2) {
            return NO;
        }
    }
    
    return YES;
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
    NSString *money = [NSString stringWithFormat:@"%.2f",[self.payView.moneyTextField.text floatValue]];
    //NSLog(@"%f",[money floatValue]);
    money = [money stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (![money isNull]&&[money integerValue]>=1&&[money integerValue]<=999999900) {
        [self showProgress];
        NSDictionary *data;
        //NSLog(@"%@",money);
        if (isWechatPayBool) {
            data   = @{@"channelId":@"WX_APP",@"amount":[NSString stringWithFormat:@"%ld",(long)[money integerValue]]};
        }else{
            data   = @{@"channelId":@"ALIPAY_MOBILE",@"amount":[NSString stringWithFormat:@"%ld",(long)[money integerValue]]};
        }
        NSDictionary *pradic = [data signWithSecurityKey];
        NSString *testurl    = [NSString stringWithFormat:@"%@/accountbill/getRechargeOrder",API];
        //NSLog(@"%@",data);
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
