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
    self.title = @"升级为商家";
    [self hideBack];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upCommitSuccessful) name:@"upCommitSuccessful" object:nil];

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
