//
//  MJMyActivityViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMyActivityViewController.h"
#import "MJMyActivityView.h"
#import "MJMyActivityTableViewCell.h"

#import "MJActivityDetailViewController.h"

@interface MJMyActivityViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentPage;
    NSInteger totalCount;
    NSMutableArray *activityArray;
}
@property(nonatomic,strong)MJMyActivityView *myActivityView;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation MJMyActivityViewController
-(void)loadView{
    self.myActivityView = [[MJMyActivityView alloc] initWithFrame:SCREEN_BOUNDS];
    self.myActivityView.myActivityTableView.delegate = self;
    self.myActivityView.myActivityTableView.dataSource=self;
    self.view = self.myActivityView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = YES;
    self.navigationController.delegate = self;
    
    [self showProgress];
    [self loadDataSource];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishlLogin) name:@"finishlLogin" object:nil];
    
    [MJMJRefreshManage headerWithRefreshingTarget:self tableView:self.myActivityView.myActivityTableView sel:@selector(loadDataSource)];
    [MJMJRefreshManage footerWithRefreshingTarget:self tableView:self.myActivityView.myActivityTableView sel:@selector(loadMoreDataSource)];

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

- (void)finishlLogin{
    [self showProgress];
    [self loadDataSource];
}

#pragma mark - MJ LOAD SOURCE
- (void)loadDataSource{
    currentPage = 1;
    NSString *user_id    = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
    NSDictionary *data   = @{@"pageNum":@"1",@"numPerPage":@"10",@"shopId":user_id};
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/shopactivity/listPage",API];
    //NSLog(@"listby --- %@",pradic);
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        //NSLog(@"activity --- %@",object);
        [self.hud hideAnimated:YES];
        self.myActivityView.myActivityTableView.mj_footer.state = MJRefreshStateIdle;
        NSString *s = [NSString stringWithFormat:@"%@",object[@"s"]];
        if ([s isEqualToString:@"1"]) {
            activityArray = [NSMutableArray arrayWithArray:object[@"data"][@"recordList"]];
            currentPage = 2;
            totalCount  = [[NSString stringWithFormat:@"%@",object[@"data"][@"totalCount"]] integerValue];
            [self.myActivityView.myActivityTableView reloadData];
            //存储
            [[FMDB_Manager defaultManager] open];
            [[FMDB_Manager defaultManager] clear];
            if (activityArray.count>0) {
                for (NSDictionary *dic in activityArray) {
                    [[FMDB_Manager defaultManager] addData:dic];
                }
            }
            [[FMDB_Manager defaultManager] close];
        }else{
            [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
            //读取
            [[FMDB_Manager defaultManager] open];
            activityArray = [[FMDB_Manager defaultManager] searchData];
            [[FMDB_Manager defaultManager] close];
            [self.myActivityView.myActivityTableView reloadData];
        }
        [self.myActivityView.myActivityTableView.mj_header endRefreshing];
        //隐藏UITableViewStyleGrouped上边多余的间隔
        self.myActivityView.myActivityTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //empty
        [MJEmptyManager check:self.myActivityView.myActivityTableView dataArray:activityArray emptyView:self.emptyView];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.hud hideAnimated:YES];
        
        if (activityArray.count==0) {
            //读取
            [[FMDB_Manager defaultManager] open];
            activityArray = [NSMutableArray arrayWithArray:[[FMDB_Manager defaultManager] searchData]];
            [[FMDB_Manager defaultManager] close];
        }
        
        [self.myActivityView.myActivityTableView reloadData];
        [self.myActivityView.myActivityTableView.mj_header endRefreshing];
        //隐藏UITableViewStyleGrouped上边多余的间隔
        self.myActivityView.myActivityTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        //empty
        [MJEmptyManager check:self.myActivityView.myActivityTableView dataArray:activityArray emptyView:self.emptyView];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)loadMoreDataSource{
    //NSLog(@"load more");
    if (activityArray.count<totalCount) {
        NSString *user_id    = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
        NSDictionary *data;
        if (![user_id isNull]) {
            data = @{@"pageNum":[NSString stringWithFormat:@"%ld",currentPage],@"numPerPage":@"10",@"shopId":user_id};
        }else{
            data = @{@"pageNum":[NSString stringWithFormat:@"%ld",currentPage],@"numPerPage":@"10"};
        }
        
        NSDictionary *pradic = [data signWithSecurityKey];
        NSString *testurl    = [NSString stringWithFormat:@"%@/shopactivity/listPage",API];
        NSLog(@"listby --- %@",pradic);
        [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"activity --- %@",object);
            NSString *s = [NSString stringWithFormat:@"%@",object[@"s"]];
            if ([s isEqualToString:@"1"]) {
                currentPage++;
                [activityArray addObjectsFromArray:object[@"data"][@"recordList"]];
                [self.myActivityView.myActivityTableView reloadData];
            }else{
                [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
            }
            [self.myActivityView.myActivityTableView.mj_footer endRefreshing];
            // 隐藏UITableViewStyleGrouped上边多余的间隔
            self.myActivityView.myActivityTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.myActivityView.myActivityTableView.mj_footer endRefreshing];
            // 隐藏UITableViewStyleGrouped上边多余的间隔
            self.myActivityView.myActivityTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        self.myActivityView.myActivityTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}

/**Nav Deledate**/
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //NSLog(@"activity nava delegate");
    if ([viewController isKindOfClass:[self class]]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return activityArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return em*406;
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
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *foot = [[UIImageView alloc] init];
    //foot.backgroundColor = [UIColor orangeColor];
    return foot;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID     = @"activityCell";
    NSDictionary *activityDic = activityArray[indexPath.section];
    MJMyActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MJMyActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setMyActivity:activityDic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //NSLog(@"Did Select!");
    NSDictionary *activityDic = activityArray[indexPath.section];
    MJActivityDetailViewController *activityDetailVC = [[MJActivityDetailViewController alloc] init];
    activityDetailVC.oid = [NSString stringWithFormat:@"%@",activityDic[@"oid"]];
    [activityDetailVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:activityDetailVC animated:YES];
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
