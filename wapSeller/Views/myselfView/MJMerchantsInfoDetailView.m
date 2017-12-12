//
//  MJMerchantsInfoDetailView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/27.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMerchantsInfoDetailView.h"
@interface MJMerchantsInfoDetailView()
@property(nonatomic, strong)UIScrollView *up_scrollView;

//账号
@property(nonatomic,strong)UILabel *accountTipLabel;
@property(nonatomic,strong)UILabel *accountLabel;

//店铺名
@property(nonatomic,strong)UILabel *nameTipLabel;
@property(nonatomic,strong)UILabel *nameLabel;


@property(nonatomic,strong)UIView *line_view;

//所在市场
@property(nonatomic,strong)UILabel *maskTipLabel;
@property(nonatomic,strong)UILabel *maskLabel;

//摊位号
@property(nonatomic,strong)UILabel *noTipLabel;
@property(nonatomic,strong)UILabel *noLabel;

//联系人
@property(nonatomic,strong)UILabel *contectTipLabel;
@property(nonatomic,strong)UILabel *contectLabel;

//联系电话
@property(nonatomic,strong)UILabel *telTipLabel;
@property(nonatomic,strong)UILabel *telLabel;
@end

@implementation MJMerchantsInfoDetailView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    [self addSubview:self.up_scrollView];
    //账户
    [MJLabelManager setLabel:self.accountTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.accountTipLabel];
    
    [MJLabelManager setLabel:self.accountLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.accountLabel];
    
    //店铺名
    [MJLabelManager setLabel:self.nameTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.nameTipLabel];
    
    [MJLabelManager setLabel:self.nameLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.nameLabel];
    
    [self.up_scrollView addSubview:self.line_view];
    
    //所在市场
    [MJLabelManager setLabel:self.maskTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.maskTipLabel];
    
    [MJLabelManager setLabel:self.maskLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.maskLabel];
    
    //摊位号
    [MJLabelManager setLabel:self.noTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.noTipLabel];
    
    [MJLabelManager setLabel:self.noLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.noLabel];
    
    //联系人
    [MJLabelManager setLabel:self.contectTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.contectTipLabel];
    
    [MJLabelManager setLabel:self.contectLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.contectLabel];
    
    
    //联系电话
    [MJLabelManager setLabel:self.telTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.telTipLabel];
    
    [MJLabelManager setLabel:self.telLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.telLabel];
    
    
}

- (void)setDetail:(NSDictionary *)detailDIc{
    
    if (detailDIc!=nil) {
        NSString *logintel    =  [[NSUserDefaults standardUserDefaults] objectForKey:LoginTel];
        self.accountTipLabel.text = @"账户";
        self.accountLabel.text    = logintel;
        
        //NSLog(@"logintel %@",logintel);
        
        self.nameTipLabel.text = @"店铺名";
        self.nameLabel.text    = [NSString stringWithFormat:@"%@",detailDIc[@"clientName"]];
        
        self.maskTipLabel.text = @"所在市场";
        self.maskLabel.text    = [NSString stringWithFormat:@"%@",detailDIc[@"marketName"]];
        
        self.noTipLabel.text = @"摊位号";
        self.noLabel.text    = [NSString stringWithFormat:@"%@",detailDIc[@"sellerStallInfo"]];
        
        self.contectTipLabel.text = @"联系人";
        self.contectLabel.text = [NSString stringWithFormat:@"%@",detailDIc[@"linkman"]];
        
        self.telTipLabel.text = @"联系电话";
        self.telLabel.text = [NSString stringWithFormat:@"%@",detailDIc[@"telephone"]];
    }
    
    
    
    
    
    
    
    
    
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

//账号
- (UILabel *)accountTipLabel{
    if (_accountTipLabel==nil) {
        _accountTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, em*72, em*150, em*45)];
    }
    return _accountTipLabel;
}


- (UILabel *)accountLabel{
    if (_accountLabel==nil) {
        _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*600, em*72, em*600, em*45)];
    }
    return _accountLabel;
}

//店铺名
- (UILabel *)nameTipLabel{
    if (_nameTipLabel==nil) {
        _nameTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.accountLabel.frame)+em*70, em*150, em*45)];
    }
    return _nameTipLabel;
}


- (UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*600, CGRectGetMaxY(self.accountLabel.frame)+em*70, em*600, em*45)];
    }
    return _nameLabel;
}

- (UIView *)line_view{
    if (_line_view==nil) {
        _line_view = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.nameLabel.frame)+em*72, SCREEN_WIDTH-em*35, 1)];
        _line_view.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _line_view.alpha = 0.6;
    }
    return _line_view;
}

//所在市场
- (UILabel *)maskTipLabel{
    if (_maskTipLabel==nil) {
        _maskTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.line_view.frame)+em*72, em*250, em*45)];
    }
    return _maskTipLabel;
}


- (UILabel *)maskLabel{
    if (_maskLabel==nil) {
        _maskLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*600, CGRectGetMaxY(self.line_view.frame)+em*72, em*600, em*45)];
    }
    return _maskLabel;
}

//摊位号
- (UILabel *)noTipLabel{
    if (_noTipLabel==nil) {
        _noTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.maskLabel.frame)+em*70, em*250, em*45)];
    }
    return _noTipLabel;
}


- (UILabel *)noLabel{
    if (_noLabel==nil) {
        _noLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*600, CGRectGetMaxY(self.maskLabel.frame)+em*70, em*600, em*45)];
    }
    return _noLabel;
}

//联系人
- (UILabel *)contectTipLabel{
    if (_contectTipLabel==nil) {
        _contectTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.noLabel.frame)+em*70, em*250, em*45)];
    }
    return _contectTipLabel;
}


- (UILabel *)contectLabel{
    if (_contectLabel==nil) {
        _contectLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*600, CGRectGetMaxY(self.noLabel.frame)+em*70, em*600, em*45)];
    }
    return _contectLabel;
}

//联系电话
- (UILabel *)telTipLabel{
    if (_telTipLabel==nil) {
        _telTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.contectLabel.frame)+em*70, em*250, em*45)];
    }
    return _telTipLabel;
}


- (UILabel *)telLabel{
    if (_telLabel==nil) {
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*600, CGRectGetMaxY(self.contectLabel.frame)+em*70, em*600, em*45)];
    }
    return _telLabel;
}

@end
