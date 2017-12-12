//
//  MJSelectTableViewCell.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/27.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJSelectTableViewCell.h"

@interface MJSelectTableViewCell()

@property(nonatomic,strong)UILabel     *selectLabel;

@end

@implementation MJSelectTableViewCell

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
        
        [MJLabelManager setLabel:self.selectLabel
                            text:@"--"
                               r:129
                               g:129
                               b:149
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*44]];
        [self.contentView addSubview:self.selectLabel];
        
    }
    return self;
}

- (void)setSelect:(NSDictionary *)selectDic{
    if (selectDic!=nil) {
        self.selectLabel.text = [NSString stringWithFormat:@"%@",selectDic[@"marketName"]];
    }
    
}

- (UILabel *)selectLabel{
    if (_selectLabel==nil) {
        _selectLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*40, em*25, em*500, em*100)];
    }
    return _selectLabel;
}


@end
