//
//  JMMyselfViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "JMMyselfViewController.h"
#import "MJMyselfView.h"
#import "MJMyselfTableViewCell.h"
#import "MJMyselfHeaderView.h"
#import "MJMyselfFooterView.h"

#import "MJPayViewController.h"
#import "MJBillViewController.h"
#import "MJMerchantsInfoViewController.h"

@interface JMMyselfViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,MJOutAlertViewDelegate>{
    NSArray      *myArray;
    NSDictionary *userInfoDic_my;
}
@property(nonatomic,strong)MJMyselfView       *myselfView;
@property(nonatomic,strong)MJMyselfHeaderView *myselfHeaderView;
@property(nonatomic,strong)MJMyselfFooterView *myselfFooterView;
@end

@implementation JMMyselfViewController
-(void)loadView{
    
    self.myselfView = [[MJMyselfView alloc] initWithFrame:SCREEN_BOUNDS];
    self.myselfView.myselfTableView.delegate   = self;
    self.myselfView.myselfTableView.dataSource = self;
    self.view = self.myselfView;
    //header
    self.myselfHeaderView = [[MJMyselfHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, em*908)];
    self.myselfView.myselfTableView.tableHeaderView = self.myselfHeaderView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = YES;
    
    self.navigationController.delegate = self;
    [self hideBack];
    
    myArray = @[@{@"image":@"account_info",@"text":@"账单"},
                @{@"image":@"seller_information",@"text":@"商户信息"},
                @{@"image":@"loginout_image",@"text":@"退出"}];
    
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(updateUserInfoNotificationAction:) name:@"updateuserinfo" object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(aliPaySuccessful) name:@"aliPaySuccessful" object:nil];

}

- (void)viewWillAppear:(BOOL)animated{
    [MJUpdateUserInfo updateInfo];
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

- (void)addAction{
    [self.myselfHeaderView.rechargeBtn addTarget:self
                                          action:@selector(rechargeBtnDidClicked:)
                                forControlEvents:UIControlEventTouchUpInside];
    
    self.myselfView.outAlertView.delegate = self;
    
}


#pragma mark - pay successful
- (void)aliPaySuccessful{
    [MJUpdateUserInfo updateInfo];
}


#pragma mark - 用户信息
- (void)updateUserInfoNotificationAction:(NSNotification *)notification{
    NSDictionary *userInfoDic = [notification object];
    NSLog(@"notification --- %@",userInfoDic);
    if (userInfoDic==nil) {
        /**UserInfo Read**/
        //账户余额
        //cashMoney
        userInfoDic = @{@"cashMoney":[[NSUserDefaults standardUserDefaults] stringForKey:@"cashMoney"],
                        @"creditMoneyCanUse":[[NSUserDefaults standardUserDefaults] stringForKey:@"creditMoneyCanUse"],
                        @"clientName":[[NSUserDefaults standardUserDefaults] stringForKey:@"clientName"],
                        @"marketName":[[NSUserDefaults standardUserDefaults] stringForKey:@"marketName"],
                        @"sellerStallInfo":[[NSUserDefaults standardUserDefaults] stringForKey:@"sellerStallInfo"],
                        @"linkman":[[NSUserDefaults standardUserDefaults] stringForKey:@"linkman"],
                        @"telephone":[[NSUserDefaults standardUserDefaults] stringForKey:@"telephone"]};
        //NSLog(@"reading userInfoDic ... %@",userInfoDic);
        userInfoDic_my = userInfoDic;
        [self.myselfHeaderView setMoney:userInfoDic];
        
    }else{
        /**UserInfo Write**/
        //账户余额
        //cashMoney
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",userInfoDic[@"cashMoney"]] forKey:@"cashMoney"];
        //信用余额
        //creditMoneyCanUse
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",userInfoDic[@"creditMoneyCanUse"]] forKey:@"creditMoneyCanUse"];
        //店铺名
        //clientName
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",userInfoDic[@"clientName"]] forKey:@"clientName"];
        //所在市场
        //marketName
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",userInfoDic[@"marketName"]] forKey:@"marketName"];
        //摊位号
        //sellerStallInfo
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",userInfoDic[@"sellerStallInfo"]] forKey:@"sellerStallInfo"];
        //联系人
        //linkman
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",userInfoDic[@"linkman"]] forKey:@"linkman"];
        //联系电话
        //telephone
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",userInfoDic[@"telephone"]] forKey:@"telephone"];
        userInfoDic_my = userInfoDic;
        [self.myselfHeaderView setMoney:userInfoDic];
    }
}

#pragma mark - 充值
- (void)rechargeBtnDidClicked:(UIButton *)sender{
    MJPayViewController *payVC = [[MJPayViewController alloc] init];
    [payVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:payVC animated:YES];
}

/**Nav Deledate**/
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //NSLog(@"myself nava delegate");
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    if ([viewController isKindOfClass:[MJPayFailedViewController class]]||[viewController isKindOfClass:[MJPaySuccessfulViewController class]]){
        //[self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID     = @"tipCell";
    MJMyselfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MJMyselfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    switch (indexPath.section) {
        case 0:
            cell.line_view.alpha = 1;
            break;
        case 1:
            cell.line_view.alpha = 0;
            break;
        case 2:
            cell.line_view.alpha = 1;
            break;
        default:
            cell.line_view.alpha = 1;
            break;
    }
    [cell setMysel:myArray[indexPath.section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return em*180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return em*0.01;
}
//footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return em*0.01;
            break;
        case 1:
            return em*32;
            break;
        case 2:
            return em*0.01;
            break;
        default:
            return em*0.01;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:248/255.0 alpha:1];
    return footer;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIViewController *viewControl;
    MJBillViewController *billVC;
    MJMerchantsInfoViewController *merchVC;
    switch (indexPath.section) {
        case 0:
            //NSLog(@"0");
            billVC = [[MJBillViewController alloc] init];
            viewControl = billVC;
            break;
        case 1:
            //NSLog(@"1");
            merchVC = [[MJMerchantsInfoViewController alloc] init];
            merchVC.userInfoDic = userInfoDic_my;
            viewControl = merchVC;
            break;
        case 2:
            //NSLog(@"2");
            [self.myselfView.outAlertView outAlertShow];
            break;
        default:
            break;
    }
    [viewControl setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewControl animated:YES];
}

#pragma mark - OUT DELEGATE
- (void)outClick:(NSInteger)index{
    switch (index) {
        case 0:
            [self.myselfView.outAlertView outAlertHide];
            break;
        case 1:
            [self.myselfView.outAlertView outAlertHide];
            [self evokeOutAc];
            break;
        default:
            [self.myselfView.outAlertView outAlertHide];
            break;
    }
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
    
    
    MJLoginViewController *loginVC = [[MJLoginViewController alloc] init];
    UINavigationController *logNC  = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:logNC animated:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - 退出
 - (void)outAction{
 UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
 message:@"确认要退出登录吗？"
 preferredStyle:UIAlertControllerStyleAlert];
 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"退出"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction *action) {
 NSLog(@"sure");
 [self evokeOutAc];
 }];
 
 UIAlertAction *cancle  = [UIAlertAction actionWithTitle:@"取消"
 style:UIAlertActionStyleCancel
 handler:^(UIAlertAction *action) {
 NSLog(@"cancle");
 }];
 
 [cancle setValue:[UIColor blackColor] forKey:@"titleTextColor"];
 [okAction setValue:[UIColor colorWithHex:primaryColor] forKey:@"titleTextColor"];
 [alertDialog addAction:cancle];
 [alertDialog addAction:okAction];
 [self presentViewController:alertDialog animated:YES completion:nil];
 }
 */

@end
