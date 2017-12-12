//
//  MJOutAlertView.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/10.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJOutAlertViewDelegate <NSObject>
- (void)outClick:(NSInteger)index;
@end

@interface MJOutAlertView : UIView
@property (nonatomic,weak)id<MJOutAlertViewDelegate>delegate;

- (void)outAlertShow;
- (void)outAlertHide;
@end
