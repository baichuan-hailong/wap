//
//  MJBillViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/25.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJBillViewController.h"
#import "MJBillView.h"
#import "MJBillTableViewCell.h"


#import "MJBillDetailViewController.h"

@interface MJBillViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentPage;
    NSInteger totalCount;
    NSMutableArray *billArray;
}
@property(nonatomic,strong)MJBillView *billView;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation MJBillViewController

-(void)loadView{
    self.billView = [[MJBillView alloc] initWithFrame:SCREEN_BOUNDS];
    self.billView.billTableView.delegate  = self;
    self.billView.billTableView.dataSource= self;
    self.view     = self.billView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账单";
    [self showProgress];
    [self loadDataSource];
    [MJMJRefreshManage headerWithRefreshingTarget:self tableView:self.billView.billTableView sel:@selector(loadDataSource)];
    [MJMJRefreshManage footerWithRefreshingTarget:self tableView:self.billView.billTableView sel:@selector(loadMoreDataSource)];
}

#pragma mark - MJ LOAD SOURCE
- (void)loadDataSource{
    currentPage = 1;
    NSString *user_id    =  [[NSUserDefaults standardUserDefaults] stringForKey:UserID];
    NSDictionary *data   = @{@"clientId":user_id,@"pageNum":@"1",@"numPerPage":@"15",@"state":@"成功"};
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/accountbill/listPage",API];
    NSLog(@"bill --- %@",pradic);
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"bill --- %@",object);
        [self.hud hideAnimated:YES];
        self.billView.billTableView.mj_footer.state = MJRefreshStateIdle;
        NSString *s = [NSString stringWithFormat:@"%@",object[@"s"]];
        if ([s isEqualToString:@"1"]) {
            billArray = [NSMutableArray arrayWithArray:object[@"data"][@"recordList"]];
            currentPage = 2;
            totalCount  = [[NSString stringWithFormat:@"%@",object[@"data"][@"totalCount"]] integerValue];
            [self.billView.billTableView reloadData];
        }else{
            [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
        }
        [self.billView.billTableView.mj_header endRefreshing];
        // 隐藏UITableViewStyleGrouped上边多余的间隔
        self.billView.billTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //empty
        [MJEmptyManager check:self.billView.billTableView dataArray:billArray emptyView:self.emptyView];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.hud hideAnimated:YES];
        [self.billView.billTableView.mj_header endRefreshing];
        // 隐藏UITableViewStyleGrouped上边多余的间隔
        self.billView.billTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //empty
        [MJEmptyManager check:self.billView.billTableView dataArray:billArray emptyView:self.emptyView];
        
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}


- (void)loadMoreDataSource{
    //NSLog(@"load more");
    if (billArray.count<totalCount) {
        NSString *user_id    =  [[NSUserDefaults standardUserDefaults] stringForKey:UserID];
        NSDictionary *data   = @{@"clientId":user_id,@"pageNum":[NSString stringWithFormat:@"%ld",currentPage],@"numPerPage":@"15",@"state":@"成功"};
        NSDictionary *pradic = [data signWithSecurityKey];
        NSString *testurl    = [NSString stringWithFormat:@"%@/accountbill/listPage",API];
        NSLog(@"bill --- %@",pradic);
        [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"bill --- %@",object);
            
            NSString *s = [NSString stringWithFormat:@"%@",object[@"s"]];
            if ([s isEqualToString:@"1"]) {
                currentPage++;
                [billArray addObjectsFromArray:object[@"data"][@"recordList"]];
                [self.billView.billTableView reloadData];
            }else{
                [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
            }
            [self.billView.billTableView.mj_footer endRefreshing];
            // 隐藏UITableViewStyleGrouped上边多余的间隔
            self.billView.billTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];

        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.billView.billTableView.mj_footer endRefreshing];
            // 隐藏UITableViewStyleGrouped上边多余的间隔
            self.billView.billTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        self.billView.billTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}





#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return billArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return em*231;
}

//footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    MJHeader_tableView *foot = [[MJHeader_tableView alloc] init];
    //foot.backgroundColor = [UIColor redColor];
    return foot;
}

//header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] init];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID     = @"accountCell";
    NSDictionary *dic = billArray[indexPath.section];
    MJBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MJBillTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setBill:dic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"Did Select!");
    NSDictionary *dic = billArray[indexPath.section];
    MJBillDetailViewController *billDetailVC = [[MJBillDetailViewController alloc] init];
    billDetailVC.billDic = dic;
    [self.navigationController pushViewController:billDetailVC animated:YES];
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
