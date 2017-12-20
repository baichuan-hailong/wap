//
//  MJUpWaitingView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/5.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJUpWaitingView.h"

@interface MJUpWaitingView()
@property(nonatomic, strong)UIScrollView *up_scrollView;

@property(nonatomic,strong)UIImageView *stateImageView;
@property(nonatomic,strong)UILabel     *stateLabel;

@end

@implementation MJUpWaitingView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    [self addSubview:self.up_scrollView];
    
    //audit_successful_iamge audit_failed_image
    [self.up_scrollView addSubview:self.stateImageView];
    
    [MJLabelManager setLabel:self.stateLabel
                        text:@"- - -"
                   textColor:[UIColor colorWithHex:@"5c5d6c"]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*48]];
    [self.up_scrollView addSubview:self.stateLabel];
    
    [MJLabelManager setLabel:self.reasonLabel
                        text:@"原因：---"
                   textColor:[UIColor colorWithHex:@"3371fc"]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*48]];
    self.reasonLabel.alpha = 0;
    [self.up_scrollView addSubview:self.reasonLabel];
    
    
    [MJBtnManager setButton:self.resetUpBtn
                      title:@"修改卖家信息"
                  textColor:[UIColor colorWithHex:@"f91e1e"]
                       font:[UIFont systemFontOfSize:em*42]
                borderColor:[UIColor colorWithHex:@"ff1e1e"] borderWidth:1 radius:em*48];
    [self.up_scrollView addSubview:self.resetUpBtn];
}


- (void)upView:(BOOL)isSuccessful{
    if (isSuccessful) {
        self.reasonLabel.alpha = 0;
        self.stateImageView.image = [UIImage imageNamed:@"audit_successful_iamge"];
        self.stateLabel.text = @"账号审核中，请稍后...";
    }else{
        self.reasonLabel.alpha = 1;
        self.stateImageView.image = [UIImage imageNamed:@"audit_failed_image"];
        self.stateLabel.text = @"审核未通过";
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

- (UIImageView *)stateImageView{
    if (_stateImageView==nil) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*394)/2, em*267, em*394, em*356)];
    }
    return _stateImageView;
}

- (UILabel *)stateLabel{
    if (_stateLabel==nil) {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stateImageView.frame)+em*64, SCREEN_WIDTH, em*45)];
    }
    return _stateLabel;
}

- (UILabel *)reasonLabel{
    if (_reasonLabel==nil) {
        _reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.stateLabel.frame)+em*60, SCREEN_WIDTH-40, em*45)];
    }
    return _reasonLabel;
}


- (UIButton *)resetUpBtn{
    if (_resetUpBtn==nil) {
        _resetUpBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*374)/2, SCREEN_HEIGHT-64-em*255-em*96, em*374, em*96)];
        if (iPhoneX) {
            _resetUpBtn.frame = CGRectMake((SCREEN_WIDTH-em*374)/2, SCREEN_HEIGHT-64-24-em*255-em*96, em*374, em*96);
        }
    }
    return _resetUpBtn;
}
@end
