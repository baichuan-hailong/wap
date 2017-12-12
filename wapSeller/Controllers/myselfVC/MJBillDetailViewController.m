//
//  MJBillDetailViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJBillDetailViewController.h"
#import "MJBillDetailView.h"

@interface MJBillDetailViewController ()
@property(nonatomic,strong)MJBillDetailView *detailView;
@end

@implementation MJBillDetailViewController

- (void)loadView{
    self.detailView = [[MJBillDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view = self.detailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单明细";
    
    [self.detailView setDetail:self.billDic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
