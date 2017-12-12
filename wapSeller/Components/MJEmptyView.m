//
//  MJEmptyView.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/3.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJEmptyView.h"
@interface MJEmptyView()
@property(nonatomic,strong)UIImageView *emptyImageView;
@property(nonatomic,strong)UILabel     *emptyLabel;
@end

@implementation MJEmptyView
//empy_list_image

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    //self.backgroundColor = [UIColor colorWithHex:primaryColor];
    [self addSubview:self.emptyImageView];
    
    [MJLabelManager setLabel:self.emptyLabel
                        text:@"暂无内容 多多参与"
                   textColor:[UIColor colorWithHex:@"737483"]
               textAlignment:NSTextAlignmentCenter
                        font:[UIFont systemFontOfSize:em*42]];
    //self.tipLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.emptyLabel];
}

//empty
- (UIImageView *)emptyImageView{
    if (_emptyImageView==nil) {
        _emptyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*416)/2, em*315, em*416, em*395)];
        _emptyImageView.image = [UIImage imageNamed:@"empy_list_image"];
    }
    return _emptyImageView;
}

- (UILabel *)emptyLabel{
    if (_emptyLabel==nil) {
        _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emptyImageView.frame)+em*101, SCREEN_WIDTH, em*50)];
    }
    return _emptyLabel;
}
@end
