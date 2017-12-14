//
//  GuidePageManager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/14.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "GuidePageManager.h"
@interface GuidePageManager()
@property(nonatomic, strong) MJGuidePage *guidePage;
@end

@implementation GuidePageManager

+ (instancetype)defaultManage{
    static GuidePageManager *gp_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gp_manager = [[GuidePageManager alloc] init];
    });
    return gp_manager;
}

- (void)checkGuidPage{
    //login
    if (![[NSUserDefaults standardUserDefaults] boolForKey:IS_LOGIN]) {
        MJLoginViewController *loginVC = [[MJLoginViewController alloc] init];
        UINavigationController *logNC  = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:logNC animated:NO completion:nil];
    }else{
        //check login up
        [MJUpdateUserInfo updateInfo];
    }
    
    //page
    if (![[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@%@",IS_First,VERSION_MJ]]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[NSString stringWithFormat:@"%@%@",IS_First,VERSION_MJ]];
        //self.guidePage = [[MJGuidePage alloc] initWithFrame:SCREEN_BOUNDS];
        [self.guidePage.startBtn addTarget:self
                                    action:@selector(startBtnClicked:)
                          forControlEvents:UIControlEventTouchUpInside];
        //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[UIApplication sharedApplication].keyWindow addSubview:self.guidePage];
    }
}

- (void)startBtnClicked:(UIButton *)sender{
    NSLog(@"click");
    [UIView animateWithDuration:0.18 animations:^{
        self.guidePage.alpha = 0;
    } completion:^(BOOL finished) {
        [self.guidePage removeFromSuperview];
    }];
}

//lazy
- (MJGuidePage *)guidePage{
    if (_guidePage==nil) {
        _guidePage = [[MJGuidePage alloc] initWithFrame:SCREEN_BOUNDS];
    }
    return _guidePage;
}
@end
