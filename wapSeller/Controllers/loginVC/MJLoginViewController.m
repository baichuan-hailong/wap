//
//  MJLoginViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJLoginViewController.h"
#import "MJLoginView.h"

#import "MJUpgradeMerchantViewController.h"
#import "MJUpWaitingViewController.h"

@interface MJLoginViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)MJLoginView *loginView;
@property(nonatomic,strong)MBProgressHUD *hud;
//NSTimer
@property(nonatomic,strong)NSTimer *valiCodeTimer;
@property(nonatomic)NSInteger       startTime;
@end

@implementation MJLoginViewController

-(void)loadView{
    
    self.loginView = [[MJLoginView alloc] initWithFrame:SCREEN_BOUNDS];
    self.loginView.up_scrollView.delegate = self;
    self.view = self.loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = YES;
    self.navigationController.delegate = self;
    
    self.title = @"登录";
    [self hideBack];
    [self addActon];
}

/**冲突**/
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)addActon{
    //登陆
    [self.loginView.loginBtn addTarget:self action:@selector(loginBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    //验证码
    [self.loginView.coderBtn addTarget:self action:@selector(coderBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    //tap
    UITapGestureRecognizer *tapQulityGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction:)];
    [self.loginView addGestureRecognizer:tapQulityGR];
    
    self.loginView.telTextField.delegate = self;
    self.loginView.coderTextField.delegate=self;
}

- (void)tapGRAction:(UITapGestureRecognizer *)sender{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.38 animations:^{
        self.loginView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    } completion:nil];
}

#pragma mark - TF Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //ios11+
    [UIView animateWithDuration:0.38 animations:^{
        self.loginView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    }];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"should end");
    return YES;
}


/**Nav Deledate**/
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"login nava delegate");
}


#pragma mark - Login
- (void)loginBtnDidClick:(UIButton *)sender{
    //NSLog(@"login");
    [self tapGRAction:nil];
    
    if ([MJRegularManager checkMobile:self.loginView.telTextField.text]&&self.loginView.coderTextField.text.length>0) {
        [self showProgress];
        
        NSString *jpPregistation_id = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:JPregistrationId]];
        NSDictionary *data;
        if (![jpPregistation_id isNull]) {
            data = @{@"mobile":self.loginView.telTextField.text,@"verifycode":self.loginView.coderTextField.text,@"registrationId":jpPregistation_id};
        }else{
            data = @{@"mobile":self.loginView.telTextField.text,@"verifycode":self.loginView.coderTextField.text};
        }
        NSString *testurl  = [NSString stringWithFormat:@"%@/client/doLogin",API];
        NSDictionary *pradic = [data prefectWithDic];
        NSLog(@"%@",pradic);
        [[MJNetManger shareManager] requestWithType:HttpRequestTypePost withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
            [self.hud hideAnimated:YES];
            NSLog(@"登陆 --- %@",object);
            //NSLog(@"%@",object[@"message"]);
            NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
            if ([status isEqualToString:@"1000"]) {
                NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:object[@"data"]];
                if (dataDic!=nil) {
                    //存储
                    [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"securityKey"] forKey:SecurityKey];
                    [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"oid"] forKey:UserID];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",self.loginView.telTextField.text] forKey:LoginTel];
                    [[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"promoterId"] forKey:PromoterId];
                    
                    NSString *isSeller = [NSString stringWithFormat:@"%@",object[@"data"][@"isSeller"]];
                    NSString *sellerAuditResult = [NSString stringWithFormat:@"%@",object[@"data"][@"sellerAuditResult"]];
                    [[NSUserDefaults standardUserDefaults] setObject:sellerAuditResult forKey:Seller_AuditResult];
                    [[NSUserDefaults standardUserDefaults] setObject:isSeller forKey:IS_Seller];
                    
                    //isSeller = @"0";
                    //sellerAuditResult = @"0";
                    //提交资料
                    if ([isSeller isEqualToString:@"1"]) {
                        if ([sellerAuditResult isEqualToString:@"0"]) {
                            //0 未升级（已提交资料）--- 审核中ji
                            //已经提交审核
                            if ([[NSUserDefaults standardUserDefaults] boolForKey:IS_HaveUPCommit]) {
                                MJUpWaitingViewController *upWairing = [[MJUpWaitingViewController alloc] init];
                                upWairing.isSuccessful = YES;
                                UINavigationController *upWaitingNV = [[UINavigationController alloc] initWithRootViewController:upWairing];
                                [self presentViewController:upWaitingNV animated:NO completion:nil];
                            }else{
                                MJUpgradeMerchantViewController *upgradeMerchantVC = [[MJUpgradeMerchantViewController alloc] init];
                                NSString *oid = [NSString stringWithFormat:@"%@",object[@"data"][@"oid"]];
                                NSString *promoterId = [NSString stringWithFormat:@"%@",object[@"data"][@"promoterId"]];
                                upgradeMerchantVC.login_tel = self.loginView.telTextField.text;
                                upgradeMerchantVC.oid = oid;
                                upgradeMerchantVC.promoterId = promoterId;
                                [self.navigationController pushViewController:upgradeMerchantVC animated:YES];
                            }
                        }else if ([sellerAuditResult isEqualToString:@"1"]){
                            //1 升级成功
                            [MJUpdateUserInfo updateInfo];
                            //本地存储
                            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGIN];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"finishlLogin" object:nil];
                            //商家
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }else{
                            //2 升级失败
                            MJUpWaitingViewController *upWairing = [[MJUpWaitingViewController alloc] init];
                            upWairing.isSuccessful = NO;
                            UINavigationController *upWaitingNV = [[UINavigationController alloc] initWithRootViewController:upWairing];
                            [self presentViewController:upWaitingNV animated:NO completion:nil];
                        }
                        //未提交资料
                    }else{
                        if ([sellerAuditResult isEqualToString:@"0"]) {
                            //0 未升级（没提交资料）
                            MJUpgradeMerchantViewController *upgradeMerchantVC = [[MJUpgradeMerchantViewController alloc] init];
                            NSString *oid = [NSString stringWithFormat:@"%@",object[@"data"][@"oid"]];
                            NSString *promoterId = [NSString stringWithFormat:@"%@",object[@"data"][@"promoterId"]];
                            upgradeMerchantVC.login_tel = self.loginView.telTextField.text;
                            upgradeMerchantVC.oid = oid;
                            upgradeMerchantVC.promoterId = promoterId;
                            [self.navigationController pushViewController:upgradeMerchantVC animated:YES];
                        }else if ([sellerAuditResult isEqualToString:@"1"]){
                            //1 升级成功
                            [MJUpdateUserInfo updateInfo];
                            //本地存储
                            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGIN];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"finishlLogin" object:nil];
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }else{
                            //2 升级失败
                            MJUpWaitingViewController *upWairing = [[MJUpWaitingViewController alloc] init];
                            upWairing.isSuccessful = NO;
                            UINavigationController *upWaitingNV = [[UINavigationController alloc] initWithRootViewController:upWairing];
                            [self presentViewController:upWaitingNV animated:NO completion:nil];
                        }
                    }
                }else{
                    [ProgressHUD_Manager showTo:self.view tipText:@"登陆失败"];
                }
                
            }else{
                [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"message"]]];
            }
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.hud hideAnimated:YES];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else if ([MJRegularManager checkMobile:self.loginView.telTextField.text]){
        [ProgressHUD_Manager showTo:self.view tipText:@"请输入验证码"];
    }else{
        [ProgressHUD_Manager showTo:self.view tipText:@"请输入正确的手机号"];
    }
}


#pragma mark - Coder
- (void)coderBtnDidClick:(UIButton *)sender{
    NSLog(@"coder");
    [self requestCoder];
}

- (void)requestCoder{
    if ([MJRegularManager checkMobile:self.loginView.telTextField.text]) {
        [self showProgress];
        NSDictionary *data = @{@"mobile":self.loginView.telTextField.text};
        NSDictionary *pradic = [data signWithSecurityKey];
        //NSLog(@"%@",pradic);
        NSString *testurl  = [NSString stringWithFormat:@"%@/client/getsmsverifycode",API];
        [[MJNetManger shareManager] requestWithType:HttpRequestTypePost withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
            [self.hud hideAnimated:YES];
            NSLog(@"%@",object);
            NSString *s = [NSString stringWithFormat:@"%@",object[@"s"]];
            if ([s isEqualToString:@"1"]) {
                [self startCountdown];
            }else{
                [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"message"]]];
                [self stopCount];
            }
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.hud hideAnimated:YES];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        [ProgressHUD_Manager showTo:self.view tipText:@"请输入正确的手机号"];
    }
}



#pragma mark - NSTimer
-(void)startCountdown{
    self.valiCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeGo) userInfo:nil repeats:YES];
    _startTime = 60;
    [self.loginView.coderBtn setTitle:[NSString stringWithFormat:@"重发(%lds)",(long)_startTime] forState:UIControlStateNormal];
}


-(void)timeGo{
    _startTime--;
    self.loginView.coderBtn.userInteractionEnabled = NO;
    [self.loginView.coderBtn setTitle:[NSString stringWithFormat:@"重发(%lds)",(long)_startTime] forState:UIControlStateNormal];
    if (_startTime==0) {
        self.loginView.coderBtn.userInteractionEnabled = YES;
        [self.loginView.coderBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self.loginView.coderBtn setTitleColor:[UIColor colorWithRed:98/255.0 green:98/255.0 blue:109/255.0 alpha:1] forState:UIControlStateNormal];
        [self.loginView.coderBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [_valiCodeTimer invalidate];
        _valiCodeTimer = nil;
    }
}

- (void)stopCount{
    self.loginView.coderBtn.userInteractionEnabled = YES;
    [self.loginView.coderBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    [_valiCodeTimer invalidate];
    _valiCodeTimer  = nil;
}


#pragma mark - SCROLL DELEGATE
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)showProgress{
    self.hud = [[MBProgressHUD alloc] initWithView:self.loginView];
    self.hud.bezelView.color           = [UIColor whiteColor];
    self.hud.margin         = 0.f;
    [self.loginView addSubview:self.hud];
    [self.hud showAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
