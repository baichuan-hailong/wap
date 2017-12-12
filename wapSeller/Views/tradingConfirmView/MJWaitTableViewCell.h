//
//  MJWaitTableViewCell.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/28.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJWaitTableViewCell : UITableViewCell

@property (nonatomic, strong)UIButton     *cancleBtn;
@property (nonatomic, strong)UIButton     *sureBtn;

- (void)setWait:(NSDictionary *)waitDic;
@end
