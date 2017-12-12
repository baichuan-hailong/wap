//
//  MJUpWaitingView.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/5.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJUpWaitingView : UIView
@property(nonatomic,strong)UIButton  *resetUpBtn;
- (void)upView:(BOOL)isSuccessful;
@end
