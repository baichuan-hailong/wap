//
//  MJUpgradeMerchantViewController.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJBaseViewController.h"

@interface MJUpgradeMerchantViewController : MJBaseViewController
//入口
@property(nonatomic, assign)BOOL isUpWaiting;

@property(nonatomic,copy)NSString *login_tel;    //账号
@property(nonatomic,copy)NSString *oid;          //商家ID
@property(nonatomic,copy)NSString *promoterId;   //邀请码


@end
