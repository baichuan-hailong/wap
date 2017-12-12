//
//  MJUpgradeMerchantView.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJCamerAlertView.h"

@interface MJUpgradeMerchantView : UIView
@property(nonatomic, strong)UIScrollView *up_scrollView;

@property(nonatomic,strong)UIView      *select_iew;
@property(nonatomic,strong)UITableView *selectTableView;

@property(nonatomic,strong)UIButton *commitBtn;

//账号
@property(nonatomic, strong)UITextField   *accountTextField;

//店铺名
@property(nonatomic, strong)UITextField   *shopTextField;

//所在市场
@property(nonatomic,strong)UIButton      *selectMaskBtn;
@property(nonatomic, strong)UITextField  *markTextField;

//摊位号
@property(nonatomic, strong)UITextField   *boothTextField;

//联系人
@property(nonatomic, strong)UITextField   *connectPersonTextField;

//联系电话
@property(nonatomic, strong)UITextField   *connectTelTextField;

//资质照片
@property(nonatomic,strong)UIView      *qualiView;
@property(nonatomic,strong)UIImageView *qualiImageView;

//邀请码
@property(nonatomic, strong)UITextField   *inviteCoderTextField;


@property(nonatomic, strong)MJCamerAlertView *camerAlertView;

@end
