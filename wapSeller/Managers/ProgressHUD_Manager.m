//
//  ProgressHUD_Manager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/29.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "ProgressHUD_Manager.h"

@implementation ProgressHUD_Manager

+ (void)showTo:(UIView *)toView tipText:(NSString *)tipText{
    MBProgressHUD *hud            = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.bezelView.color           = [UIColor colorWithRed:51/225.0 green:51/225.0 blue:51/225.0 alpha:1];//这里改成其他颜色都可以正常显示，如果改变透明度则没有效果
    hud.mode                      = MBProgressHUDModeText;
    hud.margin                    = 5.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.label.font = [UIFont systemFontOfSize:em*50];
    hud.label.text                = tipText;
    hud.label.textColor           = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:1];
}


//菊花
+ (void)shoeProgress:(UIView *)toView hud:(MBProgressHUD *)HUD{
    HUD = [[MBProgressHUD alloc] initWithView:toView];
    HUD.bezelView.color           = [UIColor whiteColor];
    HUD.margin         = 0.f;
    [toView addSubview:HUD];
    [HUD showAnimated:YES];
}

+ (void)hideHud:(MBProgressHUD *)HUD{
    [HUD hideAnimated:YES];
}

@end
