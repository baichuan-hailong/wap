//
//  MJUpWaitingViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/5.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJUpWaitingViewController.h"
#import "MJUpWaitingView.h"
#import "MJUpgradeMerchantViewController.h"

@interface MJUpWaitingViewController ()
@property(nonatomic,strong)MJUpWaitingView *upWaitingView;
@end

@implementation MJUpWaitingViewController

- (void)loadView{
    self.upWaitingView = [[MJUpWaitingView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view = self.upWaitingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"填写卖家信息";
    [self hideBack];
    [self rightButton];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(upCommitSuccessful)
                                                 name:@"upCommitSuccessful"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(comeBack)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    //等待审核
    //审核失败
    [self.upWaitingView upView:_isSuccessful];
    [self.upWaitingView.resetUpBtn addTarget:self action:@selector(resetUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    [self updateInfo];
}


- (void)rightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"退出" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:em*48];
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button addTarget:self action:@selector(rightOutAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame           = CGRectMake(0, 0, 44, 64);
    
    //button.imageEdgeInsets = UIEdgeInsetsMake(0,-20, 0, 10);
    //button.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)rightOutAction{
    
    [self evokeOutAc];
    
    MJLoginViewController *loginVC = [[MJLoginViewController alloc] init];
    UINavigationController *logNC  = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"commitSuccessful" object:nil];
    [self dismissViewControllerAnimated:NO completion:^{
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:logNC animated:NO completion:nil];
    }];
}


- (void)evokeOutAc{
    //User INFO
    //是否登录 //SecurityKey //用户id //账户 //邀请码
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_LOGIN];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:SecurityKey];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:UserID];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:LoginTel];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:PromoterId];
    
    
    //up提交与否 //up审核结果 //up是否有提交
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:IS_Seller];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:Seller_AuditResult];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_HaveUPCommit];
    
    
    //商家信息
    //店铺名
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"clientName_up"];
    //市场
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"marketName_up"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"marketId_up"];
    //摊位号
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"sellerStallInfo_up"];
    //联系人
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"linkman_up"];
    //联系电话
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"telephone_up"];
    //邀请码
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"inviteCoder_up"];
    
}






- (void)comeBack{
    NSLog(@"come back");
    [self updateInfo];
}

- (void)updateInfo{
    NSString *user_id    =  [[NSUserDefaults standardUserDefaults] stringForKey:UserID];
    if (![user_id isNull]) {
        NSDictionary *data   = @{@"oid":user_id};
        NSDictionary *pradic = [data signWithSecurityKey];
        NSString *testurl    = [NSString stringWithFormat:@"%@/client/getById",API];
        
        [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"client user info --- %@",object);
            NSString *s = [NSString stringWithFormat:@"%@",object[@"s"]];
            if ([s isEqualToString:@"1"]) {
                //0-1-2 升级状态 未-成功-失败
                NSString *sellerAuditResult = [NSString stringWithFormat:@"%@",object[@"data"][@"sellerAuditResult"]];
                [[NSUserDefaults standardUserDefaults] setObject:sellerAuditResult forKey:Seller_AuditResult];
                if ([sellerAuditResult isEqualToString:@"0"]) {
                    //0 未升级 等待状态
                }else if ([sellerAuditResult isEqualToString:@"1"]){
                    //1 升级成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"commitSuccessful" object:nil];
                    [self dismissViewControllerAnimated:NO completion:nil];
                }else{
                    //2 升级失败
                    //审核失败
                    NSString *remark = [NSString stringWithFormat:@"%@",object[@"data"][@"remark"]];
                    if (![remark isNull]) {
                       self.upWaitingView.reasonLabel.text = [NSString stringWithFormat:@"原因：%@",object[@"data"][@"remark"]];
                    }else{
                        self.upWaitingView.reasonLabel.text = @"";
                    }
                    
                    [self.upWaitingView upView:NO];
                }
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"updateuserinfo" object:object[@"data"]];
            }
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"updateuserinfo" object:nil];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }
}

- (void)upCommitSuccessful{
    //等待审核
    [self.upWaitingView upView:YES];
}


- (void)resetUpBtnClick:(UIButton *)sender{
    NSLog(@"click");
    MJUpgradeMerchantViewController *upgradeVC = [[MJUpgradeMerchantViewController alloc] init];
    upgradeVC.isUpWaiting = YES;//入口
    [self.navigationController pushViewController:upgradeVC animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBackAction{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
