//
//  MJMerchantsInfoViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/25.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMerchantsInfoViewController.h"
#import "MJMerchantsInfoDetailView.h"

@interface MJMerchantsInfoViewController ()
@property(nonatomic,strong)MJMerchantsInfoDetailView *merchantDetailView;
@end

@implementation MJMerchantsInfoViewController

- (void)loadView{
    self.merchantDetailView = [[MJMerchantsInfoDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view = self.merchantDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商户信息";
    
    NSLog(@"%@",self.userInfoDic);
    
    [self.merchantDetailView setDetail:self.userInfoDic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
