//
//  MJMyselfHeaderView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMyselfHeaderView.h"

@interface MJMyselfHeaderView()
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *lowView;

//可用余额
@property(nonatomic,strong)UILabel *availableTipLabel;
@property(nonatomic,strong)UILabel *availableLabel;

//账户余额
@property(nonatomic,strong)UILabel *AccountTipLabel;
@property(nonatomic,strong)UILabel *AccountLabel;

//信用余额
@property(nonatomic,strong)UILabel *CreditTipLabel;
@property(nonatomic,strong)UILabel *CreditLabel;


@property(nonatomic,strong)UILabel *availableCircleLabel;
@property(nonatomic,strong)UILabel *AccountCircleLabel;
@property(nonatomic,strong)UILabel *CreditCircleLabel;
@property(nonatomic,strong)UILabel      *equalTipLabel;
@property(nonatomic,strong)UILabel      *addTipLabel;

//余额不足
@property(nonatomic,strong)UIView       *yueTipView;
@property(nonatomic,strong)UIImageView  *yueTipImageView;
@property(nonatomic,strong)UILabel      *yueTipLabel;

@end




@implementation MJMyselfHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:248/255.0 alpha:1];
    
    //可用余额
    [MJLabelManager setLabel:self.availableTipLabel
                        text:@"可用余额（元）"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*38]];
    [self.topView addSubview:self.availableTipLabel];
    
    [MJLabelManager setLabel:self.availableLabel
                        text:@"--"
                           r:44
                           g:44
                           b:54
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*100]];
    [self.topView addSubview:self.availableLabel];
    
    //账户余额
    [MJLabelManager setLabel:self.AccountTipLabel
                        text:@"账户余额："
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*38]];
    [self.topView addSubview:self.AccountTipLabel];
    
    [MJLabelManager setLabel:self.AccountLabel
                        text:@"--"
                           r:248
                           g:63
                           b:63
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*40]];
    //self.AccountLabel.backgroundColor = [UIColor redColor];
    [self.topView addSubview:self.AccountLabel];
    
    //信用余额
    [MJLabelManager setLabel:self.CreditTipLabel
                        text:@"信用余额："
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*38]];
    [self.topView addSubview:self.CreditTipLabel];
    
    [MJLabelManager setLabel:self.CreditLabel
                        text:@"--"
                           r:248
                           g:63
                           b:63
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*40]];
    [self.topView addSubview:self.CreditLabel];
    
    
    
    [MJBtnManager setButton:self.rechargeBtn
                      title:@"充值"
                  textColor:[UIColor colorWithRed:238/255.0 green:23/255.0 blue:23/255.0 alpha:1]
                       font:[UIFont systemFontOfSize:em*36]
                borderColor:[UIColor colorWithRed:238/255.0 green:23/255.0 blue:23/255.0 alpha:1] borderWidth:1 radius:4];
    //self.rechargeBtn.backgroundColor = [UIColor lightGrayColor];
    [self.topView addSubview:self.rechargeBtn];
    
    [self addSubview:self.topView];
    [self addSubview:self.lowView];
    
    
    self.availableCircleLabel.numberOfLines = 0;
    [MJLabelManager setLabel:self.availableCircleLabel
                        text:@"可用\n余额"
                   textColor:[UIColor colorWithRed:249/255.0 green:41/255.0 blue:41/255.0 alpha:1]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*32]
                 borderColor:[UIColor colorWithRed:254/255.0 green:232/255.0 blue:232/255.0 alpha:1]
                 borderWidth:1 radius:em*95];
    [self.lowView addSubview:self.availableCircleLabel];
    
    self.AccountCircleLabel.numberOfLines = 0;
    [MJLabelManager setLabel:self.AccountCircleLabel
                        text:@"账户\n余额"
                   textColor:[UIColor colorWithRed:249/255.0 green:41/255.0 blue:41/255.0 alpha:1]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*32]
                 borderColor:[UIColor colorWithRed:254/255.0 green:232/255.0 blue:232/255.0 alpha:1]
                 borderWidth:1 radius:em*95];
    [self.lowView addSubview:self.AccountCircleLabel];
    
    self.CreditCircleLabel.numberOfLines = 0;
    [MJLabelManager setLabel:self.CreditCircleLabel
                        text:@"信用\n余额"
                   textColor:[UIColor colorWithRed:249/255.0 green:41/255.0 blue:41/255.0 alpha:1]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*32]
                 borderColor:[UIColor colorWithRed:254/255.0 green:232/255.0 blue:232/255.0 alpha:1]
                 borderWidth:1 radius:em*95];
    [self.lowView addSubview:self.CreditCircleLabel];
    
    //=
    [MJLabelManager setLabel:self.equalTipLabel
                        text:@"="
                           r:252
                           g:50
                           b:50
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*30]];
    [self.lowView addSubview:self.equalTipLabel];
    //+
    [MJLabelManager setLabel:self.addTipLabel
                        text:@"+"
                           r:252
                           g:50
                           b:50
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*30]];
    [self.lowView addSubview:self.addTipLabel];
    
    
    //余额不足
    [self.lowView addSubview:self.yueTipView];
    [self.yueTipView addSubview:self.yueTipImageView];
    
    [MJLabelManager setLabel:self.yueTipLabel
                        text:@"可用余额不足时，将无法交易，请注意及时充值。"
                           r:255
                           g:137
                           b:137
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*32]];
    [self.yueTipView addSubview:self.yueTipLabel];
}

- (void)setMoney:(NSDictionary *)userInfoDic{
    if (userInfoDic!=nil) {
        //账户余额
        NSString *cashMoney = [NSString stringWithFormat:@"%@",userInfoDic[@"cashMoney"]];
        //信用余额
        NSString *creditMoneyCanUse = [NSString stringWithFormat:@"%@",userInfoDic[@"creditMoneyCanUse"]];
        //信用已用余额
        NSString *creditMoneyUsed = [NSString stringWithFormat:@"%@",userInfoDic[@"creditMoneyUsed"]];
        //可用余额
        NSString *totalCanUse    = [NSString stringWithFormat:@"%.2f",[cashMoney floatValue]+[creditMoneyCanUse floatValue]];
        self.availableLabel.text = [NSString stringWithFormat:@"%.2f",[totalCanUse floatValue]];
        self.AccountLabel.text   = [NSString stringWithFormat:@"%.2f",[cashMoney floatValue]];
        if ([creditMoneyUsed floatValue]>0) {
            self.CreditLabel.text    = [NSString stringWithFormat:@"%.2f（服务欠费%.2f）",[creditMoneyCanUse floatValue],[creditMoneyUsed floatValue]];
        }else{
            self.CreditLabel.text    = [NSString stringWithFormat:@"%.2f",[creditMoneyCanUse floatValue]];
        }
    }
}

- (UIView *)topView{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, em*424)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UIButton *)rechargeBtn{
    if (_rechargeBtn==nil) {
        _rechargeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*32-em*158, em*83, em*158, em*70)];
    }
    return _rechargeBtn;
}

//可用余额
- (UILabel *)availableTipLabel{
    if (_availableTipLabel==nil) {
        _availableTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, em*80, em*600, em*40)];
    }
    return _availableTipLabel;
}

- (UILabel *)availableLabel{
    if (_availableLabel==nil) {
        _availableLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, em*150, em*800, em*80)];
    }
    return _availableLabel;
}

//账户余额
- (UILabel *)AccountTipLabel{
    if (_AccountTipLabel==nil) {
        _AccountTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, em*305, em*195, em*40)];
    }
    return _AccountTipLabel;
}

- (UILabel *)AccountLabel{
    if (_AccountLabel==nil) {
        _AccountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AccountTipLabel.frame), em*305, em*180, em*40)];
    }
    return _AccountLabel;
}

//信用余额
- (UILabel *)CreditTipLabel{
    if (_CreditTipLabel==nil) {
        _CreditTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*450, em*305, em*195, em*40)];
    }
    return _CreditTipLabel;
}

- (UILabel *)CreditLabel{
    if (_CreditLabel==nil) {
        _CreditLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.CreditTipLabel.frame), em*305, em*480, em*40)];
    }
    return _CreditLabel;
}


- (UIView *)lowView{
    if (_lowView==nil) {
        _lowView = [[UIView alloc] initWithFrame:CGRectMake(0, em*424+em*30, SCREEN_WIDTH, em*420)];
        _lowView.backgroundColor = [UIColor whiteColor];
    }
    return _lowView;
}

//余额不足
- (UIView *)yueTipView{
    if (_yueTipView==nil) {
        _yueTipView = [[UIView alloc] initWithFrame:CGRectMake(0, em*296, SCREEN_WIDTH, em*124)];
        _yueTipView.backgroundColor = [UIColor colorWithRed:255/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    }
    return _yueTipView;
}

- (UIImageView *)yueTipImageView{
    if (_yueTipImageView==nil) {
        _yueTipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*248, em*41, em*42, em*42)];
        _yueTipImageView.image = [UIImage imageNamed:@"avalible_myself"];
    }
    return _yueTipImageView;
}

- (UILabel *)yueTipLabel{
    if (_yueTipLabel==nil) {
        _yueTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.yueTipImageView.frame)+em*20, em*41, em*900, em*42)];
    }
    return _yueTipLabel;
}

- (UILabel *)availableCircleLabel{
    if (_availableCircleLabel==nil) {
        _availableCircleLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*226, em*52, em*190, em*190)];
    }
    return _availableCircleLabel;
}

- (UILabel *)AccountCircleLabel{
    if (_AccountCircleLabel==nil) {
        _AccountCircleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*190)/2, em*52, em*190, em*190)];
    }
    return _AccountCircleLabel;
}

- (UILabel *)CreditCircleLabel{
    if (_CreditCircleLabel==nil) {
        _CreditCircleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*226-em*190, em*52, em*190, em*190)];
    }
    return _CreditCircleLabel;
}


- (UILabel *)addTipLabel{
    if (_addTipLabel==nil) {
        _addTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.AccountCircleLabel.frame)+em*45, em*52+em*(190-22)/2, em*22, em*22)];
    }
    return _addTipLabel;
}

- (UILabel *)equalTipLabel{
    if (_equalTipLabel==nil) {
        _equalTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.AccountCircleLabel.frame)-em*45-em*22, em*52+em*(190-22)/2, em*22, em*22)];
    }
    return _equalTipLabel;
}

@end
