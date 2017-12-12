//
//  MJPayView.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/27.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJPayView : UIView
@property(nonatomic,strong)UITextField *moneyTextField;

@property(nonatomic,strong)UIButton    *commitBtn;

//wechat
@property(nonatomic,strong)UIButton    *wechatBtn;

//ali
@property(nonatomic,strong)UIButton    *aliBtn;
@end
