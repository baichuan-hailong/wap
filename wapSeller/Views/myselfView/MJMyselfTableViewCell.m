//
//  MJMyselfTableViewCell.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/24.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMyselfTableViewCell.h"


@interface MJMyselfTableViewCell()
@property(nonatomic,strong)UIImageView *tipImageView;
@property(nonatomic,strong)UILabel     *tipLabel;
@property(nonatomic,strong)UIImageView *arrowImageView;
@end


@implementation MJMyselfTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor                 = [UIColor whiteColor];
        
        [self.contentView addSubview:self.tipImageView];
        
        
        [MJLabelManager setLabel:self.tipLabel
                            text:@"--"
                               r:44
                               g:44
                               b:53
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*44]];
        [self.contentView addSubview:self.tipLabel];
        
        
        self.line_view.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:0.8];
        self.line_view.alpha = 1;
        [self.contentView addSubview:self.line_view];
        
        [self.contentView addSubview:self.arrowImageView];
       
    }
    return self;
}


- (void)setMysel:(NSDictionary *)myDic{
    
    //@"image":@"account_info",@"text":@"账单"
    self.tipImageView.image = [UIImage imageNamed:[myDic valueForKey:@"image"]];
    self.tipLabel.text      = [NSString stringWithFormat:@"%@", [myDic valueForKey:@"text"]];
}

//lazy
- (UIImageView *)tipImageView{
    if (_tipImageView==nil) {
        _tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*30, em*66, em*48, em*48)];
    }
    return _tipImageView;
}

//arrow_info 19 35
- (UIImageView *)arrowImageView{
    if (_arrowImageView==nil) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*19-em*30, em*72.5, em*19, em*35)];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_info"];
    }
    return _arrowImageView;
}

- (UILabel *)tipLabel{
    if (_tipLabel==nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*114, em*40, em*260, em*100)];
    }
    return _tipLabel;
}

- (UIView *)line_view{
    if (_line_view==nil) {
        _line_view = [[UIView alloc] initWithFrame:CGRectMake(em*114, em*180-1, SCREEN_WIDTH-em*114, 0.5)];
    }
    return _line_view;
}

@end
