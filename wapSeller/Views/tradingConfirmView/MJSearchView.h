//
//  MJSearchView.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/29.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJSearchView : UIView
@property (nonatomic, strong)UITextField  *orderIDTextField;
@property (nonatomic, strong)UITextField  *leftDateTextField;
@property (nonatomic, strong)UITextField  *rightDateTextfield;
@property (nonatomic, strong)UITextField  *moneyTextField;

@property (nonatomic, strong)UITableView  *searchTableView;


@property (nonatomic, strong)UIView   *topView;
@property (nonatomic, strong)UIButton *cancleBtn;
@property (nonatomic, strong)UIButton *sureBtn;
@property (nonatomic, strong)UIDatePicker *myDatePicker;


//successful
@property(nonatomic,strong)MJSuccessfulPopView *successfulPopView;
//failed
@property(nonatomic,strong)MJFailedPopView     *failedPopView;
@end
