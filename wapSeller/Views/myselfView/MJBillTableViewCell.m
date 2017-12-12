//
//  MJBillTableViewCell.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJBillTableViewCell.h"

@interface MJBillTableViewCell()
@property(nonatomic,strong)UIImageView *typeImageView;
@property(nonatomic,strong)UILabel     *typeLabel;
@property(nonatomic,strong)UILabel     *timeLabel;
@property(nonatomic,strong)UILabel     *amountLabel;
@property(nonatomic,strong)UIImageView *arrowImageView;

@end

@implementation MJBillTableViewCell

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
        
        [self.contentView addSubview:self.typeImageView];
        
        
        [MJLabelManager setLabel:self.typeLabel
                            text:@"--"
                               r:44
                               g:44
                               b:53
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*48]];
        [self.contentView addSubview:self.typeLabel];
        
        [MJLabelManager setLabel:self.timeLabel
                            text:@"--"
                               r:128
                               g:128
                               b:139
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*34]];
        [self.contentView addSubview:self.timeLabel];
        
        [MJLabelManager setLabel:self.amountLabel
                            text:@"--"
                               r:44
                               g:44
                               b:53
                   textAlignment:NSTextAlignmentRight
                            font:[UIFont systemFontOfSize:em*60]];
        [self.contentView addSubview:self.amountLabel];
        
        
        [self.contentView addSubview:self.arrowImageView];
        
    }
    return self;
}

- (void)setBill:(NSDictionary *)billDic{
    
    NSString *tranType = [NSString stringWithFormat:@"%@",billDic[@"tranType"]];//方式
    NSString *amount = [NSString stringWithFormat:@"%@",billDic[@"amount"]];//amount
    if ([amount floatValue]<0) {
        self.amountLabel.text    = [NSString stringWithFormat:@"%.2f",[amount floatValue]];//amount
    }else{
        self.amountLabel.text    = [NSString stringWithFormat:@"+%.2f",[amount floatValue]];//amount
    }
    if ([tranType isEqualToString:@"信用还款"]||[tranType isEqualToString:@"服务费"]) {
        self.typeImageView.image = [UIImage imageNamed:@"typeTwo"];
    }else{
        self.typeImageView.image = [UIImage imageNamed:@"typeOne"];
    }
    
    self.typeLabel.text  = [NSString stringWithFormat:@"%@",billDic[@"tranType"]];//方式
    NSString *createDate = [NSString stringWithFormat:@"%@",billDic[@"createDate"]];//time
    createDate = [NSString stringWithFormat:@"%ld",[createDate integerValue]/1000];
    self.timeLabel.text      = [self timeChange:createDate];
    
}


- (UIImageView *)typeImageView{
    if (_typeImageView==nil) {
        _typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*35, em*50, em*128, em*128)];
    }
    return _typeImageView;
}

- (UILabel *)typeLabel{
    if (_typeLabel==nil) {
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.typeImageView.frame)+em*43, em*67, em*200, em*46)];
    }
    return _typeLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.typeImageView.frame)+em*43, CGRectGetMaxY(self.typeLabel.frame)+em*18, em*400, em*37)];
    }
    return _timeLabel;
}


- (UILabel *)amountLabel{
    if (_amountLabel==nil) {
        _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*92-em*500, em*85, em*500, em*62)];
    }
    return _amountLabel;
}

- (UIImageView *)arrowImageView{
    if (_arrowImageView==nil) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*19-em*36, em*(231-35)/2, em*19, em*35)];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_info"];
    }
    return _arrowImageView;
}

#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd hh:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}



@end
