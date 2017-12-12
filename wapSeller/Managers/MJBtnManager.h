//
//  MJBtnManager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJBtnManager : NSObject
+ (void)setButton:(UIButton *)button title:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)textFond borderColor:(UIColor *)borderCorder borderWidth:(CGFloat)borderWidth radius:(CGFloat)radius;


//背景图片
+ (void)setButton:(UIButton *)button text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)textFond image:(UIImage *)backImgage radius:(CGFloat)radius;
@end
