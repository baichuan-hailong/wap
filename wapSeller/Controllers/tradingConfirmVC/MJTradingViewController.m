//
//  MJTradingViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJTradingViewController.h"
#import "MJTradingConfirmView.h"
#import "MJWaitTableViewCell.h"
#import "MJAllTableViewCell.h"

#import "MJSearchViewController.h"
#import "MJSettingViewController.h"

@interface MJTradingViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentPage_wait;
    NSInteger totalCount_wati;
    NSMutableArray *waitArray;
    
    NSInteger currentPage_sure;
    NSInteger totalCount_sure;
    NSMutableArray *sureArray;
    
    NSInteger currentPage_all;
    NSInteger totalCount_all;
    NSMutableArray *allArray;
    
    BOOL isSureFirst;
    BOOL isAllFirst;
}
@property(nonatomic,strong)MJTradingConfirmView *tradingView;
@property(nonatomic,strong)NSTimer       *mytimer;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation MJTradingViewController

-(void)loadView{
    self.tradingView = [[MJTradingConfirmView alloc] initWithFrame:SCREEN_BOUNDS];
    self.tradingView.tab_scrollView.delegate = self;
    self.tradingView.waitTableView.delegate = self;
    self.tradingView.waitTableView.dataSource=self;
    self.view = self.tradingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = YES;
    
    self.navigationController.delegate = self;
    self.title = @"交易确认";
    [self hideBack];
    [self addAction];
    
    [self showProgress];
    [self waitloadSource];
    [MJMJRefreshManage headerWithRefreshingTarget:self tableView:self.tradingView.waitTableView sel:@selector(waitloadSource)];
    [MJMJRefreshManage footerWithRefreshingTarget:self tableView:self.tradingView.waitTableView sel:@selector(waitloadMoreSource)];
    
    [MJMJRefreshManage headerWithRefreshingTarget:self tableView:self.tradingView.sureTableView sel:@selector(sureloadSource)];
    [MJMJRefreshManage footerWithRefreshingTarget:self tableView:self.tradingView.sureTableView sel:@selector(sureloadMoreSource)];
    
    [MJMJRefreshManage headerWithRefreshingTarget:self tableView:self.tradingView.allTableView sel:@selector(allloadSource)];
    [MJMJRefreshManage footerWithRefreshingTarget:self tableView:self.tradingView.allTableView sel:@selector(allloadMoreSource)];
    
    //search sure
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(searchSureAcNotification:) name:@"searchSureAcNotification" object:nil];
    
    //search cancle
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(searchCancleAcNotification:) name:@"searchCancleAcNotification" object:nil];
    
    //finish
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishlLogin) name:@"finishlLogin" object:nil];
    
    //notification fresh
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationfreshwait) name:@"notificationfreshwait" object:nil];
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
    [self.tradingView.waitBtn addTarget:self action:@selector(waitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tradingView.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tradingView.allBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //UIBarButtonItem *setitem              = [[UIBarButtonItem alloc]initWithCustomView:self.tradingView.setBtn];
    //self.navigationItem.leftBarButtonItem = setitem;
    UIBarButtonItem *rightitem            = [[UIBarButtonItem alloc]initWithCustomView:self.tradingView.searchBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
    [self.tradingView.setBtn addTarget:self action:@selector(setBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tradingView.searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Finish Login
- (void)finishlLogin{
    [self waitBtnClick:nil];
    if (waitArray.count>0) {
    }
    [self waitloadSource];
    if (sureArray.count>0) {
        [self sureloadSource];
    }
    if (allArray.count>0) {
        [self allloadSource];
    }
}

#pragma mark - 刷新待确认列表
- (void)notificationfreshwait{
    [self waitloadSource];
}

//setting
- (void)setBtnClick:(UIButton *)sender{
    MJSettingViewController *settingVC = [MJSettingViewController shareManager];
    [settingVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:settingVC animated:YES];
}

//search
- (void)searchBtnClick:(UIButton *)sender{
    MJSearchViewController *searchVC = [[MJSearchViewController alloc] init];
    [searchVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:searchVC animated:YES];
}


#pragma mark - wait
- (void)waitBtnClick:(UIButton *)sender{
    NSLog(@"wait");
    [self.tradingView.waitBtn setTitleColor:[UIColor colorWithHex:@"fc2523"] forState:UIControlStateNormal];
    [self.tradingView.sureBtn setTitleColor:[UIColor colorWithHex:@"a6a8b4"] forState:UIControlStateNormal];
    [self.tradingView.allBtn setTitleColor:[UIColor colorWithHex:@"a6a8b4"] forState:UIControlStateNormal];
    if (sender){
        [UIView animateWithDuration:0.58 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.tradingView.tab_line.frame = CGRectMake(em*200+em*11, em*150-em*6, em*128, em*6);
        } completion:nil];
        [self.tradingView.tab_scrollView setContentOffset:CGPointMake(0, 0)];
    }else{
        [UIView animateWithDuration:0.58 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.tradingView.tab_line.frame = CGRectMake(em*200+em*11, em*150-em*6, em*128, em*6);
        } completion:nil];
        [UIView animateWithDuration:0.28 animations:^{
            [self.tradingView.tab_scrollView setContentOffset:CGPointMake(0, 0)];
        }];
    }
}

#pragma mark - sure
- (void)sureBtnClick:(UIButton *)sender{
    self.tradingView.sureTableView.delegate = self;
    self.tradingView.sureTableView.dataSource=self;
    [self.tradingView.sureTableView reloadData];
    //NSLog(@"sure");
    if (sureArray.count==0&&!isSureFirst) {
        [self showProgress];
        [self sureloadSource];
        isSureFirst = YES;
    }
    [self.tradingView.waitBtn setTitleColor:[UIColor colorWithHex:@"a6a8b4"] forState:UIControlStateNormal];
    [self.tradingView.sureBtn setTitleColor:[UIColor colorWithHex:@"fc2523"] forState:UIControlStateNormal];
    [self.tradingView.allBtn setTitleColor:[UIColor colorWithHex:@"a6a8b4"] forState:UIControlStateNormal];
    if (sender){
        [self.tradingView.tab_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        [UIView animateWithDuration:0.58 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.tradingView.tab_line.frame = CGRectMake((SCREEN_WIDTH-em*128)/2, em*150-em*6, em*128, em*6);
        } completion:nil];
       
    }else{
        [UIView animateWithDuration:0.58 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.tradingView.tab_line.frame = CGRectMake((SCREEN_WIDTH-em*128)/2, em*150-em*6, em*128, em*6);
        } completion:nil];
        [UIView animateWithDuration:0.28 animations:^{
            [self.tradingView.tab_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
        }];
    }
}

#pragma mark - all
- (void)allBtnClick:(UIButton *)sender{
    self.tradingView.allTableView.delegate = self;
    self.tradingView.allTableView.dataSource=self;
    [self.tradingView.allTableView reloadData];
    //NSLog(@"all");
    if (allArray.count==0&&!isAllFirst) {
        [self showProgress];
        [self allloadSource];
        isAllFirst = YES;
    }
    
    
    [self.tradingView.waitBtn setTitleColor:[UIColor colorWithHex:@"a6a8b4"] forState:UIControlStateNormal];
    [self.tradingView.sureBtn setTitleColor:[UIColor colorWithHex:@"a6a8b4"] forState:UIControlStateNormal];
    [self.tradingView.allBtn setTitleColor:[UIColor colorWithHex:@"fc2523"] forState:UIControlStateNormal];
    
    if (sender){
        [self.tradingView.tab_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0)];
        [UIView animateWithDuration:0.58 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.tradingView.tab_line.frame = CGRectMake(SCREEN_WIDTH-em*200-em*11-em*128, em*150-em*6, em*128, em*6);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.58 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.tradingView.tab_line.frame = CGRectMake(SCREEN_WIDTH-em*200-em*11-em*128, em*150-em*6, em*128, em*6);
        } completion:nil];
        [UIView animateWithDuration:0.28 animations:^{
            [self.tradingView.tab_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0)];
        }];
    }
}


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    switch (tableView.tag) {
        case 2000:
            return waitArray.count;
            break;
        case 2001:
            return sureArray.count;
            break;
        case 2002:
            return allArray.count;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic;
    NSString *confirmStatus;
    switch (tableView.tag) {
        case 2000:
            return em*931;
            break;
        case 2001:
            return em*845;
            break;
        case 2002:
            dic = allArray[indexPath.section];
            confirmStatus = [NSString stringWithFormat:@"%@",dic[@"confirmStatus"]];
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
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return em*30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *foot = [[UIView alloc] init];
    //foot.backgroundColor = [UIColor redColor];
    return foot;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *waitcellID     = @"waittradingCell";
    static NSString *surecellID     = @"suretradingCell";
    UITableViewCell *cell;
    MJWaitTableViewCell *waitCell;
    MJAllTableViewCell  *sureCell;
    /*all*/
    static NSString *waitcellID_all    = @"waittradingCell_all";
    static NSString *allcellID_all      = @"alltradingCell_all";
    NSDictionary *dic;
    NSString *confirmStatus;
    MJWaitTableViewCell *waitCell_all;
    MJAllTableViewCell  *allCell_all;
    switch (tableView.tag) {
        case 2000:
            dic = waitArray[indexPath.section];
            waitCell = [tableView dequeueReusableCellWithIdentifier:waitcellID];
            if (!waitCell) {
                waitCell = [[MJWaitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitcellID];
            }
            [waitCell setWait:dic];
            waitCell.sureBtn.tag = 3000+indexPath.section;
            [waitCell.sureBtn addTarget:self action:@selector(sureBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
            waitCell.cancleBtn.tag = 4000+indexPath.section;
            [waitCell.cancleBtn addTarget:self action:@selector(cancleBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
            cell = waitCell;
            break;
        case 2001:
            dic = sureArray[indexPath.section];
            sureCell = [tableView dequeueReusableCellWithIdentifier:surecellID];
            if (!sureCell) {
                sureCell = [[MJAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:surecellID];
            }
            [sureCell setWait:dic isSure:YES];
            cell = sureCell;
            break;
        case 2002:
            dic = allArray[indexPath.section];
            confirmStatus = [NSString stringWithFormat:@"%@",dic[@"confirmStatus"]];
            if ([confirmStatus isEqualToString:@"已确认"]){
                //已确认
                allCell_all = [tableView dequeueReusableCellWithIdentifier:allcellID_all];
                if (!allCell_all) {
                    allCell_all = [[MJAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allcellID_all];
                }
                [allCell_all setWait:dic isSure:YES];
                cell = allCell_all;
                
            }else if ([confirmStatus isEqualToString:@"未确认"]){
                //未确认
                waitCell_all = [tableView dequeueReusableCellWithIdentifier:waitcellID_all];
                if (!waitCell_all) {
                    waitCell_all = [[MJWaitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitcellID_all];
                }
                [waitCell_all setWait:dic];
                waitCell_all.sureBtn.tag = 6000+indexPath.section;
                [waitCell_all.sureBtn addTarget:self action:@selector(allsureBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
                waitCell_all.cancleBtn.tag = 6500+indexPath.section;
                [waitCell_all.cancleBtn addTarget:self action:@selector(allcancleBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
                cell = waitCell_all;
            }else{
                //已取消
                allCell_all = [tableView dequeueReusableCellWithIdentifier:allcellID_all];
                if (!allCell_all) {
                    allCell_all = [[MJAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allcellID_all];
                }
                [allCell_all setWait:dic isSure:NO];
                cell = allCell_all;
            }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (tableView.tag) {
        case 2000:
            NSLog(@"wait");
            break;
        case 2001:
            NSLog(@"sure");
            break;
        case 2002:
            NSLog(@"all");
            break;
        default:
            break;
    }
}

#pragma mark - Scroll Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (![scrollView isKindOfClass:[UITableView class]]) {
        NSLog(@"1");
        if (scrollView.mj_offsetX==0) {
            [self waitBtnClick:nil];
        }else if (scrollView.mj_offsetX==SCREEN_WIDTH){
            [self sureBtnClick:nil];
        }else{
            [self allBtnClick:nil];
        }
    }
}

#pragma mark - 确认
//wait
- (void)sureBtnDidClick:(UIButton *)sender{
    NSLog(@"sure section --- %ld",sender.tag-3000);
    NSDictionary *dic = waitArray[sender.tag-3000];
    [self makeOperationWithOrdId:[NSString stringWithFormat:@"%@",dic[@"oid"]]
                   versionNoLong:[NSString stringWithFormat:@"%@",dic[@"versionNoLong"]]
                      confirmVal:@"1"
                           index:sender.tag-3000
                      isWaitList:YES];
    
    
    
    
}
#pragma mark - 无效
- (void)cancleBtnDidClick:(UIButton *)sender{
    NSLog(@"canc section --- %ld",sender.tag-4000);
    NSDictionary *dic = waitArray[sender.tag-4000];
    [self makeOperationWithOrdId:[NSString stringWithFormat:@"%@",dic[@"oid"]]
                   versionNoLong:[NSString stringWithFormat:@"%@",dic[@"versionNoLong"]]
                      confirmVal:@"0"
                           index:sender.tag-4000
                      isWaitList:YES];
    
   
}

//all
#pragma mark - 确认
- (void)allsureBtnDidClick:(UIButton *)sender{
    NSLog(@"sure section --- %ld",sender.tag-6000);
    NSDictionary *dic = allArray[sender.tag-6000];
    [self makeOperationWithOrdId:[NSString stringWithFormat:@"%@",dic[@"oid"]]
                   versionNoLong:[NSString stringWithFormat:@"%@",dic[@"versionNoLong"]]
                      confirmVal:@"1"
                           index:sender.tag-6000
                      isWaitList:NO];
    
    
}
#pragma mark - 无效
- (void)allcancleBtnDidClick:(UIButton *)sender{
    NSLog(@"canc section --- %ld",sender.tag-6500);
    NSDictionary *dic = allArray[sender.tag-6500];
    [self makeOperationWithOrdId:[NSString stringWithFormat:@"%@",dic[@"oid"]]
                   versionNoLong:[NSString stringWithFormat:@"%@",dic[@"versionNoLong"]]
                      confirmVal:@"0"
                           index:sender.tag-6500
                      isWaitList:NO];
    
    
}


- (void)refresh:(NSString *)confirmVal index:(NSInteger)index isWaitList:(BOOL)isWait{
    NSLog(@"index --- %ld",index);
    if (isWait) {
        //wait list
        NSDictionary *dic = waitArray[index];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        if ([confirmVal isEqualToString:@"1"]) {
            //确认
            tempDic[@"confirmStatus"] = @"已确认";
            if (sureArray.count>0) {
                [sureArray insertObject:tempDic atIndex:0];
                [self.tradingView.sureTableView reloadData];
            }
        }else{
            //无效
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
            //无效
            tempDic[@"confirmStatus"] = @"已取消";
            if (allArray.count>0) {
                [allArray insertObject:tempDic atIndex:0];
                [self.tradingView.allTableView reloadData];
            }
        }
        [waitArray removeObjectAtIndex:index];
        [self.tradingView.waitTableView reloadData];
    }else{
        //all  list
        NSDictionary *dic = allArray[index];
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        if ([confirmVal isEqualToString:@"1"]) {
            //确认
            tempDic[@"confirmStatus"] = @"已确认";
            if (sureArray.count>0) {
                [sureArray insertObject:tempDic atIndex:0];
                [self.tradingView.sureTableView reloadData];
            }
        }else{
            //无效
            tempDic[@"confirmStatus"] = @"已取消";
        }
        if (waitArray.count>0&&[waitArray containsObject:dic]) {
            [waitArray removeObject:dic];
            [self.tradingView.waitTableView reloadData];
        }
        [allArray replaceObjectAtIndex:index withObject:tempDic];
        [self.tradingView.allTableView reloadData];
    }
}


#pragma mark - Search 确认
- (void)searchSureAcNotification:(NSNotification *)notification{
    NSDictionary *dic = [notification object];
    //NSLog(@"%@",dic);
    if (waitArray.count>0&&[waitArray containsObject:dic]) {
        [waitArray removeObject:dic];
        [self.tradingView.waitTableView reloadData];
    }
    if (sureArray.count>0) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        tempDic[@"confirmStatus"] = @"已确认";
        [sureArray insertObject:tempDic atIndex:0];
        [self.tradingView.sureTableView reloadData];
    }
    
    if (allArray.count>0&&[allArray containsObject:dic]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        tempDic[@"confirmStatus"] = @"已确认";
        [allArray removeObject:dic];
        [allArray insertObject:tempDic atIndex:0];
        [self.tradingView.allTableView reloadData];
    }
}

#pragma mark - Search 无效
- (void)searchCancleAcNotification:(NSNotification *)notification{
    NSDictionary *dic = [notification object];
    NSLog(@"%@",dic);
    if (waitArray.count>0&&[waitArray containsObject:dic]) {
        [waitArray removeObject:dic];
        [self.tradingView.waitTableView reloadData];
    }
    
    if (allArray.count>0&&[allArray containsObject:dic]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        tempDic[@"confirmStatus"] = @"已取消";
        [allArray removeObject:dic];
        [allArray insertObject:tempDic atIndex:0];
        [self.tradingView.allTableView reloadData];
    }
}



//successful
- (void)startPOP{
    //bug
    [_mytimer invalidate];
    _mytimer  = nil;
    [[UIApplication sharedApplication].keyWindow addSubview:self.tradingView.successfulPopView];
    [UIView animateWithDuration:0.18 animations:^{
        self.tradingView.successfulPopView.alpha = 1;
    }];
    self.mytimer = [NSTimer scheduledTimerWithTimeInterval:1.18 target:self selector:@selector(popCancelAction) userInfo:nil repeats:YES];
}


//failed
- (void)failPop{
    //bug
    [_mytimer invalidate];
    _mytimer  = nil;
    [[UIApplication sharedApplication].keyWindow addSubview:self.tradingView.failedPopView];
    [UIView animateWithDuration:0.18 animations:^{
        self.tradingView.failedPopView.alpha = 1;
    }];
    self.mytimer = [NSTimer scheduledTimerWithTimeInterval:1.18 target:self selector:@selector(popCancelAction) userInfo:nil repeats:YES];
}



- (void)popCancelAction{
    [UIView animateWithDuration:0.18 animations:^{
        //successful
        self.tradingView.successfulPopView.alpha = 0;
        //fail
        self.tradingView.failedPopView.alpha = 0;
    } completion:^(BOOL finished) {
        //successful
        [self.tradingView.successfulPopView removeFromSuperview];
        //fail
        [self.tradingView.failedPopView removeFromSuperview];
        [_mytimer invalidate];
        _mytimer  = nil;
    }];
}

/**Nav Deledate**/
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSLog(@"trading nava delegate");
    if ([viewController isKindOfClass:[self class]]) {
        //[self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
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





- (void)makeOperationWithOrdId:(NSString *)orderID versionNoLong:(NSString *)versionNl confirmVal:(NSString *)confirmVal index:(NSInteger)index isWaitList:(BOOL)isWait{
    NSDictionary *data   = @{@"orderId":orderID,@"versionNoLong":versionNl,@"confirmVal":confirmVal};
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/activityorder/doConfirm",API];
    NSLog(@"listby --- %@",pradic);
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"Operation --- %@",object);
        NSLog(@"%@",object[@"message"]);
        NSLog(@"%@",object[@"m"]);
        NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
        if ([status isEqualToString:@"1000"]) {
            [self refresh:confirmVal index:index isWaitList:isWait];
            if ([confirmVal isEqualToString:@"1"]) {
                //successful
                [self.tradingView.successfulPopView setTip:[UIImage imageNamed:@"successful_image"] tipText:@"确认成功"];
                [self startPOP];
            }else{
                [self.tradingView.successfulPopView setTip:[UIImage imageNamed:@"wuxiao_iamge"] tipText:@"确认无效"];
                [self startPOP];
            }
        }else{
            if ([confirmVal isEqualToString:@"1"]) {
                //fail
                [self.tradingView.failedPopView setTip:[UIImage imageNamed:@"failed_image"]
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




/*************************************************Data --- Data**************************************************************/
#pragma mark - Data
//wait
- (void)waitloadSource{
    NSLog(@"wait");
    currentPage_wait = 1;
    NSString *user_id    = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
    NSDictionary *data;
    if (![user_id isNull]) {
        data   = @{@"confirmStatus":@"未确认",@"pageNum":@"1",@"numPerPage":@"10",@"shopId":user_id};
    }else{
        data   = @{@"confirmStatus":@"未确认",@"pageNum":@"1",@"numPerPage":@"10"};
    }
    
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/activityorder/listPage",API];
    NSLog(@"wait --- %@",pradic);
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        [self.hud hideAnimated:YES];
        NSLog(@"wait --- %@",object);
        self.tradingView.waitTableView.mj_footer.state = MJRefreshStateIdle;
        NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
        if ([status isEqualToString:@"1000"]) {
            waitArray = [NSMutableArray arrayWithArray:object[@"data"][@"recordList"]];
            currentPage_wait = 2;
            totalCount_wati  = [[NSString stringWithFormat:@"%@",object[@"data"][@"totalCount"]] integerValue];
            [self.tradingView.waitTableView reloadData];
        }else{
            [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
        }
        [self.tradingView.waitTableView.mj_header endRefreshing];
        //empty
        [MJEmptyManager check:self.tradingView.waitTableView dataArray:waitArray emptyView:self.emptyView];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        //empty
        [MJEmptyManager check:self.tradingView.waitTableView dataArray:waitArray emptyView:self.emptyView];
        [self.hud hideAnimated:YES];
        [self.tradingView.waitTableView.mj_header endRefreshing];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)waitloadMoreSource{
    NSLog(@"wait more");
    if (waitArray.count<totalCount_wati) {
        NSString *user_id    = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
        NSDictionary *data;
        if (![user_id isNull]) {
            data   = @{@"confirmStatus":@"未确认",@"pageNum":[NSString stringWithFormat:@"%ld",currentPage_wait],@"numPerPage":@"10",@"shopId":user_id};
        }else{
            data   = @{@"confirmStatus":@"未确认",@"pageNum":[NSString stringWithFormat:@"%ld",currentPage_wait],@"numPerPage":@"10"};
        }
        NSDictionary *pradic = [data signWithSecurityKey];
        NSString *testurl    = [NSString stringWithFormat:@"%@/activityorder/listPage",API];
        NSLog(@"wait --- %@",pradic);
        [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"wait --- %@",object);
            NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
            if ([status isEqualToString:@"1000"]) {
                currentPage_wait++;
                [waitArray addObjectsFromArray:object[@"data"][@"recordList"]];
                [self.tradingView.waitTableView reloadData];
            }else{
                [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
            }
            [self.tradingView.waitTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.tradingView.waitTableView.mj_footer endRefreshing];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        self.tradingView.waitTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}

//sure
- (void)sureloadSource{
    NSLog(@"sure");
    currentPage_sure = 1;
    
    NSString *user_id    = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
    NSDictionary *data;
    if (![user_id isNull]) {
        data   = @{@"confirmStatus":@"已确认",@"pageNum":@"1",@"numPerPage":@"10",@"shopId":user_id};
    }else{
        data   = @{@"confirmStatus":@"已确认",@"pageNum":@"1",@"numPerPage":@"10"};
    }
    
    
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/activityorder/listPage",API];
    NSLog(@"sure --- %@",pradic);
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"sure --- %@",object);
        [self.hud hideAnimated:YES];
        self.tradingView.sureTableView.mj_footer.state = MJRefreshStateIdle;
        NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
        if ([status isEqualToString:@"1000"]) {
            sureArray = [NSMutableArray arrayWithArray:object[@"data"][@"recordList"]];
            currentPage_sure = 2;
            totalCount_sure  = [[NSString stringWithFormat:@"%@",object[@"data"][@"totalCount"]] integerValue];
            [self.tradingView.sureTableView reloadData];
        }else{
            [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
        }
        [self.tradingView.sureTableView.mj_header endRefreshing];
        //empty
        [MJEmptyManager check:self.tradingView.sureTableView dataArray:sureArray emptyView:self.emptyView_o];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        //empty
        [MJEmptyManager check:self.tradingView.sureTableView dataArray:sureArray emptyView:self.emptyView_o];
        [self.hud hideAnimated:YES];
        [self.tradingView.sureTableView.mj_header endRefreshing];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)sureloadMoreSource{
    NSLog(@"sure more");
    if (sureArray.count<totalCount_sure) {
        
        NSString *user_id    = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
        NSDictionary *data;
        if (![user_id isNull]) {
            data   = @{@"confirmStatus":@"已确认",@"pageNum":[NSString stringWithFormat:@"%ld",currentPage_sure],@"numPerPage":@"10",@"shopId":user_id};
        }else{
            data   = @{@"confirmStatus":@"已确认",@"pageNum":[NSString stringWithFormat:@"%ld",currentPage_sure],@"numPerPage":@"10"};
        }
        
        NSDictionary *pradic = [data signWithSecurityKey];
        NSString *testurl    = [NSString stringWithFormat:@"%@/activityorder/listPage",API];
        NSLog(@"sure more --- %@",pradic);
        [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"sure more --- %@",object);
            NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
            if ([status isEqualToString:@"1000"]) {
                currentPage_sure++;
                [sureArray addObjectsFromArray:object[@"data"][@"recordList"]];
                [self.tradingView.sureTableView reloadData];
            }else{
                [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
            }
            [self.tradingView.sureTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.tradingView.sureTableView.mj_footer endRefreshing];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        self.tradingView.sureTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}

//all
- (void)allloadSource{
    NSLog(@"all");
    currentPage_all = 1;
    
    NSString *user_id    = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
    NSDictionary *data;
    if (![user_id isNull]) {
        data   = @{@"confirmStatus":@"",@"pageNum":@"1",@"numPerPage":@"10",@"shopId":user_id};
    }else{
        data   = @{@"confirmStatus":@"",@"pageNum":@"1",@"numPerPage":@"10"};
    }
    
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/activityorder/listPage",API];
    NSLog(@"all --- %@",pradic);
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"all --- %@",object);
        [self.hud hideAnimated:YES];
        self.tradingView.allTableView.mj_footer.state = MJRefreshStateIdle;
        NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
        if ([status isEqualToString:@"1000"]) {
            allArray = [NSMutableArray arrayWithArray:object[@"data"][@"recordList"]];
            currentPage_all = 2;
            totalCount_all  = [[NSString stringWithFormat:@"%@",object[@"data"][@"totalCount"]] integerValue];
            [self.tradingView.allTableView reloadData];
        }else{
            [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
        }
        [self.tradingView.allTableView.mj_header endRefreshing];
        //empty
        [MJEmptyManager check:self.tradingView.allTableView dataArray:allArray emptyView:self.emptyView_t];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        //empty
        [MJEmptyManager check:self.tradingView.allTableView dataArray:allArray emptyView:self.emptyView_t];
        [self.hud hideAnimated:YES];
        [self.tradingView.allTableView.mj_header endRefreshing];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}

- (void)allloadMoreSource{
    NSLog(@"all more");
    if (allArray.count<totalCount_all) {
        
        NSString *user_id    = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
        NSDictionary *data;
        if (![user_id isNull]) {
            data   = @{@"confirmStatus":@"",@"pageNum":[NSString stringWithFormat:@"%ld",currentPage_all],@"numPerPage":@"10",@"shopId":user_id};
        }else{
            data   = @{@"confirmStatus":@"",@"pageNum":[NSString stringWithFormat:@"%ld",currentPage_all],@"numPerPage":@"10"};
        }
        
        NSDictionary *pradic = [data signWithSecurityKey];
        NSString *testurl    = [NSString stringWithFormat:@"%@/activityorder/listPage",API];
        NSLog(@"all more --- %@",pradic);
        [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
            NSLog(@"all more --- %@",object);
            NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
            if ([status isEqualToString:@"1000"]) {
                currentPage_all++;
                [allArray addObjectsFromArray:object[@"data"][@"recordList"]];
                [self.tradingView.allTableView reloadData];
            }else{
                [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
            }
            [self.tradingView.allTableView.mj_footer endRefreshing];
        } withFailureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [self.tradingView.allTableView.mj_footer endRefreshing];
        } progress:^(float progress) {
            NSLog(@"%f",progress);
        }];
    }else{
        self.tradingView.allTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
