//
//  MJSettingView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/28.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJSettingView.h"

@interface MJSettingView()
@property(nonatomic, strong)UIScrollView *up_scrollView;

@property (nonatomic, strong)UIView   *topView;
@property (nonatomic, strong)UILabel  *myLabel;
//tip
@property (nonatomic, strong)UIImageView *tipStarImageView;
@property (nonatomic, strong)UIImageView *tipStar_ImageView;
@property (nonatomic, strong)UILabel *tipStarLabel;
@property (nonatomic, strong)UILabel *tipLabel;
@property (nonatomic, strong)UILabel *tipStar_label;
@end

@implementation MJSettingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    [self addSubview:self.up_scrollView];
    
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.up_scrollView addSubview:self.topView];
    
    [MJLabelManager setLabel:self.myLabel
                        text:@"扫描枪确认"
                   textColor:[UIColor colorWithHex:@"404047"]
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*42]];
    [self.topView addSubview:self.myLabel];
    
    [self.topView addSubview:self.mySwitch];
    
    //state
    [self.up_scrollView addSubview:self.stateImageView];
    [MJLabelManager setLabel:self.stateLabel
                        text:@"扫描枪未连接"
                   textColor:[UIColor colorWithHex:@"f52414"]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.stateLabel];
    
    
    
    [self.up_scrollView addSubview:self.tipStarImageView];
    [MJLabelManager setLabel:self.tipStarLabel
                        text:@"使用扫描枪确认时，扫描到的交易将自动确认通过"
                   textColor:[UIColor colorWithHex:@"adaebd"]
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*36]];
    self.tipStarLabel.numberOfLines = 0;
    [self.up_scrollView addSubview:self.tipStarLabel];
    
    //请仔细核对买家提供的信息后在扫描
    [MJLabelManager setLabel:self.tipLabel
                        text:@"请仔细核对买家提供的信息后在扫描"
                   textColor:[UIColor colorWithHex:@"adaebd"]
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*36]];
    self.tipLabel.numberOfLines = 0;
    [self.up_scrollView addSubview:self.tipLabel];
    
    
    
    
    [self.up_scrollView addSubview:self.tipStar_ImageView];
    [MJLabelManager setLabel:self.tipStar_label
                        text:@"使用扫描枪确认时，系统会开启语音提醒"
                   textColor:[UIColor colorWithHex:@"adaebd"]
               textAlignment:NSTextAlignmentLeft
                        font:[UIFont systemFontOfSize:em*36]];
    self.tipStar_label.numberOfLines = 0;
    [self.up_scrollView addSubview:self.tipStar_label];
    
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
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, em*196)];
    }
    return _topView;
}

- (UILabel *)myLabel{
    if (_myLabel==nil) {
        _myLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*35, em*48, SCREEN_WIDTH/2, em*100)];
    }
    return _myLabel;
}

- (UISwitch *)mySwitch{
    if (_mySwitch==nil) {
        _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*150, em*51, em*150, em*84)];
        _mySwitch.on = NO;
    }
    return _mySwitch;
}

//state
- (UIImageView *)stateImageView{
    if (_stateImageView==nil) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*180)/2, CGRectGetMaxY(self.topView.frame)+em*294, em*180, em*180)];
        _stateImageView.image = [UIImage imageNamed:@"state_off_image"];
    }
    return _stateImageView;
}

- (UILabel *)stateLabel{
    if (_stateLabel==nil) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stateImageView.frame)+em*60, SCREEN_WIDTH, em*45)];
    }
    return _stateLabel;
}

//tip
- (UIImageView *)tipStarImageView{
    if (_tipStarImageView==nil) {
        _tipStarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*166, CGRectGetMaxY(self.stateLabel.frame)+em*142+em*5, em*30, em*30)];
        _tipStarImageView.image = [UIImage imageNamed:@"tip_star_image"];
    }
    return _tipStarImageView;
}

- (UILabel *)tipStarLabel{
    if (_tipStarLabel==nil) {
        _tipStarLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*226, CGRectGetMaxY(self.stateLabel.frame)+em*142, SCREEN_WIDTH-em*226, em*40)];
    }
    return _tipStarLabel;
}

//middle tip
- (UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*226, CGRectGetMaxY(self.tipStarLabel.frame)+em*20, SCREEN_WIDTH-em*226, em*40)];
    }
    return _tipLabel;
}

- (UIImageView *)tipStar_ImageView{
    if (_tipStar_ImageView==nil) {
        _tipStar_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*166, CGRectGetMaxY(self.tipLabel.frame)+em*54+em*5, em*30, em*30)];
        _tipStar_ImageView.image = [UIImage imageNamed:@"tip_star_image"];
    }
    return _tipStar_ImageView;
}

- (UILabel *)tipStar_label{
    if (_tipStar_label==nil) {
        _tipStar_label = [[UILabel alloc] initWithFrame:CGRectMake(em*226, CGRectGetMaxY(self.tipLabel.frame)+em*54, SCREEN_WIDTH-em*226, em*40)];
    }
    return _tipStar_label;
}

@end
