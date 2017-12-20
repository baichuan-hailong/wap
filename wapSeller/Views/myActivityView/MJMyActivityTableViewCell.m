//
//  MJMyActivityTableViewCell.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/26.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJMyActivityTableViewCell.h"

@interface MJMyActivityTableViewCell()
@property (nonatomic, strong)UIImageView *logoImageView;
@property (nonatomic, strong)UILabel     *titleLabel;
@property (nonatomic, strong)UILabel     *stateLable;

@property (nonatomic, strong)UILabel     *cashBackLable;
@property (nonatomic, strong)UILabel     *cashBackTipLable;
@property (nonatomic, strong)UILabel     *timeLable;

@property (nonatomic, strong)UIView      *middle_line;

@property (nonatomic, strong)UILabel     *salesTipLable;
@property (nonatomic, strong)UILabel     *salesLable;

@property (nonatomic, strong)UILabel     *serviceTipLable;
@property (nonatomic, strong)UILabel     *serviceLable;
@end

@implementation MJMyActivityTableViewCell

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
        
        [self.contentView addSubview:self.logoImageView];
        
        
        [MJLabelManager setLabel:self.titleLabel
                            text:@"- - -"
                               r:64
                               g:64
                               b:71
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*50]];
        [self.contentView addSubview:self.titleLabel];
        
        [MJLabelManager setLabel:self.stateLable
                            text:@"--"
                               r:62
                               g:184
                               b:46
                   textAlignment:NSTextAlignmentRight
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.stateLable];
        
        //self.titleLabel.backgroundColor = [UIColor redColor];
        //self.stateLable.backgroundColor = [UIColor orangeColor];
        
        [MJLabelManager setLabel:self.cashBackLable
                            text:@"-"
                               r:249
                               g:30
                               b:30
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*72]];
        [self.contentView addSubview:self.cashBackLable];
        
        
        [MJLabelManager setLabel:self.cashBackTipLable
                            text:@"- -"
                               r:153
                               g:153
                               b:169
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.cashBackTipLable];
        
        
        [MJLabelManager setLabel:self.timeLable
                            text:@"-- ---"
                               r:172
                               g:172
                               b:186
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.timeLable];
        
        //销售额
        [MJLabelManager setLabel:self.salesTipLable
                            text:@"--"
                               r:153
                               g:153
                               b:169
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.salesTipLable];
        
        [MJLabelManager setLabel:self.salesLable
                            text:@"---"
                               r:64
                               g:64
                               b:71
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*40]];
        [self.contentView addSubview:self.salesLable];
        
        //服务费
        [MJLabelManager setLabel:self.serviceTipLable
                            text:@"--"
                               r:153
                               g:153
                               b:169
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.serviceTipLable];
        
        [MJLabelManager setLabel:self.serviceLable
                            text:@"---"
                               r:64
                               g:64
                               b:71
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*40]];
        [self.contentView addSubview:self.serviceLable];
        
        
        
        
        self.middle_line.backgroundColor = [UIColor colorWithRed:223/255.0 green:224/255.0 blue:236/255.0 alpha:1];
        self.middle_line.alpha = 0.6;
        [self.contentView addSubview:self.middle_line];
        
        
    }
    return self;
}



- (void)setMyActivity:(NSDictionary *)activityDic{
    
    self.logoImageView.image = [UIImage imageNamed:@"merchant_image"];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",activityDic[@"activityName"]];
    
    
    NSString *shopActivityStatus = [NSString stringWithFormat:@"%@",activityDic[@"shopActivityStatus"]];
    NSInteger shopActivity_int = [shopActivityStatus integerValue];
    switch (shopActivity_int) {
        case -1:
            self.stateLable.text = @"已删除";
            self.stateLable.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
            break;
        case 0:
            self.stateLable.text = @"有效";
            self.stateLable.textColor = [UIColor colorWithRed:62/255.0 green:184/255.0 blue:46/255.0 alpha:1];
            break;
        case 1:
            self.stateLable.text = @"无效";
            self.stateLable.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
            break;
        case 2:
            self.stateLable.text = @"已下架";
            self.stateLable.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
            break;
        case 3:
            self.stateLable.text = @"未开始";
            self.stateLable.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
            break;
        case 4:
            self.stateLable.text = @"已结束";
            self.stateLable.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
            break;
            
        default:
            break;
    }
    
    /**
     NSString *onlineStatus = [NSString stringWithFormat:@"%@",activityDic[@"onlineStatus"]];
     if ([shopActivityStatus isEqualToString:@"上架"]) {
     self.stateLable.text = @"有效";
     self.stateLable.textColor = [UIColor colorWithRed:62/255.0 green:184/255.0 blue:46/255.0 alpha:1];
     }else{
     self.stateLable.text = @"无效";
     self.stateLable.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1];
     }
     **/
    
    //按金额 按交易量
    NSString *deductStyle = [NSString stringWithFormat:@"%@",activityDic[@"deductStyle"]];
    //NSLog(@"%@",deductStyle);
    NSString *buyerBackRate = [NSString stringWithFormat:@"%@",activityDic[@"buyerBackRate"]];
    NSLog(@"%@",buyerBackRate);
    if ([deductStyle isEqualToString:@"按金额"]) {
        self.cashBackLable.font= [UIFont systemFontOfSize:em*72];
        float  backratefl = [buyerBackRate floatValue];
        //NSLog(@"backratefl --- %f",backratefl);
        //NSLog(@"backratefl --- %f",backratefl*100);
        self.cashBackLable.text = [NSString stringWithFormat:@"%.2f%@",backratefl*100,@"%"];
    }else{
        self.cashBackLable.font= [UIFont systemFontOfSize:em*52];
        NSString *unitName = [NSString stringWithFormat:@"%@",activityDic[@"unitName"]];
        if ([unitName isNull]) {
            unitName = @" - ";
        }
        self.cashBackLable.text = [NSString stringWithFormat:@"每%@返现%.2f元",unitName,[buyerBackRate floatValue]];
    }
    
    self.cashBackTipLable.text = @"全场返现";
    //NSLog(@"activityStartDate --- %@",[self timeChange:@"1511927927"]);
    
    NSString *activityStartDate = [NSString stringWithFormat:@"%@",activityDic[@"activityStartDate"]];
    NSString *activityEndDate   = [NSString stringWithFormat:@"%@",activityDic[@"activityEndDate"]];
    
    activityStartDate = [NSString stringWithFormat:@"%ld",[activityStartDate integerValue]/1000];
    activityEndDate   = [NSString stringWithFormat:@"%ld",[activityEndDate integerValue]/1000];
    
    
    self.timeLable.text = [NSString stringWithFormat:@"有效期：%@-%@",[self timeChange:activityStartDate],[self timeChange:activityEndDate]];
    //销售额
    self.salesTipLable.text = @"销售额：";
    
    NSString *orderPrices = [NSString stringWithFormat:@"%@",activityDic[@"orderPrices"]];
    self.salesLable.text  = [NSString stringWithFormat:@"%.2f元",[orderPrices floatValue]];
    
    //服务费
    self.serviceTipLable.text = @"服务费：";
    NSString *shopReceive = [NSString stringWithFormat:@"%@",activityDic[@"shopReceive"]];//shopReceive financialReceive
    NSString *orderRebatePrices = [NSString stringWithFormat:@"%@",activityDic[@"orderRebatePrices"]];
    self.serviceLable.text = [NSString stringWithFormat:@"%.2f元",[shopReceive floatValue]-[orderRebatePrices floatValue]];
}

#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}

- (UIImageView *)logoImageView{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*33, em*50, em*62, em*62)];
        
    }
    return _logoImageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.logoImageView.frame)+em*26, em*50, SCREEN_WIDTH-em*320, em*62)];
    }
    return _titleLabel;
}

- (UILabel *)stateLable{
    if (_stateLable==nil) {
        _stateLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*33-em*150, em*60, em*150, em*37)];
    }
    return _stateLable;
}

- (UIView *)middle_line{
    if (_middle_line==nil) {
        _middle_line = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-1)/2, em*175, 1, em*127)];
    }
    return _middle_line;
}

//返现
- (UILabel *)cashBackLable{
    if (_cashBackLable==nil) {
        _cashBackLable = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.titleLabel.frame)+em*60, em*500, em*55)];
    }
    return _cashBackLable;
}

- (UILabel *)cashBackTipLable{
    if (_cashBackTipLable==nil) {
        _cashBackTipLable = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.cashBackLable.frame)+em*25, em*500, em*36)];
    }
    return _cashBackTipLable;
}




//time
- (UILabel *)timeLable{
    if (_timeLable==nil) {
        _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(em*35, CGRectGetMaxY(self.cashBackTipLable.frame)+em*35, em*800, em*31)];
    }
    return _timeLable;
}

//销售额
- (UILabel *)salesTipLable{
    if (_salesTipLable==nil) {
        _salesTipLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+em*25, em*188, em*160, em*35)];
    }
    return _salesTipLable;
}
- (UILabel *)salesLable{
    if (_salesLable==nil) {
        _salesLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.salesTipLable.frame), em*188, em*400, em*35)];
    }
    return _salesLable;
}


//服务费
- (UILabel *)serviceTipLable{
    if (_serviceTipLable==nil) {
        _serviceTipLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+em*25, CGRectGetMaxY(self.salesLable.frame)+em*23, em*160, em*35)];
    }
    return _serviceTipLable;
}
- (UILabel *)serviceLable{
    if (_serviceLable==nil) {
        _serviceLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.serviceTipLable.frame), CGRectGetMaxY(self.salesLable.frame)+em*23, em*400, em*35)];
    }
    return _serviceLable;
}



@end
