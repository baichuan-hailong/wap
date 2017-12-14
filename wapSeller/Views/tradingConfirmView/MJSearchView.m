//
//  MJSearchView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/29.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJSearchView.h"
@interface MJSearchView()

@property (nonatomic, strong)UIView  *headerView;

@property (nonatomic, strong)UIView  *orderIDView;
@property (nonatomic, strong)UIView  *leftView;
@property (nonatomic, strong)UIView  *rightView;
@property (nonatomic, strong)UIView  *left_rightLine;
@property (nonatomic, strong)UIView  *moneyView;
//元
@property (nonatomic, strong)UILabel  *yuanLabel;
@end

@implementation MJSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    //self.headerView.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.headerView];
    
    //order
    [self.headerView addSubview:self.orderIDView];
    [MJTxFieldManager setTxfield:self.orderIDTextField
                       placeText:@"搜索订单号"
                       textColor:[UIColor colorWithHex:@"404047"]
                            font:[UIFont systemFontOfSize:em*38]];
    //self.orderIDTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.orderIDTextField.clearsOnBeginEditing = YES;
    self.orderIDTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.orderIDView addSubview:self.orderIDTextField];
    
    
    //left
    [self.headerView addSubview:self.leftView];
    
    [MJTxFieldManager setTxfield:self.leftDateTextField
                       placeText:@"开始日期"
                       textColor:[UIColor colorWithHex:@"404047"]
                            font:[UIFont systemFontOfSize:em*38]];
    self.leftDateTextField.clearsOnBeginEditing = YES;
    self.leftDateTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.leftDateTextField.tag = 1010;
    [self.leftView addSubview:self.leftDateTextField];
    
    [self.headerView addSubview:self.left_rightLine];
    
    //right
    [self.headerView addSubview:self.rightView];
    
    [MJTxFieldManager setTxfield:self.rightDateTextfield
                       placeText:@"结束日期"
                       textColor:[UIColor colorWithHex:@"404047"]
                            font:[UIFont systemFontOfSize:em*38]];
    self.rightDateTextfield.clearsOnBeginEditing = YES;
    self.rightDateTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.rightDateTextfield.tag = 1011;
    [self.rightView addSubview:self.rightDateTextfield];
    
    //money
    [self.headerView addSubview:self.moneyView];
    [MJTxFieldManager setTxfield:self.moneyTextField
                       placeText:@"交易金额"
                       textColor:[UIColor colorWithHex:@"404047"]
                            font:[UIFont systemFontOfSize:em*38]];
    [self.moneyView addSubview:self.moneyTextField];
    
    //元
    [MJLabelManager setLabel:self.yuanLabel
                        text:@"元"
                   textColor:[UIColor colorWithHex:@"404047"]
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*38]];
    [self.moneyView addSubview:self.yuanLabel];
    
    
    self.searchTableView.backgroundColor = [UIColor colorWithRed:240/255.0  green:241/255.0  blue:247/255.0 alpha:1];
    self.searchTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    //self.searchTableView.backgroundColor = [UIColor redColor];
    [self addSubview:self.searchTableView];
    
    /*********************Data Picker**************************/
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    [self.topView addSubview:self.cancleBtn];
    [self.topView addSubview:self.sureBtn];
    
    
    self.cancleBtn.backgroundColor= [UIColor whiteColor];
    self.sureBtn.backgroundColor  = [UIColor whiteColor];
    
    self.myDatePicker.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:self.myDatePicker];
    
    
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:[UIColor colorWithHex:primaryColor] forState:UIControlStateNormal];
    self.cancleBtn.titleLabel.font    = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor colorWithHex:primaryColor] forState:UIControlStateNormal];
    self.sureBtn.titleLabel.font    = [UIFont systemFontOfSize:SCREEN_WIDTH/375*14];
    
}

//header view
- (UIView *)headerView{
    if (_headerView==nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, em*420)];
        if (iPhoneX) {
            //_headerView.frame = CGRectMake(0, 64+24, SCREEN_WIDTH, em*420);
        }
    }
    return _headerView;
}



- (UIView *)orderIDView{
    if (_orderIDView==nil) {
        _orderIDView = [[UIView alloc] initWithFrame:CGRectMake(em*35, em*42, SCREEN_WIDTH-em*70, em*100)];
        _orderIDView.backgroundColor = [UIColor whiteColor];
        _orderIDView.layer.cornerRadius = 4;
        _orderIDView.layer.masksToBounds= YES;
    }
    return _orderIDView;
}


- (UITextField *)orderIDTextField{
    if (_orderIDTextField==nil) {
        _orderIDTextField = [[UITextField alloc] initWithFrame:CGRectMake(em*32, em*0, SCREEN_WIDTH-em*70-em*64, em*100)];
    }
    return _orderIDTextField;
}




- (UIView *)leftView{
    if (_leftView==nil) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.orderIDView.frame)+em*24, em*522, em*100)];
        _leftView.backgroundColor = [UIColor whiteColor];
        _leftView.layer.cornerRadius = 4;
        _leftView.layer.masksToBounds= YES;
    }
    return _leftView;
}

- (UIView *)left_rightLine{
    if (_left_rightLine==nil) {
        _left_rightLine = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*30)/2, CGRectGetMaxY(self.orderIDView.frame)+em*24+em*48, em*30, em*4)];
        _left_rightLine.backgroundColor = [UIColor colorWithHex:@"a8abba"];
    }
    return _left_rightLine;
}


- (UITextField *)leftDateTextField{
    if (_leftDateTextField==nil) {
        _leftDateTextField = [[UITextField alloc] initWithFrame:CGRectMake(em*32, em*0, em*522-em*64, em*100)];
    }
    return _leftDateTextField;
}



- (UIView *)rightView{
    if (_rightView==nil) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*522, CGRectGetMaxY(self.orderIDView.frame)+em*24, em*522, em*100)];
        _rightView.backgroundColor = [UIColor whiteColor];
        _rightView.layer.cornerRadius = 4;
        _rightView.layer.masksToBounds= YES;
    }
    return _rightView;
}


- (UITextField *)rightDateTextfield{
    if (_rightDateTextfield==nil) {
        _rightDateTextfield = [[UITextField alloc] initWithFrame:CGRectMake(em*32, em*0, em*522-em*64, em*100)];
    }
    return _rightDateTextfield;
}

- (UIView *)moneyView{
    if (_moneyView==nil) {
        _moneyView = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.leftView.frame)+em*24, SCREEN_WIDTH-em*70, em*100)];
        _moneyView.backgroundColor = [UIColor whiteColor];
        _moneyView.layer.cornerRadius = 4;
        _moneyView.layer.masksToBounds= YES;
    }
    return _moneyView;
}

- (UILabel *)yuanLabel{
    if (_yuanLabel==nil) {
        _yuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*70-em*36-em*100, 0, em*100, em*100)];
    }
    return _yuanLabel;
}

- (UITextField *)moneyTextField{
    if (_moneyTextField == nil) {
        _moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(em*32, em*0, SCREEN_WIDTH-em*70-em*64-em*150, em*100)];
    }
    return _moneyTextField;
}






- (UITableView *)searchTableView{
    if (_searchTableView==nil){
        _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-64-CGRectGetMaxY(self.headerView.frame))];
        if (iPhoneX) {
            _searchTableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-64-24-CGRectGetMaxY(self.headerView.frame));
        }
    }
    return _searchTableView;
}


/*********************Data Picker**************************/
-(UIView *)topView{
    if (_topView==nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            SCREEN_HEIGHT,
                                                            SCREEN_WIDTH,
                                                            SCREEN_WIDTH/375*225)];
    }
    return _topView;
}

-(UIButton *)cancleBtn{
    if (_cancleBtn==nil) {
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                SCREEN_WIDTH/375*80,
                                                                SCREEN_WIDTH/375*25)];
    }
    return _cancleBtn;
}

-(UIButton *)sureBtn{
    if (_sureBtn==nil) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/375*80,
                                                              0,
                                                              SCREEN_WIDTH/375*80,
                                                              SCREEN_WIDTH/375*25)];
    }
    return _sureBtn;
}



-(UIDatePicker *)myDatePicker{
    if (_myDatePicker==nil) {
        _myDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,
                                                                       SCREEN_WIDTH/375*25,
                                                                       SCREEN_WIDTH,
                                                                       SCREEN_WIDTH/375*200)];
        //_myDatePicker.maximumDate= [NSDate date];//today
        _myDatePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _myDatePicker;
}



//successful
- (MJSuccessfulPopView *)successfulPopView{
    if (_successfulPopView==nil) {
        _successfulPopView = [[MJSuccessfulPopView alloc] initWithFrame:SCREEN_BOUNDS];
        _successfulPopView.alpha = 0;
    }
    return _successfulPopView;
}

//failed
- (MJFailedPopView *)failedPopView{
    if (_failedPopView==nil) {
        _failedPopView = [[MJFailedPopView alloc] initWithFrame:SCREEN_BOUNDS];
        _failedPopView.alpha = 0;
    }
    return _failedPopView;
}



@end
