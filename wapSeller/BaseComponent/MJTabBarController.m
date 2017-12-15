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
    
    //self.tabBar.clipsToBounds = YES;
    if (!iPhoneX) {
        [self changeLineOfTabbarColor];
    }
    
    
    
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
    //[childNC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
    [childNC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithHex:primaryColor]} forState:UIControlStateSelected];
    [childNC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    
    
    [self addChildViewController:childNC];
}


- (void)changeLineOfTabbarColor {
    CGRect rect = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 0.65);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:153/255.0 green:153/255.0 blue:169/255.0 alpha:0.3].CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:image];
    [self.tabBar setBackgroundImage:[UIImage new]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
