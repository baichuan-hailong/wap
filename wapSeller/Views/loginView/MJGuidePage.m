//
//  MJGuidePage.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/14.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJGuidePage.h"

@interface MJGuidePage()
@property(nonatomic, strong)UIScrollView *up_scrollView;

@property(nonatomic, strong)UIView            *oneView;
@property(nonatomic, strong)UIImageView       *backOneImageView;
@property(nonatomic, strong)UIImageView       *contentOneImageView;
@property(nonatomic, strong)UIImageView       *wenziOneImageView;
@property(nonatomic, strong)UIImageView       *jinduOneImageView;

@property(nonatomic, strong)UIView            *twoView;
@property(nonatomic, strong)UIImageView       *backTwoImageView;
@property(nonatomic, strong)UIImageView       *contentTwoImageView;
@property(nonatomic, strong)UIImageView       *wenziTwoImageView;
@property(nonatomic, strong)UIImageView       *jinduTwoImageView;

@property(nonatomic, strong)UIView            *threeView;
@property(nonatomic, strong)UIImageView       *backThreeImageView;
@property(nonatomic, strong)UIImageView       *contentThreeImageView;
@property(nonatomic, strong)UIImageView       *wenziThreeImageView;
@property(nonatomic, strong)UIImageView       *jinduThreeImageView;

@property(nonatomic, strong)UIView            *fourView;
@end

@implementation MJGuidePage


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (void)addUI{
    
    self.up_scrollView.backgroundColor = [UIColor whiteColor];
    self.up_scrollView.showsHorizontalScrollIndicator = NO;
    self.up_scrollView.pagingEnabled = YES;
    self.up_scrollView.alwaysBounceHorizontal = NO;
    self.up_scrollView.alwaysBounceVertical = NO;
    [self addSubview:self.up_scrollView];
    
    [self.up_scrollView addSubview:self.oneView];
    [self.up_scrollView addSubview:self.twoView];
    [self.up_scrollView addSubview:self.threeView];
    
    
    //one
    self.backOneImageView.image = [UIImage imageNamed:@"backImag"];
    [self.oneView addSubview:self.backOneImageView];
    
    self.contentOneImageView.image = [UIImage imageNamed:@"contentOne"];
    [self.oneView addSubview:self.contentOneImageView];
    
    self.wenziOneImageView.image = [UIImage imageNamed:@"wentiOne"];
    [self.oneView addSubview:self.wenziOneImageView];
    
    self.jinduOneImageView.image = [UIImage imageNamed:@"jinduOne"];
    [self.oneView addSubview:self.jinduOneImageView];
    
    //two
    self.backTwoImageView.image = [UIImage imageNamed:@"backImag"];
    [self.twoView addSubview:self.backTwoImageView];
    
    self.contentTwoImageView.image = [UIImage imageNamed:@"contentTwo"];
    [self.twoView addSubview:self.contentTwoImageView];
    
    self.wenziTwoImageView.image = [UIImage imageNamed:@"wenzitwo"];
    [self.twoView addSubview:self.wenziTwoImageView];
    
    self.jinduTwoImageView.image = [UIImage imageNamed:@"jinduTwo"];
    [self.twoView addSubview:self.jinduTwoImageView];
    
    //three
    self.backThreeImageView.image = [UIImage imageNamed:@"backImag"];
    self.backThreeImageView.layer.masksToBounds = YES;
    [self.threeView addSubview:self.backThreeImageView];
    
    self.contentThreeImageView.image = [UIImage imageNamed:@"contentThree"];
    self.contentThreeImageView.layer.masksToBounds = YES;
    [self.threeView addSubview:self.contentThreeImageView];
    
    self.wenziThreeImageView.image = [UIImage imageNamed:@"wenzithree"];
    [self.threeView addSubview:self.wenziThreeImageView];
    
    self.jinduThreeImageView.image = [UIImage imageNamed:@"jinduthree"];
    [self.threeView addSubview:self.jinduThreeImageView];
    
    //self.startBtn.backgroundColor = [UIColor redColor];
    [MJBtnManager setButton:self.startBtn
                       text:@"立即体验"
                  textColor:[UIColor whiteColor]
                       font:[UIFont systemFontOfSize:em*48]
                      image:[UIImage imageWithColor:[UIColor colorWithHex:primaryColor]]
                     radius:em*45];
    [self.threeView addSubview:self.startBtn];
    
    //four
    self.fourView.backgroundColor = [UIColor whiteColor];
    [self.up_scrollView addSubview:self.fourView];
}


- (UIScrollView *)up_scrollView{
    if (_up_scrollView==nil) {
        _up_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _up_scrollView.contentSize = CGSizeMake(3*SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _up_scrollView;
}


/*****  one *****/
- (UIView *)oneView{
    if (_oneView==nil) {
        _oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _oneView;
}
- (UIImageView *)backOneImageView{
    if (_backOneImageView==nil) {
        _backOneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1242*1624)];
    }
    return _backOneImageView;
}
- (UIImageView *)contentOneImageView{
    if (_contentOneImageView==nil) {
        _contentOneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, em*1422, em*1445)];
    }
    return _contentOneImageView;
}
- (UIImageView *)wenziOneImageView{
    if (_wenziOneImageView==nil) {
        _wenziOneImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*551)/2, SCREEN_HEIGHT-em*50-em*8-em*276-em*85, em*551, em*85)];
    }
    return _wenziOneImageView;
}
- (UIImageView *)jinduOneImageView{
    if (_jinduOneImageView==nil) {
        _jinduOneImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*206)/2, SCREEN_HEIGHT-em*75-em*8, em*206, em*8)];
    }
    return _jinduOneImageView;
}
/*****  one *****/




/*****  two *****/
- (UIView *)twoView{
    if (_twoView==nil) {
        _twoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _twoView;
}
- (UIImageView *)backTwoImageView{
    if (_backTwoImageView==nil) {
        _backTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1242*1624)];
    }
    return _backTwoImageView;
}

- (UIImageView *)contentTwoImageView{
    if (_contentTwoImageView==nil) {
        _contentTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, em*1324, em*1445)];
    }
    return _contentTwoImageView;
}

- (UIImageView *)wenziTwoImageView{
    if (_wenziTwoImageView==nil) {
        _wenziTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*730)/2, SCREEN_HEIGHT-em*50-em*8-em*276-em*85, em*730, em*173)];
    }
    return _wenziTwoImageView;
}

- (UIImageView *)jinduTwoImageView{
    if (_jinduTwoImageView==nil) {
        _jinduTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*206)/2, SCREEN_HEIGHT-em*75-em*8, em*206, em*8)];
    }
    return _jinduTwoImageView;
}
/*****  two *****/



/*****  three *****/
- (UIView *)threeView{
    if (_threeView==nil) {
        _threeView = [[UIView alloc] initWithFrame:CGRectMake(2*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _threeView;
}
- (UIImageView *)backThreeImageView{
    if (_backThreeImageView==nil) {
        _backThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1242*1624)];
    }
    return _backThreeImageView;
}

- (UIImageView *)contentThreeImageView{
    if (_contentThreeImageView==nil) {
        _contentThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-em*90, 0, em*1489, em*1649)];
    }
    return _contentThreeImageView;
}

- (UIImageView *)wenziThreeImageView{
    if (_wenziThreeImageView==nil) {
        _wenziThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*914)/2, SCREEN_HEIGHT-em*50-em*8-em*276-em*85-em*50, em*914, em*84)];
    }
    return _wenziThreeImageView;
}

- (UIImageView *)jinduThreeImageView{
    if (_jinduThreeImageView==nil) {
        _jinduThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*206)/2, SCREEN_HEIGHT-em*75-em*8, em*206, em*8)];
    }
    return _jinduThreeImageView;
}
/*****  three *****/


- (UIButton *)startBtn{
    if (_startBtn==nil) {
        _startBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-em*324)/2, CGRectGetMaxY(self.wenziThreeImageView.frame)+em*100, em*324, em*90)];
    }
    return _startBtn;
}
/*****  three *****/
- (UIView *)fourView{
    if (_fourView==nil) {
        _fourView = [[UIView alloc] initWithFrame:CGRectMake(3*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _fourView;
}


@end
