//
//  MJBtnManager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJBtnManager.h"

@implementation MJBtnManager



+ (void)setButton:(UIButton *)button title:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)textFond borderColor:(UIColor *)borderCorder borderWidth:(CGFloat)borderWidth radius:(CGFloat)radius{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    
    button.layer.borderColor  = borderCorder.CGColor;
    button.layer.borderWidth  = borderWidth;
    button.layer.cornerRadius = radius;
    button.layer.masksToBounds= YES;
}

+ (void)setButton:(UIButton *)button text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)textFond image:(UIImage *)backImgage radius:(CGFloat)radius{
    
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    button.titleLabel.font    = textFond;
    
    [button setBackgroundImage:backImgage forState:UIControlStateNormal];
    button.layer.cornerRadius = radius;
    button.layer.masksToBounds= YES;
}
@end
