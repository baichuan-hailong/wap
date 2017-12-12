//
//  MJLabelManager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJLabelManager : NSObject
+(void)setLineSpacing:(UILabel *)label str:(NSString *)labelStr;
+(void)setLineSpacing:(UILabel *)label str:(NSString *)labelStr space:(CGFloat)lineSpacing;
+(void)attributeLabel:(UILabel *)label range:(NSRange)range;


+(void)setLabel:(UILabel *)label text:(NSString *)text r:(CGFloat)r g:(CGFloat)g b:(CGFloat)b textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font;


+(void)setLabel:(UILabel *)label text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font;


+ (void)setLabel:(UILabel *)label text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)textFond borderColor:(UIColor *)borderCorder borderWidth:(CGFloat)borderWidth radius:(CGFloat)radius;
@end
