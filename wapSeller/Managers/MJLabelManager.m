//
//  MJLabelManager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJLabelManager.h"

@implementation MJLabelManager
+(void)attributeLabel:(UILabel *)label range:(NSRange)range{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [label setAttributedText:noteStr];
}

+(void)setLabel:(UILabel *)label text:(NSString *)text r:(CGFloat)r g:(CGFloat)g b:(CGFloat)b textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font{
    label.text = text;
    label.textColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    
    label.textAlignment = textAlignment;
    label.font = font;
}


+(void)setLabel:(UILabel *)label text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font{
    label.text = text;
    label.textColor = textColor;
    
    label.textAlignment = textAlignment;
    label.font = font;
}



+ (void)setLabel:(UILabel *)label text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)textFond borderColor:(UIColor *)borderCorder borderWidth:(CGFloat)borderWidth radius:(CGFloat)radius{
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.font = textFond;
    
    label.layer.borderColor  = borderCorder.CGColor;
    label.layer.borderWidth  = borderWidth;
    label.layer.cornerRadius = radius;
    label.layer.masksToBounds = YES;
    
}



+(void)setLineSpacing:(UILabel *)label str:(NSString *)labelStr{
    
    label.numberOfLines = 0;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:labelStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:SCREEN_WIDTH/375*4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [labelStr length])];
    [label setAttributedText:attributedString1];
    [label sizeToFit];
}
+(void)setLineSpacing:(UILabel *)label str:(NSString *)labelStr space:(CGFloat)lineSpacing{
    
    label.numberOfLines = 0;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:labelStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:lineSpacing];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [labelStr length])];
    [label setAttributedText:attributedString1];
    [label sizeToFit];
}

//计算UILabel的高度(带有行间距的情况)
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = SCREEN_WIDTH/375*4;//行间距4个像素
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
    
}
@end
