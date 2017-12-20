//
//  MJBillDetailView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/27.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJBillDetailView.h"

@interface MJBillDetailView()
@property(nonatomic, strong)UIScrollView *up_scrollView;

@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UILabel *moneyTipLabel;


//类型
@property(nonatomic,strong)UILabel *typeTipLabel;
@property(nonatomic,strong)UILabel *typeLabel;

//时间
@property(nonatomic,strong)UILabel *timeTipLabel;
@property(nonatomic,strong)UILabel *timeLabel;


@property(nonatomic,strong)UIView *line_view;

//充值方式
@property(nonatomic,strong)UILabel *paytypeTipLabel;
@property(nonatomic,strong)UILabel *paytypeLabel;

//微信ID
@property(nonatomic,strong)UILabel *wechatidTipLabel;
@property(nonatomic,strong)UILabel *wechatnoLabel;

//流水号
@property(nonatomic,strong)UILabel *liushuiTipLabel;
@property(nonatomic,strong)UILabel *liushuiLabel;



@end

@implementation MJBillDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self addSubview:self.up_scrollView];
    
    [MJLabelManager setLabel:self.moneyLabel
                        text:@"--"
                           r:44
                           g:44
                           b:53
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*80]];
    [self.up_scrollView addSubview:self.moneyLabel];
    
    [MJLabelManager setLabel:self.moneyTipLabel
                        text:@"- -"
                           r:92
                           g:92
                           b:102
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*36]];
    [self.up_scrollView addSubview:self.moneyTipLabel];
    
    //类型
    [MJLabelManager setLabel:self.typeTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.typeTipLabel];
    
    [MJLabelManager setLabel:self.typeLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.typeLabel];
    
    //时间
    [MJLabelManager setLabel:self.timeTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.timeTipLabel];
    
    [MJLabelManager setLabel:self.timeLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.timeLabel];
    
    [self.up_scrollView addSubview:self.line_view];
    
    //充值方式
    [MJLabelManager setLabel:self.paytypeTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.paytypeTipLabel];
    
    [MJLabelManager setLabel:self.paytypeLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.paytypeLabel];
    
    //微信ID
    [MJLabelManager setLabel:self.wechatidTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    //[self.up_scrollView addSubview:self.wechatidTipLabel];
    
    [MJLabelManager setLabel:self.wechatnoLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    //[self.up_scrollView addSubview:self.wechatnoLabel];
    
    //流水号
    [MJLabelManager setLabel:self.liushuiTipLabel
                        text:@"- -"
                           r:128
                           g:128
                           b:139
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.liushuiTipLabel];
    
    [MJLabelManager setLabel:self.liushuiLabel
                        text:@"- -"
                           r:64
                           g:64
                           b:71
               textAlignment:NSTextAlignmentRight
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.liushuiLabel];
}

- (void)setDetail:(NSDictionary *)detailDIc{
    
    self.moneyTipLabel.text = @"金额（元）";
    
    //类型
    self.typeTipLabel.text  = @"类型";
    self.typeLabel.text     = [NSString stringWithFormat:@"%@",detailDIc[@"tranType"]];
    
    NSString *amount = [NSString stringWithFormat:@"%@",detailDIc[@"amount"]];//amount
    if ([amount floatValue]<0) {
        self.moneyLabel.text    = [NSString stringWithFormat:@"%.2f",[amount floatValue]];//amount
    }else{
        self.moneyLabel.text    = [NSString stringWithFormat:@"+%.2f",[amount floatValue]];//amount
    }
    
    
    self.timeTipLabel.text = @"时间";
    
    NSString *createDate = [NSString stringWithFormat:@"%@",detailDIc[@"createDate"]];//time
    createDate = [NSString stringWithFormat:@"%ld",[createDate integerValue]/1000];
    self.timeLabel.text  = [self timeChange:createDate];
    
    
    self.paytypeTipLabel.text = @"充值方式";
    
    NSString *channelId = [NSString stringWithFormat:@"%@",detailDIc[@"channelId"]];//方式
    
    NSString *channelUser = [NSString stringWithFormat:@"%@",detailDIc[@"channelUser"]];
    NSString *billNo   = [NSString stringWithFormat:@"%@",detailDIc[@"billNo"]];
    if ([channelUser isNull]) {
        channelUser = @"暂无";
    }
    if ([billNo isNull]) {
        billNo = @"暂无";
    }
    
    
    if ([channelId isEqualToString:@"ALIPAY_MOBILE"]) {
        //self.wechatidTipLabel.text = @"支付宝ID";
        //self.wechatnoLabel.text    = channelUser;
        self.liushuiTipLabel.text = @"流水号";
        self.liushuiLabel.text    = billNo;
        self.paytypeLabel.text    = [NSString stringWithFormat:@"%@",@"支付宝"];
    }else if([channelId isEqualToString:@"WX_APP"]){
        //self.wechatidTipLabel.text = @"微信ID";
        //self.wechatnoLabel.text    = channelUser;
        self.liushuiTipLabel.text = @"流水号";
        self.liushuiLabel.text    = billNo;
        self.paytypeLabel.text    = [NSString stringWithFormat:@"%@",@"微信"];
    }else{
        self.paytypeLabel.text    = [NSString stringWithFormat:@"%@",@"线下充值"];
        self.wechatidTipLabel.alpha = 0;
        self.wechatnoLabel.alpha = 0;
        self.liushuiTipLabel.alpha = 0;
        self.liushuiLabel.alpha = 0;
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

//money
- (UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*800)/2, em*150, em*800, em*60)];
    }
    return _moneyLabel;
}

- (UILabel *)moneyTipLabel{
    if (_moneyTipLabel==nil) {
        _moneyTipLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*800)/2, CGRectGetMaxY(self.moneyLabel.frame)+em*42, em*800, em*36)];
    }
    return _moneyTipLabel;
}

//类型
- (UILabel *)typeTipLabel{
    if (_typeTipLabel==nil) {
        _typeTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, em*436, em*150, em*45)];
    }
    return _typeTipLabel;
}


- (UILabel *)typeLabel{
    if (_typeLabel==nil) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*600, em*436, em*600, em*45)];
    }
    return _typeLabel;
}

//时间
- (UILabel *)timeTipLabel{
    if (_timeTipLabel==nil) {
        _timeTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.typeLabel.frame)+em*70, em*150, em*45)];
    }
    return _timeTipLabel;
}


- (UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*600, CGRectGetMaxY(self.typeLabel.frame)+em*70, em*600, em*45)];
    }
    return _timeLabel;
}

- (UIView *)line_view{
    if (_line_view==nil) {
        _line_view = [[UIView alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.timeLabel.frame)+em*58, SCREEN_WIDTH-em*35, 0.5)];
        _line_view.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        _line_view.alpha = 0.6;
    }
    return _line_view;
}
//
////充值方式
- (UILabel *)paytypeTipLabel{
    if (_paytypeTipLabel==nil) {
        _paytypeTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.line_view.frame)+em*62, em*200, em*45)];
    }
    return _paytypeTipLabel;
}


- (UILabel *)paytypeLabel{
    if (_paytypeLabel==nil) {
        _paytypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*600, CGRectGetMaxY(self.line_view.frame)+em*62, em*600, em*45)];
    }
    return _paytypeLabel;
}
//
////微信ID
- (UILabel *)wechatidTipLabel{
    if (_wechatidTipLabel==nil) {
        _wechatidTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.paytypeLabel.frame)+em*70, em*250, em*45)];
    }
    return _wechatidTipLabel;
}


- (UILabel *)wechatnoLabel{
    if (_wechatnoLabel==nil) {
        _wechatnoLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*600, CGRectGetMaxY(self.paytypeLabel.frame)+em*70, em*600, em*45)];
    }
    return _wechatnoLabel;
}
//
////流水号
- (UILabel *)liushuiTipLabel{
    if (_liushuiTipLabel==nil) {
        _liushuiTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.paytypeLabel.frame)+em*70, em*150, em*45)];
    }
    return _liushuiTipLabel;
}


- (UILabel *)liushuiLabel{
    if (_liushuiLabel==nil) {
        _liushuiLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*800, CGRectGetMaxY(self.paytypeLabel.frame)+em*70, em*800, em*45)];
    }
    //_liushuiLabel.backgroundColor = [UIColor redColor];
    return _liushuiLabel;
}

#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd hh:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}


@end
