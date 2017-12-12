//
//  MJTxFieldManager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/27.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJTxFieldManager.h"

@implementation MJTxFieldManager
+ (void)setTxfield:(UITextField *)textField placeText:(NSString *)placeText textColor:(UIColor *)textColor font:(UIFont *)textFond{
    textField.textColor = textColor;
    textField.font      = textFond;
    
    textField.placeholder = placeText;
}
@end
