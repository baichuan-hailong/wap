//
//  MJTradingConfirmView.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJTradingConfirmView : UIView

//set
@property(nonatomic,strong)UIButton *setBtn;
//search
@property(nonatomic,strong)UIButton *searchBtn;

//顶部
@property(nonatomic,strong)UIView *suspensionTabView;

@property(nonatomic,strong)UIView        *tab_line;
@property(nonatomic,strong)UIScrollView  *tab_scrollView;

//待确认
@property(nonatomic,strong)UIButton    *waitBtn;
@property(nonatomic,strong)UITableView *waitTableView;

//已确认
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UITableView *sureTableView;

//全部
@property(nonatomic,strong)UIButton *allBtn;
@property(nonatomic,strong)UITableView *allTableView;

//successful
@property(nonatomic,strong)MJSuccessfulPopView *successfulPopView;

//failed
@property(nonatomic,strong)MJFailedPopView     *failedPopView;


@end
