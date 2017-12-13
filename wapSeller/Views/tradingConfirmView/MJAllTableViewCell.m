//
//  MJAllTableViewCell.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/28.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJAllTableViewCell.h"

@interface MJAllTableViewCell()
@property (nonatomic, strong)UIImageView *logoImageView;
@property (nonatomic, strong)UILabel     *titleLabel;

//奖章
@property (nonatomic, strong)UIImageView *awardImageView;

//money
@property (nonatomic, strong)UILabel     *moneyLabel;
@property (nonatomic, strong)UILabel     *moneytipLabel;

//line
@property (nonatomic, strong)UIImageView *lineImageView;
@property (nonatomic, strong)UIImageView *line_lowImageView;

//交易数量
@property (nonatomic, strong)UILabel     *countTipLabel;
@property (nonatomic, strong)UILabel     *countLabel;

//交易编号
@property (nonatomic, strong)UILabel     *numTipLabel;
@property (nonatomic, strong)UILabel     *numLabel;

//买家ID
@property (nonatomic, strong)UILabel     *buyIDTipLabel;
@property (nonatomic, strong)UILabel     *buyIDLabel;

//买家返现
@property (nonatomic, strong)UILabel     *crashBackTipLabel;
@property (nonatomic, strong)UILabel     *crashBackLabel;

//买家扣款
@property (nonatomic, strong)UILabel     *seller_deducTipLabel;
@property (nonatomic, strong)UILabel     *seller_deducLabel;

//交易时间
@property (nonatomic, strong)UILabel     *transactTimeTipLabel;
@property (nonatomic, strong)UILabel     *transactTimeIDLabel;

//确认时间
@property (nonatomic, strong)UILabel     *sureTimeTipLabel;
@property (nonatomic, strong)UILabel     *sureTimeLabel;

@end

@implementation MJAllTableViewCell

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
        
        //奖章
        [self.contentView addSubview:self.awardImageView];
        
        //money
        [MJLabelManager setLabel:self.moneyLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"f91e1e"]
                   textAlignment:NSTextAlignmentCenter
                            font:[UIFont systemFontOfSize:em*69]];
        [self.contentView addSubview:self.moneyLabel];
        
        [MJLabelManager setLabel:self.moneytipLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"aaabbd"]
                   textAlignment:NSTextAlignmentCenter
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.moneytipLabel];
        
        //line
        [self.contentView addSubview:self.lineImageView];
        [self.contentView addSubview:self.line_lowImageView];
        
        //交易数量
        [MJLabelManager setLabel:self.countTipLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"aaabbd"]
                   textAlignment:NSTextAlignmentCenter
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.countTipLabel];
        
        [MJLabelManager setLabel:self.countLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"656572"]
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.countLabel];
        
        //交易编号
        [MJLabelManager setLabel:self.numTipLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"aaabbd"]
                   textAlignment:NSTextAlignmentCenter
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.numTipLabel];
        
        [MJLabelManager setLabel:self.numLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"656572"]
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.numLabel];
        
        //买家ID
        [MJLabelManager setLabel:self.buyIDTipLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"aaabbd"]
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.buyIDTipLabel];
        
        [MJLabelManager setLabel:self.buyIDLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"656572"]
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.buyIDLabel];
        
        //买家返现
        [MJLabelManager setLabel:self.crashBackTipLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"aaabbd"]
                   textAlignment:NSTextAlignmentCenter
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.crashBackTipLabel];
        
        [MJLabelManager setLabel:self.crashBackLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"656572"]
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.crashBackLabel];
        
        //买家扣款
        [MJLabelManager setLabel:self.seller_deducTipLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"aaabbd"]
                   textAlignment:NSTextAlignmentCenter
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.seller_deducTipLabel];
        
        [MJLabelManager setLabel:self.seller_deducLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"656572"]
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*38]];
        [self.contentView addSubview:self.seller_deducLabel];
        
        
        //交易时间
        [MJLabelManager setLabel:self.transactTimeTipLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"aaabbd"]
                   textAlignment:NSTextAlignmentCenter
                            font:[UIFont systemFontOfSize:em*34]];
        [self.contentView addSubview:self.transactTimeTipLabel];
        
        [MJLabelManager setLabel:self.transactTimeIDLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"aaabbd"]
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*34]];
        [self.contentView addSubview:self.transactTimeIDLabel];
        
        //确认时间
        [MJLabelManager setLabel:self.sureTimeTipLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"aaabbd"]
                   textAlignment:NSTextAlignmentCenter
                            font:[UIFont systemFontOfSize:em*34]];
        [self.contentView addSubview:self.sureTimeTipLabel];
        
        [MJLabelManager setLabel:self.sureTimeLabel
                            text:@"--"
                       textColor:[UIColor colorWithHex:@"aaabbd"]
                   textAlignment:NSTextAlignmentLeft
                            font:[UIFont systemFontOfSize:em*34]];
        [self.contentView addSubview:self.sureTimeLabel];
        
    }
    return self;
}



- (void)setWait:(NSDictionary *)waitDic isSure:(BOOL)isSureBool{
    self.logoImageView.image = [UIImage imageNamed:@"mechan_image"];
    
    if (isSureBool) {
        self.awardImageView.image = [UIImage imageNamed:@"award_sure_image"];
    }else{
        self.awardImageView.image = [UIImage imageNamed:@"award_depeat_image"];
    }
    
    self.titleLabel.text     = [NSString stringWithFormat:@"%@",waitDic[@"activityName"]];
    
    //money
    NSString *orderPrices = [NSString stringWithFormat:@"%@",waitDic[@"orderPrices"]];
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[orderPrices floatValue]];
    self.moneytipLabel.text = @"交易金额(元)";
    
    //交易数量
    self.countTipLabel.text = @"交易数量";
    //按金额 按交易量
    NSString *unitName = [NSString stringWithFormat:@"%@",waitDic[@"unitName"]];
    if ([unitName isNull]) {
        unitName = @"";
    }
    self.countLabel.text = [NSString stringWithFormat:@"%@ %@",waitDic[@"orderAmount"],unitName];
    
    
    
    //交易编号
    self.numTipLabel.text = @"交易编号";
    self.numLabel.text = [NSString stringWithFormat:@"%@",waitDic[@"oid"]];
    
    //买家ID
    self.buyIDTipLabel.text = @"买家账号";
    self.buyIDLabel.text = [NSString stringWithFormat:@"%@",waitDic[@"clientLoginNo"]];
    
    //买家返现
    self.crashBackTipLabel.text = @"买家返现";
    NSString *orderRebatePrices = [NSString stringWithFormat:@"%@",waitDic[@"orderRebatePrices"]];
    self.crashBackLabel.text = [NSString stringWithFormat:@"%.2f元",[orderRebatePrices floatValue]];
    
    //卖家扣款
    self.seller_deducTipLabel.text = @"卖家扣款";
    NSString *financialReceive = [NSString stringWithFormat:@"%@",waitDic[@"financialReceive"]];
    self.seller_deducLabel.text = [NSString stringWithFormat:@"%.2f元",[financialReceive floatValue]];
    
    //交易时间
    self.transactTimeTipLabel.text = @"交易时间";
    NSString *createDate = [NSString stringWithFormat:@"%@",waitDic[@"createDate"]];
    createDate = [NSString stringWithFormat:@"%ld",[createDate integerValue]/1000];
    self.transactTimeIDLabel.text = [self timeChange:createDate];
    
    //确认时间
    self.sureTimeTipLabel.text = @"确认时间";
    NSString *confirmDate = [NSString stringWithFormat:@"%@",waitDic[@"confirmDate"]];
    confirmDate = [NSString stringWithFormat:@"%ld",[confirmDate integerValue]/1000];
    self.sureTimeLabel.text = [self timeChange:confirmDate];
    
}


#pragma mark - 时间戳转换为标准时间
- (NSString *)timeChange:(NSString *)timeStamp {
    NSTimeInterval time = [timeStamp doubleValue];// + 28800;  //因为时差问题要加8小时 == 28800
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *currentDateStr = [formatter stringFromDate: date];
    return currentDateStr;
}



- (UIImageView *)logoImageView{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*33, em*60, em*62, em*62)];
    }
    return _logoImageView;
}


- (UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.logoImageView.frame)+em*22, em*60, SCREEN_WIDTH-em*300, em*62)];
    }
    return _titleLabel;
}

- (UIImageView *)awardImageView{
    if (_awardImageView==nil) {
        _awardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-em*35-em*186, 0, em*186, em*128)];
    }
    return _awardImageView;
}

//money
- (UILabel *)moneyLabel{
    if (_moneyLabel==nil) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+em*60, SCREEN_WIDTH, em*60)];
    }
    return _moneyLabel;
}

- (UILabel *)moneytipLabel{
    if (_moneytipLabel==nil) {
        _moneytipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.moneyLabel.frame)+em*18, SCREEN_WIDTH, em*35)];
    }
    return _moneytipLabel;
}

//dottedline_image
- (UIImageView *)lineImageView{
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*92, CGRectGetMaxY(self.titleLabel.frame)+em*235, SCREEN_WIDTH-em*184, 1)];
        _lineImageView.image = [UIImage imageNamed:@"dottedline_image"];
    }
    return _lineImageView;
}

- (UIImageView *)line_lowImageView{
    if (_line_lowImageView == nil) {
        _line_lowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(em*92, CGRectGetMaxY(self.lineImageView.frame)+em*275, SCREEN_WIDTH-em*184, 1)];
        _line_lowImageView.image = [UIImage imageNamed:@"dottedline_image"];
    }
    return _line_lowImageView;
}

//交易数量
- (UILabel *)countTipLabel{
    if (_countTipLabel==nil) {
        _countTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*92, CGRectGetMaxY(self.lineImageView.frame)+em*45, em*158, em*35)];
    }
    return _countTipLabel;
}

- (UILabel *)countLabel{
    if (_countLabel==nil) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.countTipLabel.frame)+em*25, CGRectGetMaxY(self.lineImageView.frame)+em*45, em*300, em*35)];
    }
    return _countLabel;
}


//交易编号
- (UILabel *)numTipLabel{
    if (_numTipLabel==nil) {
        _numTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*636, CGRectGetMaxY(self.lineImageView.frame)+em*45, em*158, em*35)];
    }
    return _numTipLabel;
}

- (UILabel *)numLabel{
    if (_numLabel==nil) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.numTipLabel.frame)+em*25, CGRectGetMaxY(self.lineImageView.frame)+em*45, em*300, em*35)];
    }
    return _numLabel;
}

//买家ID
- (UILabel *)buyIDTipLabel{
    if (_buyIDTipLabel==nil) {
        _buyIDTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*92, CGRectGetMaxY(self.countLabel.frame)+em*38, em*158, em*35)];
    }
    return _buyIDTipLabel;
}

- (UILabel *)buyIDLabel{
    if (_buyIDLabel==nil) {
        _buyIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.buyIDTipLabel.frame)+em*25, CGRectGetMaxY(self.countLabel.frame)+em*38, em*300, em*35)];
    }
    return _buyIDLabel;
}

//买家返现
- (UILabel *)crashBackTipLabel{
    if (_crashBackTipLabel==nil) {
        _crashBackTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*636, CGRectGetMaxY(self.countLabel.frame)+em*38, em*158, em*35)];
    }
    return _crashBackTipLabel;
}

- (UILabel *)crashBackLabel{
    if (_crashBackLabel==nil) {
        _crashBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.crashBackTipLabel.frame)+em*25, CGRectGetMaxY(self.countLabel.frame)+em*38, em*300, em*35)];
    }
    return _crashBackLabel;
}

//买家扣款
- (UILabel *)seller_deducTipLabel{
    if (_seller_deducTipLabel==nil) {
        _seller_deducTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*92, CGRectGetMaxY(self.buyIDLabel.frame)+em*38, em*158, em*35)];
    }
    return _seller_deducTipLabel;
}

- (UILabel *)seller_deducLabel{
    if (_seller_deducLabel==nil) {
        _seller_deducLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.seller_deducTipLabel.frame)+em*25, CGRectGetMaxY(self.buyIDLabel.frame)+em*38, em*300, em*35)];
    }
    return _seller_deducLabel;
}


//交易时间
- (UILabel *)transactTimeTipLabel{
    if (_transactTimeTipLabel==nil) {
        _transactTimeTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*92, CGRectGetMaxY(self.line_lowImageView.frame)+em*45, em*158, em*35)];
    }
    return _transactTimeTipLabel;
}

- (UILabel *)transactTimeIDLabel{
    if (_transactTimeIDLabel==nil) {
        _transactTimeIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.transactTimeTipLabel.frame)+em*20, CGRectGetMaxY(self.line_lowImageView.frame)+em*45, em*500, em*35)];
    }
    return _transactTimeIDLabel;
}

//确认时间
- (UILabel *)sureTimeTipLabel{
    if (_sureTimeTipLabel==nil) {
        _sureTimeTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(em*92, CGRectGetMaxY(self.transactTimeTipLabel.frame)+em*30, em*158, em*35)];
    }
    return _sureTimeTipLabel;
}

- (UILabel *)sureTimeLabel{
    if (_sureTimeLabel==nil) {
        _sureTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.sureTimeTipLabel.frame)+em*20, CGRectGetMaxY(self.transactTimeTipLabel.frame)+em*30, em*500, em*35)];
    }
    return _sureTimeLabel;
}


@end
