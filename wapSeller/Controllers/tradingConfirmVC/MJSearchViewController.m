//
//  MJSearchViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/28.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJSearchViewController.h"
#import "MJSearchView.h"
#import "MJAllTableViewCell.h"
#import "MJWaitTableViewCell.h"

@interface MJSearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL isLeft_data_bool;
    NSMutableArray *searchArray;
}
@property(nonatomic, strong)MJSearchView *searchView;
@property(nonatomic,strong)NSTimer       *mytimer;
@end

@implementation MJSearchViewController

- (void)loadView{
    self.searchView = [[MJSearchView alloc] initWithFrame:SCREEN_BOUNDS];
    self.searchView.searchTableView.delegate = self;
    self.searchView.searchTableView.dataSource=self;
    self.view = self.searchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0  green:241/255.0  blue:247/255.0 alpha:1];
    [self addAction];
}

- (void)addAction{
    UITapGestureRecognizer *viewTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGRAction:)];
    [self.view addGestureRecognizer:viewTapGR];
    
    self.searchView.leftDateTextField.delegate = self;
    self.searchView.rightDateTextfield.delegate= self;
    
    [self.searchView.cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView.sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //搜索按钮
    self.searchView.orderIDTextField.returnKeyType = UIReturnKeySearch;
    self.searchView.orderIDTextField.delegate = self;
    self.searchView.moneyTextField.returnKeyType = UIReturnKeySearch;
    self.searchView.moneyTextField.delegate = self;
    
    [self.searchView.myDatePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchaction) name:@"" object:nil];
}

- (void)viewTapGRAction:(UITapGestureRecognizer *)sender{
    [self.view endEditing:YES];
    [self cancleBtnClick:nil];
}

//UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"serarch...");
    [self searchSource];
    return YES;
}

- (void)dateChanged{
    [self sureBtnClick:nil];
}


#pragma mark - cancle & suer
- (void)cancleBtnClick:(UIButton *)sender{
    [UIView animateWithDuration:0.28 animations:^{
        self.searchView.topView.frame = CGRectMake(0,
                                                   SCREEN_HEIGHT,
                                                   SCREEN_WIDTH,
                                                   SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
    }];
}

- (void)sureBtnClick:(UIButton *)sender{

    
    [self cancleBtnClick:nil];
    NSString *change = [self changeFormat:self.searchView.myDatePicker.date];
    NSString *timeStamp = [self timestamp:self.searchView.myDatePicker.date];
    NSLog(@"change %@  timeStamp %@",change,timeStamp);
    if (isLeft_data_bool) {
        self.searchView.leftDateTextField.text = change;
    }else{
        self.searchView.rightDateTextfield.text = change;
    }
    
    [self searchSource];
}


#pragma mark - TEXT DELEGATE
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag==1010||textField.tag==1011) {
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.28 animations:^{
            self.searchView.topView.frame = CGRectMake(0,
                                                       SCREEN_HEIGHT-SCREEN_WIDTH/375*200-SCREEN_WIDTH/375*25,
                                                       SCREEN_WIDTH,
                                                       SCREEN_WIDTH/375*200+SCREEN_WIDTH/375*25);
        }];
        switch (textField.tag) {
            case 1010:
                NSLog(@"left");
                isLeft_data_bool = YES;
                break;
            case 1011:
                NSLog(@"right");
                isLeft_data_bool = NO;
                break;
                
            default:
                break;
        }
        return NO;
    }else{
        return YES;
    }
}


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return searchArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = searchArray[indexPath.section];
    NSString *confirmStatus = [NSString stringWithFormat:@"%@",dic[@"confirmStatus"]];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return em*30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *foot = [[UIView alloc] init];
    //foot.backgroundColor = [UIColor redColor];
    return foot;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *waitcellID_search    = @"waittradingCell_search";
    static NSString *allcellID_search     = @"alltradingCell_search";
    
    NSDictionary *dic = searchArray[indexPath.section];
    NSString *confirmStatus = [NSString stringWithFormat:@"%@",dic[@"confirmStatus"]];
    if ([confirmStatus isEqualToString:@"已确认"]){
        //已确认
        MJAllTableViewCell *allCell_all = [tableView dequeueReusableCellWithIdentifier:allcellID_search];
        if (!allCell_all) {
            allCell_all = [[MJAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allcellID_search];
        }
        [allCell_all setWait:dic isSure:YES];
        return allCell_all;
        
    }else if ([confirmStatus isEqualToString:@"未确认"]){
        //未确认
        MJWaitTableViewCell *waitCell_all = [tableView dequeueReusableCellWithIdentifier:waitcellID_search];
        if (!waitCell_all) {
            waitCell_all = [[MJWaitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitcellID_search];
        }
        waitCell_all.sureBtn.tag = 5000+indexPath.section;
        [waitCell_all.sureBtn addTarget:self action:@selector(sureBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        waitCell_all.cancleBtn.tag = 5500+indexPath.section;
        [waitCell_all.cancleBtn addTarget:self action:@selector(cancleBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [waitCell_all setWait:dic];
        return waitCell_all;
    }else{
        //已取消
        MJAllTableViewCell *allCell_all = [tableView dequeueReusableCellWithIdentifier:allcellID_search];
        if (!allCell_all) {
            allCell_all = [[MJAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:allcellID_search];
        }
        [allCell_all setWait:dic isSure:NO];
        return allCell_all;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"did");
}
#pragma mark - 确认
- (void)sureBtnDidClick:(UIButton *)sender{
    NSLog(@"sure section --- %ld",sender.tag-5000);
    NSDictionary *dic = searchArray[sender.tag-5000];
    [self makeOperationWithOrdId:[NSString stringWithFormat:@"%@",dic[@"oid"]]
                   versionNoLong:[NSString stringWithFormat:@"%@",dic[@"versionNoLong"]]
                      confirmVal:@"1"
                           index:sender.tag-5000];
    
}
#pragma mark - 无效
- (void)cancleBtnDidClick:(UIButton *)sender{
    NSLog(@"canc section --- %ld",sender.tag-5500);
    NSDictionary *dic = searchArray[sender.tag-5500];
    [self makeOperationWithOrdId:[NSString stringWithFormat:@"%@",dic[@"oid"]]
                   versionNoLong:[NSString stringWithFormat:@"%@",dic[@"versionNoLong"]]
                      confirmVal:@"0"
                           index:sender.tag-5500];
    
}

- (void)refresh:(NSString *)confirmVal index:(NSInteger)index{
    NSDictionary *dic            = searchArray[index];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    if ([confirmVal isEqualToString:@"1"]) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"searchSureAcNotification" object:dic];
        //确认
        tempDic[@"confirmStatus"] = @"已确认";
    }else{
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"searchCancleAcNotification" object:dic];
        //无效
        tempDic[@"confirmStatus"] = @"已取消";
    }
    [searchArray replaceObjectAtIndex:index withObject:tempDic];
    [self.searchView.searchTableView reloadData];
}



//all
- (void)searchSource{
    
    NSString *user_id  = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:UserID]];
    NSDictionary *data;
    if (![user_id isNull]) {
        data   = @{@"confirmStatus":@"",
                   @"oid":self.searchView.orderIDTextField.text,
                   @"createDateStart":self.searchView.leftDateTextField.text,
                   @"createDateEnd":self.searchView.rightDateTextfield.text,
                   @"orderPrices":self.searchView.moneyTextField.text,
                   @"shopId":user_id};
    }else{
        data   = @{@"confirmStatus":@"",
                   @"oid":self.searchView.orderIDTextField.text,
                   @"createDateStart":self.searchView.leftDateTextField.text,
                   @"createDateEnd":self.searchView.rightDateTextfield.text,
                   @"orderPrices":self.searchView.moneyTextField.text};
    }
    
    //NSLog(@"data --- %@",data);
    //self.searchView.orderIDTextField.text = @"";
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/activityorder/listBy",API];
    //NSLog(@"search --- %@",pradic);
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        NSLog(@"search list --- %@",object);
        NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
        if ([status isEqualToString:@"1000"]) {
            searchArray =  [NSMutableArray arrayWithArray:object[@"data"]];
            if (searchArray.count==0) {
                [ProgressHUD_Manager showTo:self.view tipText:@"没有搜到内容哦～"];
            }
            [self.searchView.searchTableView reloadData];
        }else{
            [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
        }
        [self viewTapGRAction:nil];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
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
                [self.searchView.successfulPopView setTip:[UIImage imageNamed:@"successful_image"] tipText:@"确认成功"];
                [self startPOP];
            }else{
                [self.searchView.successfulPopView setTip:[UIImage imageNamed:@"wuxiao_iamge"] tipText:@"确认无效"];
                [self startPOP];
            }
        }else{
            if ([confirmVal isEqualToString:@"1"]) {
                //fail
                [self.searchView.failedPopView setTip:[UIImage imageNamed:@"failed_image"]
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
    [[UIApplication sharedApplication].keyWindow addSubview:self.searchView.successfulPopView];
    [UIView animateWithDuration:0.18 animations:^{
        self.searchView.successfulPopView.alpha = 0.8;
    }];
    self.mytimer = [NSTimer scheduledTimerWithTimeInterval:1.18 target:self selector:@selector(popCancelAction) userInfo:nil repeats:YES];
}


//failed
- (void)failPop{
    //bug
    [_mytimer invalidate];
    _mytimer  = nil;
    [[UIApplication sharedApplication].keyWindow addSubview:self.searchView.failedPopView];
    [UIView animateWithDuration:0.18 animations:^{
        self.searchView.failedPopView.alpha = 0.8;
    }];
    self.mytimer = [NSTimer scheduledTimerWithTimeInterval:1.18 target:self selector:@selector(popCancelAction) userInfo:nil repeats:YES];
}

- (void)popCancelAction{
    [UIView animateWithDuration:0.18 animations:^{
        //successful
        self.searchView.successfulPopView.alpha = 0;
        //fail
        self.searchView.failedPopView.alpha = 0;
    } completion:^(BOOL finished) {
        //successful
        [self.searchView.successfulPopView removeFromSuperview];
        //fail
        [self.searchView.failedPopView removeFromSuperview];
        [_mytimer invalidate];
        _mytimer  = nil;
    }];
}




#pragma mark - 标准时间格式
- (NSString *)changeFormat:(NSDate *)timeData {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [formatter stringFromDate: timeData];
    return currentDateStr;
}

//NSDate转时间戳
- (NSString *)timestamp:(NSDate *)timeData{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[timeData timeIntervalSince1970]];
    return timeSp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
