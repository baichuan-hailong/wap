//
//  MJUpgradeMerchantViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJUpgradeMerchantViewController.h"
#import "MJUpgradeMerchantView.h"
#import "MJSelectTableViewCell.h"
#import "MJSelect_footer_tableView.h"

#import "MJUpWaitingViewController.h"
@interface MJUpgradeMerchantViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    NSArray  *selectArray;
    NSString *maskID;
    BOOL isHaveSelectImageBool;
}
@property(nonatomic,strong)MJUpgradeMerchantView *upgradeMerchantView;
@property(nonatomic,strong)UIAlertController     *camerAlertController;
@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation MJUpgradeMerchantViewController

- (void)loadView{
    self.upgradeMerchantView = [[MJUpgradeMerchantView alloc] initWithFrame:SCREEN_BOUNDS];
    self.upgradeMerchantView.selectTableView.delegate = self;
    self.upgradeMerchantView.selectTableView.dataSource=self;
    self.upgradeMerchantView.up_scrollView.delegate = self;
    self.view = self.upgradeMerchantView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"填写商家信息";
    
    [self addActon];
    
    /*
     securityKey = UEyWfcTtWnI;
     securityKey = UEyWfcTtWnI;
     securityKey = UEyWfcTtWnI;
     */
   
    isHaveSelectImageBool = NO;
    self.upgradeMerchantView.accountTextField.text =  [[NSUserDefaults standardUserDefaults] stringForKey:LoginTel];
    if ([self.promoterId integerValue]!=0) {
        self.upgradeMerchantView.inviteCoderTextField.text = self.promoterId;
        self.upgradeMerchantView.inviteCoderTextField.userInteractionEnabled = NO;
    }
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commitSuccessful) name:@"commitSuccessful" object:nil];
    
    [self maskList];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self hidTa];
}

- (void)commitSuccessful{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)maskList{
    NSString *testurl = [NSString stringWithFormat:@"%@/market/listBy",API];
    NSDictionary *data = @{};
    NSDictionary *pradic = [data signWithSecurityKey];
    NSLog(@"listby --- %@",pradic);
    [[MJNetManger shareManager] requestWithType:HttpRequestTypeGet withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        [self.hud hideAnimated:YES];
        NSLog(@"%@",object);
        NSString *status = [NSString stringWithFormat:@"%@",object[@"status"]];
        if ([status isEqualToString:@"1000"]) {
            selectArray = [NSArray arrayWithArray:object[@"data"]];
            [self.upgradeMerchantView.selectTableView reloadData];
        }else{
            [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"m"]]];
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.hud hideAnimated:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}



- (void)addActon{
    [self.upgradeMerchantView.commitBtn addTarget:self action:@selector(commitBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.upgradeMerchantView.selectMaskBtn addTarget:self action:@selector(selectMaskBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction:)];
    [self.upgradeMerchantView addGestureRecognizer:tapGR];
    UITapGestureRecognizer *tapQulityGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(evokeCamerAction:)];
    [self.upgradeMerchantView.qualiView addGestureRecognizer:tapQulityGR];
    
    self.upgradeMerchantView.shopTextField.delegate          = self;
    self.upgradeMerchantView.boothTextField.delegate         = self;
    self.upgradeMerchantView.connectPersonTextField.delegate = self;
    self.upgradeMerchantView.connectTelTextField.delegate    = self;
    self.upgradeMerchantView.inviteCoderTextField.delegate   = self;
    
     self.upgradeMerchantView.markTextField.delegate   = self;
    
    
    /************change up***********/
    //店铺名
    NSString *clientName_up = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"clientName_up"]];
    if (![clientName_up isNull]) {
        self.upgradeMerchantView.shopTextField.text = clientName_up;
    }
    
    //市场
    NSString *marketName_up = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"marketName_up"]];
    NSString *marketId_up = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"marketId_up"]];
    if (![marketName_up isNull]) {
        self.upgradeMerchantView.markTextField.text = marketName_up;
    }
    if (![marketId_up isNull]) {
        maskID = marketId_up;
    }
    //摊位号
    NSString *sellerStallInfo_up = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sellerStallInfo_up"]];
    if (![sellerStallInfo_up isNull]) {
        self.upgradeMerchantView.boothTextField.text = sellerStallInfo_up;
    }
    
    
    //联系人
    NSString *linkman_up = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"linkman_up"]];
    if (![linkman_up isNull]) {
        self.upgradeMerchantView.connectPersonTextField.text = linkman_up;
    }
    //联系电话
    NSString *telephone_up = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"telephone_up"]];
    if (![telephone_up isNull]) {
        self.upgradeMerchantView.connectTelTextField.text = telephone_up;
    }
    //邀请码
    NSString *inviteCoder_up = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"inviteCoder_up"]];
    if (![inviteCoder_up isNull]) {
        self.upgradeMerchantView.inviteCoderTextField.text = inviteCoder_up;
    }
}

- (void)tapGRAction:(UITapGestureRecognizer *)sender{
    //NSLog(@"tap");
    [self.view endEditing:YES];
    [self hidTa];
}

- (void)goBackAction{
    if (_isUpWaiting) {
        [self.navigationController popViewControllerAnimated:NO];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - TF Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"should begin");
    if (textField.tag==8080) {
        [self.view endEditing:YES];
        [self showTa];
        return NO;
    }else{
        [self hidTa];
        return YES;
    }
}


#pragma mark - 选择市场
- (void)selectMaskBtnDidClick:(UIButton *)sender{
    [self.view endEditing:YES];
    [self showTa];
}

#pragma mark - 提交
- (void)commitBtnDidClick:(UIButton *)sender{
    //NSLog(@"commit");
    [self.view endEditing:YES];
    //isHaveSelectImageBool
    if (![self.upgradeMerchantView.accountTextField.text isNull]&&
        ![self.upgradeMerchantView.shopTextField.text isNull]&&
        ![self.upgradeMerchantView.markTextField.text isNull]&&
        ![self.upgradeMerchantView.boothTextField.text isNull]&&
        ![self.upgradeMerchantView.connectPersonTextField.text isNull]&&
        ![self.upgradeMerchantView.connectTelTextField.text isNull]&&
        ![self.upgradeMerchantView.inviteCoderTextField.text isNull]&&![self.upgradeMerchantView.inviteCoderTextField.text isEqualToString:@"0"]) {
        [self prefectSeller];
    }else{
        [ProgressHUD_Manager showTo:self.view tipText:@"请填写完整资料信息"];
    }
}

- (void)prefectSeller{
    [self showProgress];
    //压缩
    //NSData *imageData = UIImageJPEGRepresentation(self.upgradeMerchantView.qualiImageView.image, 0.5);
    //@"baseFile":[imageData base64EncodedStringWithOptions:0]
    NSDictionary *data = @{@"clientId":[[NSUserDefaults standardUserDefaults] stringForKey:UserID],
                           @"marketId":maskID,
                           @"clientName":self.upgradeMerchantView.shopTextField.text,
                           @"linkman":self.upgradeMerchantView.connectPersonTextField.text,
                           @"telephone":self.upgradeMerchantView.connectTelTextField.text,
                           @"sellerStallInfo":self.upgradeMerchantView.boothTextField.text,
                           @"promoterId":self.upgradeMerchantView.inviteCoderTextField.text};
    
    //店铺名
    [[NSUserDefaults standardUserDefaults] setObject:self.upgradeMerchantView.shopTextField.text forKey:@"clientName_up"];
    //市场
    [[NSUserDefaults standardUserDefaults] setObject:self.upgradeMerchantView.markTextField.text forKey:@"marketName_up"];
    [[NSUserDefaults standardUserDefaults] setObject:maskID forKey:@"marketId_up"];
    //摊位号
    [[NSUserDefaults standardUserDefaults] setObject:self.upgradeMerchantView.boothTextField.text forKey:@"sellerStallInfo_up"];
    //联系人
    [[NSUserDefaults standardUserDefaults] setObject:self.upgradeMerchantView.connectPersonTextField.text forKey:@"linkman_up"];
    //联系电话
    [[NSUserDefaults standardUserDefaults] setObject:self.upgradeMerchantView.connectTelTextField.text forKey:@"telephone_up"];
    //邀请码
    [[NSUserDefaults standardUserDefaults] setObject:self.upgradeMerchantView.inviteCoderTextField.text forKey:@"inviteCoder_up"];
    
    
    NSDictionary *pradic = [data signWithSecurityKey];
    NSString *testurl    = [NSString stringWithFormat:@"%@/client/doUpSellerBase64",API];
    [[MJNetManger shareManager] requestWithType:HttpRequestTypePost withUrlString:testurl withParaments:pradic withSuccessBlock:^(NSDictionary *object) {
        [self.hud hideAnimated:YES];
        NSLog(@"perfect 商家 --- %@",object);
        NSString *s = [NSString stringWithFormat:@"%@",object[@"s"]];
        if ([s isEqualToString:@"1"]) {
            //本地存储
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_LOGIN];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_HaveUPCommit];
            
            if (_isUpWaiting) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"upCommitSuccessful" object:nil userInfo:nil];
                [self.navigationController popViewControllerAnimated:NO];
            }else{
                //等待审核页
                MJUpWaitingViewController *upWairing = [[MJUpWaitingViewController alloc] init];
                upWairing.isSuccessful = YES;
                UINavigationController *upWaitingNV = [[UINavigationController alloc] initWithRootViewController:upWairing];
                [self presentViewController:upWaitingNV animated:NO completion:nil];
            }
            
        }else{
            [ProgressHUD_Manager showTo:self.view tipText:[NSString stringWithFormat:@"%@",object[@"message"]]];
        }
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.hud hideAnimated:YES];
    } progress:^(float progress) {
        NSLog(@"%f",progress);
    }];
}


#pragma mark - Evoke Camer
- (void)evokeCamerAction:(UITapGestureRecognizer *)sender{
    NSLog(@"evoke");    
    [self.upgradeMerchantView.camerAlertView.photoBtn addTarget:self action:@selector(evokeImage) forControlEvents:UIControlEventTouchUpInside];
    [self.upgradeMerchantView.camerAlertView.camerBtn addTarget:self action:@selector(evokeCamer) forControlEvents:UIControlEventTouchUpInside];
    [self.upgradeMerchantView.camerAlertView.cancleBtn addTarget:self action:@selector(cancleAc) forControlEvents:UIControlEventTouchUpInside];
    [self.upgradeMerchantView.camerAlertView show];
    [UIView animateWithDuration:0.28 animations:^{
        self.upgradeMerchantView.camerAlertView.alpha =0.5;
        self.upgradeMerchantView.camerAlertView.camerView.frame = CGRectMake(0, SCREEN_HEIGHT-em*555, SCREEN_WIDTH, em*555);
    }];
}

- (void)cancleAc{
    [self.upgradeMerchantView.camerAlertView hide];
}

- (void)evokeCamer{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
        imagePickerVC.delegate = self;
        imagePickerVC.allowsEditing = YES;
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerVC animated:YES completion:^{
            [self.upgradeMerchantView.camerAlertView hide];
        }];
    }
}

- (void)evokeImage{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
        [imagePickerVC.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:primaryColor]] forBarMetrics:(UIBarMetricsDefault)];
        [imagePickerVC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        [imagePickerVC setModalPresentationStyle:UIModalPresentationFullScreen];
        imagePickerVC.delegate = self;
        imagePickerVC.allowsEditing = YES;
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:^{
            [self.upgradeMerchantView.camerAlertView hide];
        }];
    }
}

#pragma mark - 图片处理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *qualiImage = [info objectForKey:UIImagePickerControllerEditedImage];
    isHaveSelectImageBool = YES;
    self.upgradeMerchantView.qualiImageView.image = qualiImage;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return selectArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID     = @"selectCell";
    NSDictionary *selectDic = selectArray[indexPath.section];
    MJSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MJSelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    };
    [cell setSelect:selectDic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return em*150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    MJSelect_footer_tableView *foot = [[MJSelect_footer_tableView alloc] init];
    return foot;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self hidTa];
    NSDictionary *selectDic = selectArray[indexPath.section];
    if (selectDic!=nil) {
        self.upgradeMerchantView.markTextField.text = [NSString stringWithFormat:@"%@",selectDic[@"marketName"]];
        maskID = [NSString stringWithFormat:@"%@",selectDic[@"oid"]];
    }
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    if (scrollView.tag==1000) {
        [self hidTa];
    }
}

- (void)showTa{
    [UIView animateWithDuration:0.18 animations:^{
        //self.upgradeMerchantView.selectTableView.alpha = 1;
        self.upgradeMerchantView.select_iew.alpha      = 1;
        [[UIApplication sharedApplication].keyWindow addSubview:self.upgradeMerchantView.select_iew];
    }];
}

- (void)hidTa{
    [UIView animateWithDuration:0.18 animations:^{
        //self.upgradeMerchantView.selectTableView.alpha = 0;
        self.upgradeMerchantView.select_iew.alpha = 0;
        [self.upgradeMerchantView.select_iew removeFromSuperview];
    }];
}

- (void)showProgress{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    self.hud.bezelView.color           = [UIColor whiteColor];
    self.hud.margin         = 0.f;
    [self.view addSubview:self.hud];
    [self.hud showAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
