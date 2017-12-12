//
//  MJTabBarController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJTabBarController.h"
#import "MJMyActivityViewController.h"
#import "JMMyselfViewController.h"
#import "MJTradingViewController.h"

@interface MJTabBarController ()

@end

@implementation MJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    MJMyActivityViewController *activity = [[MJMyActivityViewController alloc] init];
    activity.title = @"1";
    [self setChildVC:activity title:@"我的活动" image:@"activity" selectedImage:@"activity_selected"];
    
    MJTradingViewController *myself = [[MJTradingViewController alloc] init];
    myself.title = @"交易确认";
    [self setChildVC:myself title:@"交易确认" image:@"trading" selectedImage:@"trading_selected"];
    
    JMMyselfViewController *trading = [[JMMyselfViewController alloc] init];
    trading.title = @"我的";
    [self setChildVC:trading title:@"我的" image:@"myself" selectedImage:@"myself_selected"];
    
    //setting
    [self setSelectedIndex:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishlLogin) name:@"finishlLogin" object:nil];
}

- (void)finishlLogin{
    //setting
    [self setSelectedIndex:1];
}


- (void)setChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    UINavigationController *childNC   = [[UINavigationController alloc] initWithRootViewController:childVC];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childNC.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    childNC.tabBarItem.title = title;
    childNC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childNC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childNC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithHex:primaryColor]} forState:UIControlStateSelected];
    
    
    
    [self addChildViewController:childNC];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
