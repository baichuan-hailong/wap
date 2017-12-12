//
//  MJSuccessfulPopView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/29.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJSuccessfulPopView.h"

@interface MJSuccessfulPopView()

@property(nonatomic,strong)UIView *tipView;

@property(nonatomic,strong)UIImageView *tipImgeView;
@property(nonatomic,strong)UILabel     *tipLabel;
@end

@implementation MJSuccessfulPopView
//330*320
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    [self addSubview:self.tipView];
    
    self.tipView.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.tipView.layer.cornerRadius = 5;
    self.tipView.layer.masksToBounds= YES;
    self.tipView.alpha = 0.8;
    
    
    self.tipImgeView.image = [UIImage imageNamed:@"successful_image"];
    [self addSubview:self.tipImgeView];
    
    [MJLabelManager setLabel:self.tipLabel
                        text:@"确认成功"
                   textColor:[UIColor whiteColor]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*40]];
    //self.tipLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.tipLabel];
}


- (void)setTip:(UIImage *)tipImage tipText:(NSString *)tipText{
    self.tipImgeView.image = tipImage;
    self.tipLabel.text = tipText;
}

- (UIView *)tipView{
    if (_tipView==nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*330)/2, em*582+64, em*330, em*320)];
    }
    return _tipView;
}

- (UIImageView *)tipImgeView{
    if (_tipImgeView==nil) {
        _tipImgeView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*100)/2, em*582+64+em*64, em*100, em*100)];
    }
    return _tipImgeView;
}

- (UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, em*582+64+em*212, SCREEN_WIDTH-4, em*45)];
    }
    return _tipLabel;
}




@end
