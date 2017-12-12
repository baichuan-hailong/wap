//
//  MJMyActivityDetailView.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/1.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJMyActivityDetailView : UIView
@property(nonatomic,strong)UITableView *activityDetailTableView;

//successful
@property(nonatomic,strong)MJSuccessfulPopView *successfulPopView;

//failed
@property(nonatomic,strong)MJFailedPopView     *failedPopView;
@end
