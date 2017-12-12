//
//  MJBaseViewController.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJEmptyView.h"

@interface MJBaseViewController : UIViewController
/*empty*/
@property(nonatomic,strong)MJEmptyView *emptyView;
@property(nonatomic,strong)MJEmptyView *emptyView_o;
@property(nonatomic,strong)MJEmptyView *emptyView_t;

- (void)goBackAction;


- (void)hideBack;
- (void)addAction;
@end
