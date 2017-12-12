//
//  UIColor+UIColor_Util.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColor_Util)

+ (UIColor *) colorWithHex:(NSString *)hexColor;
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithARGB:(NSInteger)ARGBValue;
-(CGFloat)red;
-(CGFloat)green;
-(CGFloat)blue;
-(CGFloat)alpha;
-(int)rgb;
-(NSString*)webRgb;
-(NSString*)toWebString;
+(UIColor*)fromWebString:(NSString*)str;

@end



void BkLog_UIColor(UIColor * c);
UIColor* rgb255(int r,int g,int b,int a);
void CGContextSetStrokeColorWithUIColor(CGContextRef ctx,UIColor * color);
void CGContextSetFillColorWithUIColor(CGContextRef ctx,UIColor * color);
void CGContextDrawRoundRect(CGContextRef context ,CGRect rect,float radius ,CGPathDrawingMode mode);
