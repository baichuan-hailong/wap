//
//  MJBaseViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJBaseViewController.h"



@interface MJBaseViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textV;
@end

@implementation MJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:primaryColor]] forBarMetrics:(UIBarMetricsDefault)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setNavLeftButton];
    [self addAction];
    

    self.textV = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 300, 200)];
    self.textV.alpha = 0.0;
    self.textV.delegate = self;
    self.textV.backgroundColor = [UIColor redColor];
    //[self.textV becomeFirstResponder];
    //[self.view addSubview:self.textV];
    
    
    // 1.添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willshow) name:UIKeyboardWillShowNotification object:nil];
    // 键盘将要出现 UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShow) name:UIKeyboardDidShowNotification object:nil];
    // 键盘已经出现 UIKeyboardDidShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHide) name:UIKeyboardWillHideNotification object:nil];
    // 键盘将要隐藏 UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHide) name:UIKeyboardDidHideNotification object:nil];
    // 键盘已经隐藏 UIKeyboardDidHideNotification
    
}


- (void)key:(NSNotification *)noti{
    NSLog(@"key");
    //NSLog(@"%@",[noti object]);
}


- (void)languageChanged:(NSNotification*)notification{
    NSLog(@"Current: %@", [UIApplication sharedApplication].delegate.window.textInputMode.primaryLanguage);
    //    for(UITextInputMode *mode in [UITextInputMode activeInputModes])
    //    {
    //        NSLog(@"Input mode: %@", mode);
    //        NSLog(@"Input language: %@", mode.primaryLanguage);
    //    }
    //    NSLog(@"Notification: %@", notification);
    //    UITextInputMode *current = [UITextInputMode currentInputMode];
    //    NSLog(@"Current: %@", current.primaryLanguage);
}




- (void)willshow{
    //NSLog(@"will show");
}

- (void)didShow{
    //NSLog(@"did show");
}

- (void)willHide{
    //NSLog(@"will Hide");
}

- (void)didHide{
    //NSLog(@"did Hide");
}



#pragma mark - TextView
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //NSLog(@"begin");
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //NSLog(@"end");
}



- (void)isPatchAC:(NSNotification *)noti{
    //NSLog(@"%@", noti);
}

// 2. 键盘已经出现调用的触发方法
- (void)keyBoardChange:(NSNotification *)noti{
    //NSLog(@"%@", noti);
    // 打印noti
    /*
     0x7f84584d1000 {name = UIKeyboardDidShowNotification; userInfo = {
     // 键盘动画执行节奏
     UIKeyboardAnimationCurveUserInfoKey = 7;
     
     // 键盘动画的时间
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     
     // 键盘的bounds
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
     
     // 键盘的起始center
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
     
     // 键盘的结束center
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
     
     // 键盘开始动画前的位置（也就是消失时）
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
     
     // 键盘结束动画后的位置（也就是弹出了）
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
     
     UIKeyboardIsLocalUserInfoKey = 1;
     }}
     */
    
}



- (void)setNavLeftButton {
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame           =CGRectMake(0, 0, 64, 64);
    button.imageEdgeInsets = UIEdgeInsetsMake(0,-40, 0, 10);
    //button.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=item;
}


- (void)goBackAction {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)hideBack{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=item;
}

- (void)addAction{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
  empty
*/
- (MJEmptyView *)emptyView{
    if (_emptyView==nil) {
        _emptyView = [[MJEmptyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49-50)];
    }
    return _emptyView;
}

- (MJEmptyView *)emptyView_o{
    if (_emptyView_o==nil) {
        _emptyView_o = [[MJEmptyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49-50)];
    }
    return _emptyView_o;
}

- (MJEmptyView *)emptyView_t{
    if (_emptyView_t==nil) {
        _emptyView_t = [[MJEmptyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49-50)];
    }
    return _emptyView_t;
}

@end
