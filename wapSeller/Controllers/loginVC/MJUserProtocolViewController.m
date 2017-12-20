//
//  MJUserProtocolViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/20.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJUserProtocolViewController.h"

@interface MJUserProtocolViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView     *webView;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation MJUserProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户使用协议";
    
    [self.view addSubview:self.webView];
}

#pragma mark - webViewDelegate
//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showProgress];
    
}

//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.hud hideAnimated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.hud hideAnimated:YES];
}



- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0,
                                    0,
                                    SCREEN_WIDTH,
                                    SCREEN_HEIGHT-64);
        if (iPhoneX) {
            _webView.frame = CGRectMake(0,
                                        0,
                                        SCREEN_WIDTH,
                                        SCREEN_HEIGHT-64-24);
        }
        _webView.delegate = self;
        
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
        //NSLog(@"%f",interval);
        NSString *url = [NSString stringWithFormat:@"%@/page/agreement.html?_t=%.0f",API_xieyi,interval];
        //NSLog(@"%@",url);
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_webView loadRequest:request];
    }
    return _webView;
}

- (void)showProgress{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    self.hud.removeFromSuperViewOnHide = YES;
    self.hud.bezelView.color           = [UIColor whiteColor];
    self.hud.margin         = 0.f;
    [self.view addSubview:self.hud];
    [self.hud showAnimated:YES];
}

- (void)goBackAction{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
