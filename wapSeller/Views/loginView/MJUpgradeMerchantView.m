//
//  MJUpgradeMerchantView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJUpgradeMerchantView.h"

@interface MJUpgradeMerchantView()

@property(nonatomic, strong)UIView       *topView;

//账号
@property(nonatomic, strong)UILabel       *accountLabel;
@property(nonatomic, strong)UIView        *account_line;

//店铺名
@property(nonatomic, strong)UILabel       *shopLabel;
@property(nonatomic, strong)UIView        *shop_line;

//所在市场
@property(nonatomic, strong)UILabel       *marketLabel;
@property(nonatomic, strong)UIView        *market_line;


//摊位号
@property(nonatomic, strong)UILabel       *boothLabel;
@property(nonatomic, strong)UIView        *booth_line;

//联系人
@property(nonatomic, strong)UILabel       *connectPersonLabel;
@property(nonatomic, strong)UIView        *connectPerson_line;

//联系电话
@property(nonatomic, strong)UILabel       *connectTelLabel;
@property(nonatomic, strong)UIView        *connectTel_line;

//资质照片
@property(nonatomic, strong)UILabel       *qualificationLabel;
@property(nonatomic, strong)UIView        *qualificationBackView;
@property(nonatomic, strong)UIView        *qualification_line;

//邀请码
@property(nonatomic, strong)UILabel       *inviteCoderLabel;
@property(nonatomic, strong)UIView        *inviteCoder_line;

@end


@implementation MJUpgradeMerchantView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    //self.up_scrollView.backgroundColor = [UIColor lightGrayColor];
    self.up_scrollView.tag = 1000;
    [self addSubview:self.up_scrollView];
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:248/255.0 alpha:1];
    [self.up_scrollView addSubview:self.topView];
    
    [MJBtnManager setButton:self.commitBtn
                       text:@"提交"
                  textColor:[UIColor whiteColor]
                       font:[UIFont systemFontOfSize:em*48]
                      image:[UIImage imageWithColor:[UIColor colorWithHex:primaryColor]]
                     radius:4];
    [self.up_scrollView addSubview:self.commitBtn];
    
    //账户
    [MJLabelManager setLabel:self.accountLabel
                        text:@"登录账号"
                           r:83
                           g:83
                           b:95
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*44]];
    //self.accountLabel.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.accountLabel];
    
    [MJTxFieldManager setTxfield:self.accountTextField
                       placeText:@"--"
                       textColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:149/255.0 alpha:1]
                            font:[UIFont systemFontOfSize:em*44]];
    self.accountTextField.textAlignment= NSTextAlignmentRight;
    self.accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.accountTextField.userInteractionEnabled = NO;
    //self.accountTextField.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.accountTextField];
    
    [self.up_scrollView addSubview:self.account_line];
    
    //店铺名
    [MJLabelManager setLabel:self.shopLabel
                        text:@"店铺名"
                           r:83
                           g:83
                           b:95
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*44]];
    //self.shopLabel.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.shopLabel];
    
    [MJTxFieldManager setTxfield:self.shopTextField
                       placeText:@"输入店铺名"
                       textColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:149/255.0 alpha:1]
                            font:[UIFont systemFontOfSize:em*44]];
    self.shopTextField.textAlignment= NSTextAlignmentRight;
    self.shopTextField.keyboardType = UIKeyboardTypeDefault;
    //self.shopTextField.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.shopTextField];
    
    [self.up_scrollView addSubview:self.shop_line];
    
    //所在市场
    [MJLabelManager setLabel:self.marketLabel
                        text:@"所在市场"
                           r:83
                           g:83
                           b:95
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*44]];
    //self.marketLabel.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.marketLabel];
    
    
    [MJTxFieldManager setTxfield:self.markTextField
                       placeText:@"请选择市场"
                       textColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:149/255.0 alpha:1]
                            font:[UIFont systemFontOfSize:em*44]];
    self.markTextField.textAlignment= NSTextAlignmentRight;
    //self.markTextField.keyboardType = UIKeyboardTypeNumberPad;
    //self.markTextField.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.markTextField];
    
    
    
    [self.up_scrollView addSubview:self.selectMaskBtn];
    
    [self.up_scrollView addSubview:self.market_line];
    
    //摊位号
    [MJLabelManager setLabel:self.boothLabel
                        text:@"摊位号"
                           r:83
                           g:83
                           b:95
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*44]];
    //self.boothLabel.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.boothLabel];
    
    [MJTxFieldManager setTxfield:self.boothTextField
                       placeText:@"输入摊位号"
                       textColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:149/255.0 alpha:1]
                            font:[UIFont systemFontOfSize:em*44]];
    self.boothTextField.textAlignment= NSTextAlignmentRight;
    self.boothTextField.keyboardType = UIKeyboardTypeDefault;
    //self.boothTextField.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.boothTextField];
    
    [self.up_scrollView addSubview:self.booth_line];
    
    //联系人
    [MJLabelManager setLabel:self.connectPersonLabel
                        text:@"联系人"
                           r:83
                           g:83
                           b:95
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*44]];
    //self.connectPersonLabel.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.connectPersonLabel];
    
    [MJTxFieldManager setTxfield:self.connectPersonTextField
                       placeText:@"输入联系人姓名"
                       textColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:149/255.0 alpha:1]
                            font:[UIFont systemFontOfSize:em*44]];
    self.connectPersonTextField.textAlignment= NSTextAlignmentRight;
    self.connectPersonTextField.keyboardType = UIKeyboardTypeDefault;
    //self.connectPersonTextField.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.connectPersonTextField];
    
    [self.up_scrollView addSubview:self.connectPerson_line];
    
    
    //联系电话
    [MJLabelManager setLabel:self.connectTelLabel
                        text:@"联系电话"
                           r:83
                           g:83
                           b:95
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*44]];
    //self.connectTelLabel.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.connectTelLabel];
    
    [MJTxFieldManager setTxfield:self.connectTelTextField
                       placeText:@"输入联系人电话"
                       textColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:149/255.0 alpha:1]
                            font:[UIFont systemFontOfSize:em*44]];
    self.connectTelTextField.textAlignment= NSTextAlignmentRight;
    self.connectTelTextField.keyboardType = UIKeyboardTypeNumberPad;
    //self.connectTelTextField.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.connectTelTextField];
    
    [self.up_scrollView addSubview:self.connectTel_line];
    
    //资质照片
    [MJLabelManager setLabel:self.qualificationLabel
                        text:@"资质照片"
                           r:83
                           g:83
                           b:95
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*44]];
    //self.qualificationLabel.backgroundColor = [UIColor yellowColor];
    //[self.up_scrollView addSubview:self.qualificationLabel];
    //[self.up_scrollView addSubview:self.qualificationBackView];
    //[self.qualificationBackView addSubview:self.qualiView];
    self.qualiImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.qualiImageView.layer.cornerRadius = 2;
    self.qualiImageView.layer.masksToBounds= YES;
    //[self.qualiView addSubview:self.qualiImageView];
    //[self.up_scrollView addSubview:self.qualification_line];
    
    //邀请码
    [MJLabelManager setLabel:self.inviteCoderLabel
                        text:@"邀请码"
                           r:83
                           g:83
                           b:95
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*44]];
    //self.inviteCoderLabel.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.inviteCoderLabel];
    
    [MJTxFieldManager setTxfield:self.inviteCoderTextField
                       placeText:@"输入邀请码"
                       textColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:149/255.0 alpha:1]
                            font:[UIFont systemFontOfSize:em*44]];
    self.inviteCoderTextField.textAlignment   = NSTextAlignmentRight;
    self.inviteCoderTextField.keyboardType    = UIKeyboardTypeNumberPad;
    //self.inviteCoderTextField.backgroundColor = [UIColor yellowColor];
    [self.up_scrollView addSubview:self.inviteCoderTextField];
    
    [self.up_scrollView addSubview:self.inviteCoder_line];
    
    
    self.selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.select_iew addSubview:self.selectTableView];
    
    //self.selectTableView.alpha           = 0;
    self.select_iew.alpha           = 0;
    self.select_iew.backgroundColor = [UIColor whiteColor];
    
    
    self.select_iew.layer.cornerRadius = 4;
    self.select_iew.layer.shadowOpacity = 0.60;// 阴影透明度
    self.select_iew.layer.shadowColor = [UIColor blackColor].CGColor;// 阴影的颜色
    self.select_iew.layer.shadowRadius = 5;// 阴影扩散的范围控制
    self.select_iew.layer.shadowOffset  = CGSizeMake(0, 0);// 阴影的范围
    
    
    self.markTextField.tag = 8080;

}

- (UIScrollView *)up_scrollView{
    if (_up_scrollView==nil) {
        _up_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _up_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64+0.5);
        if (iPhoneX) {
            _up_scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-24);
            _up_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-24+0.5);
        }
    }
    return _up_scrollView;
}

- (UIView *)topView{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, em*30)];
        _topView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:248/255.0 alpha:1];
    }
    return _topView;
}

- (UIButton *)commitBtn{
    if (_commitBtn==nil) {
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*1172)/2, em*1650, em*1172, em*132)];
    }
    return _commitBtn;
}

-(UIView *)select_iew{
    if (_select_iew==nil) {
        _select_iew = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*650-em*35, CGRectGetMaxY(self.selectMaskBtn.frame)+em*5+64, em*650, em*1085)];
        if (iPhoneX) {
            _select_iew.frame = CGRectMake(SCREEN_WIDTH-em*650-em*35, CGRectGetMaxY(self.selectMaskBtn.frame)+em*5+64+24, em*650, em*1085);
        }
        
    }
    return _select_iew;
}


- (UITableView *)selectTableView{
    if (_selectTableView==nil) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(em*5, em*5, em*640, em*1075)];
    }
    return _selectTableView;
}

//账号
- (UILabel *)accountLabel{
    if (_accountLabel==nil) {
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.topView.frame)+em*20, em*260, em*120)];
    }
    return _accountLabel;
}

- (UITextField *)accountTextField{
    if (_accountTextField==nil) {
        _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*500, CGRectGetMaxY(self.topView.frame)+em*20, em*500, em*120)];
        
    }
    return _accountTextField;
}

- (UIView *)account_line{
    if (_account_line==nil) {
        _account_line = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.accountLabel.frame)+em*20, SCREEN_WIDTH-em*35, 1)];
        _account_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _account_line.alpha = 0.6;
    }
    return _account_line;
}

//店铺名
- (UILabel *)shopLabel{
    if (_shopLabel==nil) {
        _shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.account_line.frame)+em*20, em*260, em*120)];
    }
    return _shopLabel;
}

- (UITextField *)shopTextField{
    if (_shopTextField==nil) {
        _shopTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*500, CGRectGetMaxY(self.account_line.frame)+em*20, em*500, em*120)];
        
    }
    return _shopTextField;
}

- (UIView *)shop_line{
    if (_shop_line==nil) {
        _shop_line = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.shopLabel.frame)+em*20, SCREEN_WIDTH-em*35, 1)];
        _shop_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _shop_line.alpha = 0.6;
    }
    return _shop_line;
}

//所在市场
- (UILabel *)marketLabel{
    if (_marketLabel==nil) {
        _marketLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.shop_line.frame)+em*20, em*260, em*120)];
    }
    return _marketLabel;
}

- (UITextField *)markTextField{
    if (_markTextField==nil) {
        _markTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*50-em*30-em*700, CGRectGetMaxY(self.shop_line.frame)+em*20, em*700, em*120)];
        //_markTextField.userInteractionEnabled = NO;
    }
    return _markTextField;
}

- (UIButton *)selectMaskBtn{
    if (_selectMaskBtn==nil) {
        _selectMaskBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*50, CGRectGetMaxY(self.shop_line.frame)+em*20+em*35, em*50, em*50)];
        [_selectMaskBtn setImage:[UIImage imageNamed:@"select_mask_image"] forState:UIControlStateNormal];
        _selectMaskBtn.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:245/255.0 alpha:1];
        
    }
    return _selectMaskBtn;
}

- (UIView *)market_line{
    if (_market_line==nil) {
        _market_line = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.marketLabel.frame)+em*20, SCREEN_WIDTH-em*35, 1)];
        _market_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _market_line.alpha = 0.6;
    }
    return _market_line;
}

//摊位号
- (UILabel *)boothLabel{
    if (_boothLabel==nil) {
        _boothLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.market_line.frame)+em*20, em*260, em*120)];
    }
    return _boothLabel;
}

- (UITextField *)boothTextField{
    if (_boothTextField==nil) {
        _boothTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*500, CGRectGetMaxY(self.market_line.frame)+em*20, em*500, em*120)];
        
    }
    return _boothTextField;
}

- (UIView *)booth_line{
    if (_booth_line==nil) {
        _booth_line = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.boothLabel.frame)+em*20, SCREEN_WIDTH-em*35, 1)];
        _booth_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _booth_line.alpha = 0.6;
    }
    return _booth_line;
}

//联系人
- (UILabel *)connectPersonLabel{
    if (_connectPersonLabel==nil) {
        _connectPersonLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.booth_line.frame)+em*20, em*260, em*120)];
    }
    return _connectPersonLabel;
}

- (UITextField *)connectPersonTextField{
    if (_connectPersonTextField==nil) {
        _connectPersonTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*500, CGRectGetMaxY(self.booth_line.frame)+em*20, em*500, em*120)];
        
    }
    return _connectPersonTextField;
}

- (UIView *)connectPerson_line{
    if (_connectPerson_line==nil) {
        _connectPerson_line = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.connectPersonLabel.frame)+em*20, SCREEN_WIDTH-em*35, 1)];
        _connectPerson_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _connectPerson_line.alpha = 0.6;
    }
    return _connectPerson_line;
}

//联系电话
- (UILabel *)connectTelLabel{
    if (_connectTelLabel==nil) {
        _connectTelLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.connectPerson_line.frame)+em*20, em*260, em*120)];
    }
    return _connectTelLabel;
}

- (UITextField *)connectTelTextField{
    if (_connectTelTextField==nil) {
        _connectTelTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*500, CGRectGetMaxY(self.connectPerson_line.frame)+em*20, em*500, em*120)];
        
    }
    return _connectTelTextField;
}

- (UIView *)connectTel_line{
    if (_connectTel_line==nil) {
        _connectTel_line = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.connectTelLabel.frame)+em*20, SCREEN_WIDTH-em*35, 1)];
        _connectTel_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _connectTel_line.alpha = 0.6;
    }
    return _connectTel_line;
}

//资质照片
- (UILabel *)qualificationLabel{
    if (_qualificationLabel==nil) {
        _qualificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.connectTel_line.frame)+em*20, em*260, em*120)];
    }
    return _qualificationLabel;
}

- (UIView *)qualificationBackView{
    if (_qualificationBackView==nil) {
        _qualificationBackView = [[UIView alloc] initWithFrame:CGRectMake(em*(35+260), CGRectGetMaxY(self.connectTel_line.frame)+em*51, em*260, em*260)];
        _qualificationBackView.backgroundColor = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:253/255.0 alpha:1];
        _qualificationBackView.layer.cornerRadius = 2;
        _qualificationBackView.layer.masksToBounds= YES;
    }
    return _qualificationBackView;
}

- (UIView *)qualiView{
    if (_qualiView==nil) {
        _qualiView = [[UIView alloc] initWithFrame:CGRectMake(em*22.5, em*22.5, em*215, em*215)];
        _qualiView.backgroundColor    = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:253/255.0 alpha:1];
        _qualiView.layer.borderColor  = [UIColor whiteColor].CGColor;
        _qualiView.layer.borderWidth  = 1;
        _qualiView.layer.cornerRadius = 4;
        _qualiView.layer.masksToBounds= YES;
    }
    return _qualiView;
}

- (UIImageView *)qualiImageView{
    if (_qualiImageView==nil) {
        _qualiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*32.5, em*9, em*150, em*188)];
        _qualiImageView.backgroundColor        = [UIColor colorWithRed:233/255.0 green:239/255.0 blue:253/255.0 alpha:1];
        _qualiImageView.image                  = [UIImage imageNamed:@"qulity_image"];
        _qualiImageView.userInteractionEnabled = YES;
    }
    return _qualiImageView;
}

- (UIView *)qualification_line{
    if (_qualification_line==nil) {
        _qualification_line = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.qualificationLabel.frame)+em*225, SCREEN_WIDTH-em*35, 1)];
        _qualification_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _qualification_line.alpha = 0.6;
    }
    return _qualification_line;
}


//邀请码
- (UILabel *)inviteCoderLabel{
    if (_inviteCoderLabel==nil) {
        _inviteCoderLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.connectTel_line.frame)+em*20, em*260, em*120)];
    }
    return _inviteCoderLabel;
}

- (UITextField *)inviteCoderTextField{
    if (_inviteCoderTextField==nil) {
        _inviteCoderTextField = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*500, CGRectGetMaxY(self.connectTel_line.frame)+em*20, em*500, em*120)];
        
    }
    return _inviteCoderTextField;
}

- (UIView *)inviteCoder_line{
    if (_inviteCoder_line==nil) {
        _inviteCoder_line = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.inviteCoderLabel.frame)+em*20, SCREEN_WIDTH-em*35, 1)];
        _inviteCoder_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _inviteCoder_line.alpha = 0.6;
    }
    return _inviteCoder_line;
}

- (MJCamerAlertView *)camerAlertView{
    if (_camerAlertView==nil) {
        _camerAlertView = [[MJCamerAlertView alloc] initWithFrame:SCREEN_BOUNDS];
        _camerAlertView.alpha = 0;
    }
    return _camerAlertView;
}
@end
