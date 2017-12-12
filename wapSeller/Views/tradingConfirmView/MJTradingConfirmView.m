//
//  MJTradingConfirmView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJTradingConfirmView.h"
@interface MJTradingConfirmView()
@property(nonatomic,strong)UIView  *navlogoView;

@property(nonatomic,strong)UILabel *navlabel;

//顶部
//@property(nonatomic,strong)UIView *suspensionTabView;
@property(nonatomic,strong)UIView *tab_View;
@end


@implementation MJTradingConfirmView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    //[self addSubview:self.navlogoView];
    
    [MJLabelManager setLabel:self.navlabel
                        text:@"交易确认"
                   textColor:[UIColor whiteColor]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*60]];
    //[self.navlogoView addSubview:self.navlabel];
    
    //set
    //self.setBtn.backgroundColor = [UIColor yellowColor];
    [self.navlogoView addSubview:self.setBtn];
    
    //search
    //self.searchBtn.backgroundColor = [UIColor yellowColor];
    [self.navlogoView addSubview:self.searchBtn];
    
    //tab
    [self addSubview:self.suspensionTabView];
    [self.suspensionTabView addSubview:self.tab_View];
    
    [self.tab_View addSubview:self.tab_line];
    
    //wait
    [self.waitBtn setTitle:@"待确认" forState:UIControlStateNormal];
    [self.waitBtn setTitleColor:[UIColor colorWithHex:@"fc2523"] forState:UIControlStateNormal];
    self.waitBtn.titleLabel.font    = [UIFont systemFontOfSize:em*42];
    //self.waitBtn.backgroundColor = [UIColor yellowColor];
    [self.tab_View addSubview:self.waitBtn];
    
    //sure
    [self.sureBtn setTitle:@"已确认" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor colorWithHex:@"a6a8b4"] forState:UIControlStateNormal];
    self.sureBtn.titleLabel.font    = [UIFont systemFontOfSize:em*42];
    //self.sureBtn.backgroundColor = [UIColor yellowColor];
    [self.tab_View addSubview:self.sureBtn];
    
    //all
    [self.allBtn setTitle:@"全部" forState:UIControlStateNormal];
    [self.allBtn setTitleColor:[UIColor colorWithHex:@"a6a8b4"] forState:UIControlStateNormal];
    self.allBtn.titleLabel.font    = [UIFont systemFontOfSize:em*42];
    //self.allBtn.backgroundColor = [UIColor yellowColor];
    [self.tab_View addSubview:self.allBtn];
    
    
    //scroll
    self.tab_scrollView.pagingEnabled   = YES;
    self.tab_scrollView.showsHorizontalScrollIndicator = NO;
    self.tab_scrollView.showsVerticalScrollIndicator   = NO;
    self.tab_scrollView.bounces = NO;
    self.tab_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT-CGRectGetMaxY(self.suspensionTabView.frame)-49-1-64);
    [self addSubview:self.tab_scrollView];
    
    
    self.waitTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:248/255.0 alpha:1];
    self.waitTableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.waitTableView.showsVerticalScrollIndicator = NO;
    self.waitTableView.tag = 2000;
    [self.tab_scrollView addSubview:self.waitTableView];
    
    self.sureTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:248/255.0 alpha:1];
    self.sureTableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.sureTableView.showsVerticalScrollIndicator = NO;
    self.sureTableView.tag = 2001;
    [self.tab_scrollView addSubview:self.sureTableView];
    
    self.allTableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:248/255.0 alpha:1];
    self.allTableView.separatorStyle               = UITableViewCellSeparatorStyleNone;
    self.allTableView.showsVerticalScrollIndicator = NO;
    self.allTableView.tag = 2002;
    [self.tab_scrollView addSubview:self.allTableView];
}

-(UIView *)navlogoView{
    if (_navlogoView==nil) {
        _navlogoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        if (iPhoneX) {
            _navlogoView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64+24);
        }
        _navlogoView.backgroundColor = [UIColor colorWithRed:246/255.0 green:35/255.0 blue:42/255.0 alpha:1];
    }
    return _navlogoView;
}

- (UILabel *)navlabel{
    if (_navlabel==nil) {
        _navlabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*800)/2, em*60, em*800, em*132)];
        if (iPhoneX) {
            _navlabel.frame = CGRectMake((SCREEN_WIDTH-em*800)/2, em*60, em*800, em*132);
        }
    }
    return _navlabel;
}

//set
- (UIButton *)setBtn{
    if (_setBtn==nil) {
        _setBtn = [[UIButton alloc] initWithFrame:CGRectMake(em*20, em*90, em*90, em*80)];
        if (iPhoneX) {
            _setBtn.frame = CGRectMake(em*20, em*80, em*80, em*80);
        }
    }
    [_setBtn setImage:[UIImage imageNamed:@"set_image"] forState:UIControlStateNormal];
    return _setBtn;
}

//search search_image
- (UIButton *)searchBtn{
    if (_searchBtn==nil) {
        _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*20-em*90, em*90, em*90, em*80)];
        if (iPhoneX) {
            _searchBtn.frame = CGRectMake(em*20, em*80, em*80, em*80);
        }
        [_searchBtn setImage:[UIImage imageNamed:@"search_image"] forState:UIControlStateNormal];
    }
    return _searchBtn;
}


- (UIView *)suspensionTabView{
    if (_suspensionTabView==nil){
        _suspensionTabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, em*180)];
        _suspensionTabView.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:248/255.0 alpha:1];
    }
    return _suspensionTabView;
}

- (UIView *)tab_View{
    if (_tab_View==nil){
        _tab_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, em*150)];
        _tab_View.backgroundColor = [UIColor whiteColor];
    }
    return _tab_View;
}

- (UIScrollView *)tab_scrollView{
    if (_tab_scrollView==nil){
        _tab_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.suspensionTabView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.suspensionTabView.frame)-49-64-1)];
        _tab_scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _tab_scrollView;
}

//tab
- (UIView *)tab_line{
    if (_tab_line==nil) {
        _tab_line = [[UIView alloc] initWithFrame:CGRectMake(em*200+em*11, em*150-em*6, em*128, em*6)];
        _tab_line.backgroundColor = [UIColor colorWithHex:@"f91e13"];
    }
    return _tab_line;
}

//wait
-(UIButton *)waitBtn{
    if (_waitBtn==nil) {
        _waitBtn = [[UIButton alloc] initWithFrame:CGRectMake(em*200, em*25, em*150, em*100)];
    }
    return _waitBtn;
}

- (UITableView *)waitTableView{
    if (_waitTableView==nil){
        _waitTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.suspensionTabView.frame)-49-64)];
    }
    return _waitTableView;
}

//sure
-(UIButton *)sureBtn{
    if (_sureBtn==nil) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*150)/2, em*25, em*150, em*100)];
    }
    return _sureBtn;
}

- (UITableView *)sureTableView{
    if (_sureTableView==nil){
        _sureTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.suspensionTabView.frame)-49-64)];
    }
    return _sureTableView;
}

//all
-(UIButton *)allBtn{
    if (_allBtn==nil) {
        _allBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*200-em*150, em*25, em*150, em*100)];
    }
    return _allBtn;
}

- (UITableView *)allTableView{
    if (_allTableView==nil){
        _allTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.suspensionTabView.frame)-49-64)];
    }
    return _allTableView;
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
