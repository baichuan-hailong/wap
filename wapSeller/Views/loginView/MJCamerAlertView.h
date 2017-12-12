//
//  MJCamerAlertView.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/4.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJCamerAlertView : UIView
@property(nonatomic, strong)UIButton *photoBtn;
@property(nonatomic, strong)UIButton *camerBtn;
@property(nonatomic, strong)UIButton *cancleBtn;


@property(nonatomic, strong)UIView *camerView;
- (void)show;
- (void)hide;

@end
