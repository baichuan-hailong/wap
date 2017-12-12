//
//  ProgressHUD_Manager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/29.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;

@interface ProgressHUD_Manager : NSObject

//文本
+ (void)showTo:(UIView *)toView tipText:(NSString *)tipText;

//菊花
+ (void)shoeProgress:(UIView *)toView hud:(MBProgressHUD *)HUD;
+ (void)hideHud:(MBProgressHUD *)HUD;
@end
