//
//  MJActivityDetailViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/27.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJActivityDetailViewController.h"
#import "MJMyActivityDetailView.h"
#import "MJWaitTableViewCell.h"
#import "MJAllTableViewCell.h"

@interface MJActivityDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *jiaoyiArray;
}
@property(nonatomic,strong)MJMyActivityDetailView *activityDetailView;
@property(nonatomic,strong)NSTimer       *mytimer;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation MJActivityDetailViewController

- (void)loadView{
    self.activityDetailView = [[MJMyActivityDetailView alloc] initWithFrame:SCREEN_BOUNDS];
    self.activityDetailView.activityDetailTableView.delegate = self;
    self.activityDetailView.activityDetailTableView.dataSource=self;
    self.view = self.activityDetailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动详情";
    
    [self showProgress];
    [self loadDataSource];
    
    [MJMJRefreshManage headerWithRefreshingTarget:self tableView:self.activityDetailView.activityDetailTableView sel:@selector(loadDataSource)];
}


#pragma mark - MJ LOAD SOURCE
- (void)loadDataSource{
    
    
    NSString *user_id    = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
    NSDictionary *data;
    if (![user_id isNull]) {
        data   = @{@"activityId":self.oid,@"shopId":user_id};
    }else{
        data   = @{@"activityId":self.oid};
    }
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/activityorder/listBy",API];
    NSLog(@"listby --- %@",pradic);
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"jiaoyi --- %@",object);
        [self.hud hideAnimated:YES];
        NSString *s = [NSString stringWithFormat:@"%@",object[@"s"]];
        if ([s isEqualToString:@"1"]) {
            jiaoyiArray = [NSMutableArray arrayWithArray:object[@"data"]];
            [self.activityDetailView.activityDetailTableView reloadData];
        }else{
            [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
        }
        [self.activityDetailView.activityDetailTableView.mj_header endRefreshing];
        //empty
        [MJEmptyManager check:self.activityDetailView.activityDetailTableView dataArray:jiaoyiArray emptyView:self.emptyView];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        //empty
        [MJEmptyManager check:self.activityDetailView.activityDetailTableView dataArray:jiaoyiArray emptyView:self.emptyView];
        [self.hud hideAnimated:YES];
        [self.activityDetailView.activityDetailTableView.mj_header endRefreshing];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}





#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return jiaoyiArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *jiaoyiDic = jiaoyiArray[indexPath.section];
    NSString *confirmStatus = [NSString stringWithFormat:@"%@",jiaoyiDic[@"confirmStatus"]];
    
    if ([confirmStatus isEqualToString:@"已确认"]){
        //已确认
        return em*845;
    }else if ([confirmStatus isEqualToString:@"未确认"]){
        //未确认
        return em*931;
    }else{
        //已取消
        return em*845;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return em*30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] init];
    //header.backgroundColor = [UIColor redColor];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *waitcellID     = @"waittradingCell";
    static NSString *surecellID     = @"suretradingCell";
    static NSString *allcellID      = @"alltradingCell";
    
    UITableViewCell *cell;
    
    MJWaitTableViewCell *waitCell;
    MJAllTableViewCell  *sureCell;
    MJAllTableViewCell  *allCell;
    
    NSDictionary *jiaoyiDic = jiaoyiArray[indexPath.section];
    NSString *confirmStatus = [NSString stringWithFormat:@"%@",jiaoyiDic[@"confirmStatus"]];
    
    if ([confirmStatus isEqualToString:@"已确认"]) {
        sureCell = [tableView dequeueReusableCellWithIdentifier:surecellID];
        if (!sureCell) {
            sureCell = [[MJAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:surecellID];
        }
        [sureCell setWait:jiaoyiDic isSure:YES];
        cell = sureCell;
        
    }else if ([confirmStatus isEqualToString:@"未确认"]){
        waitCell = [tableView dequeueReusableCellWithIdentifier:waitcellID];
        if (!waitCell) {
            waitCell = [[MJWaitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitcellID];
        }
        [waitCell setWait:jiaoyiDic];
        waitCell.sureBtn.tag = 3500+indexPath.section;
        [waitCell.sureBtn addTarget:self action:@selector(sureBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        waitCell.cancleBtn.tag = 4500+indexPath.section;
        [waitCell.cancleBtn addTarget:self action:@selector(cancleBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        cell = waitCell;
        
    }else{
        //已取消
        allCell = [tableView dequeueReusableCellWithIdentifier:allcellID];
        if (!allCell) {
            allCell = [[MJAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allcellID];
        }
        [allCell setWait:jiaoyiDic isSure:NO];
        cell = allCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"click");
}

#pragma mark - 确认
- (void)sureBtnDidClick:(UIButton *)sender{
    NSDictionary *dic = jiaoyiArray[sender.tag-3500];
    [self makeOperationWithOrdId:[NSString stringWithFormat:@"%@",dic[@"oid"]]
                   versionNoLong:[NSString stringWithFormat:@"%@",dic[@"versionNoLong"]]
                      confirmVal:@"1" index:sender.tag-3500];
}

#pragma mark - 无效
- (void)cancleBtnDidClick:(UIButton *)sender{
    //NSLog(@"section --- %ld",sender.tag-4500);
    NSDictionary *dic = jiaoyiArray[sender.tag-4500];
    [self makeOperationWithOrdId:[NSString stringWithFormat:@"%@",dic[@"oid"]]
                   versionNoLong:[NSString stringWithFormat:@"%@",dic[@"versionNoLong"]]
                      confirmVal:@"0" index:sender.tag-4500];
}

- (void)refresh:(NSString *)confirmVal index:(NSInteger)index{
    NSDictionary *dic = jiaoyiArray[index];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    if ([confirmVal isEqualToString:@"1"]) {
        //确认
        tempDic[@"confirmStatus"] = @"已确认";
    }else{
        //无效
        tempDic[@"confirmStatus"] = @"已取消";
    }
    [jiaoyiArray replaceObjectAtIndex:index withObject:tempDic];
    [self.activityDetailView.activityDetailTableView reloadData];
}


- (void)makeOperationWithOrdId:(NSString *)orderID versionNoLong:(NSString *)versionNl confirmVal:(NSString *)confirmVal index:(NSInteger)index{
    NSDictionary *data   = @{@"orderId":orderID,@"versionNoLong":versionNl,@"confirmVal":confirmVal};
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/activityorder/doConfirm",API];
    NSLog(@"listby --- %@",pradic);
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"Operation --- %@",object);
        NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
        if ([status isEqualToString:@"1000"]) {
            [self refresh:confirmVal index:index];
            if ([confirmVal isEqualToString:@"1"]) {
                //successful
                [self.activityDetailView.successfulPopView setTip:[UIImage imageNamed:@"successful_image"] tipText:@"确认成功"];
                [self startPOP];
            }else{
                [self.activityDetailView.successfulPopView setTip:[UIImage imageNamed:@"wuxiao_iamge"] tipText:@"确认无效"];
                [self startPOP];
            }
            //[self.activityDetailView.activityDetailTableView reloadData];
        }else{
            if ([confirmVal isEqualToString:@"1"]) {
                //fail
                [self.activityDetailView.failedPopView setTip:[UIImage imageNamed:@"failed_image"]
                                                      tipText:@"确认失败"
                                                          des:[NSString stringWithFormat:@"%@",object[@"m"]]];
                [self failPop];
            }else{
                [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
            }
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



//successful
- (void)startPOP{
    //bug
    [_mytimer invalidate];
    _mytimer  = nil;
    [[UIApplication sharedApplication].keyWindow addSubview:self.activityDetailView.successfulPopView];
    [UIView animateWithDuration:0.18 animations:^{
        self.activityDetailView.successfulPopView.alpha = 0.8;
    }];
    self.mytimer = [NSTimer scheduledTimerWithTimeInterval:1.18 target:self selector:@selector(popCancelAction) userInfo:nil repeats:YES];
}


//failed
- (void)failPop{
    //bug
    [_mytimer invalidate];
    _mytimer  = nil;
    [[UIApplication sharedApplication].keyWindow addSubview:self.activityDetailView.failedPopView];
    [UIView animateWithDuration:0.18 animations:^{
        self.activityDetailView.failedPopView.alpha = 0.8;
    }];
    self.mytimer = [NSTimer scheduledTimerWithTimeInterval:1.18 target:self selector:@selector(popCancelAction) userInfo:nil repeats:YES];
}

- (void)popCancelAction{
    [UIView animateWithDuration:0.18 animations:^{
        //successful
        self.activityDetailView.successfulPopView.alpha = 0;
        //fail
        self.activityDetailView.failedPopView.alpha = 0;
    } completion:^(BOOL finished) {
        //successful
        [self.activityDetailView.successfulPopView removeFromSuperview];
        //fail
        [self.activityDetailView.failedPopView removeFromSuperview];
        [_mytimer invalidate];
        _mytimer  = nil;
    }];
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
