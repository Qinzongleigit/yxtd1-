//
//  DetailedView.m
//  yxtd
//
//  Created by qin on 2017/10/31.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "DetailedView.h"
#import "StarView.h"

@implementation DetailedView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpView];
        
    }
    return self;
}

-(void)setUpView{
    
    _bgImageView=[[UIImageView alloc] init];
    _bgImageView.backgroundColor=[UIColor grayColor];
    _bgImageView.userInteractionEnabled=YES;
    [self addSubview:_bgImageView];
    
    _backBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [_backBt setBackgroundImage:[UIImage imageNamed:@"rightLoginImage"] forState:UIControlStateNormal];
    [_backBt addTarget:self action:@selector(btBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBt];
    
    _rightBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBt setBackgroundImage:[UIImage imageNamed:@"right_Run_Image"] forState:UIControlStateNormal];
    [_rightBt addTarget:self action:@selector(rightBtClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBt];
    
    
    _brandImageView=[[UIImageView alloc] init];
    _brandImageView.backgroundColor=[UIColor purpleColor];
    _brandImageView.layer.cornerRadius=72/2;
    _brandImageView.clipsToBounds=YES;
    [self addSubview:_brandImageView];
    
    _brandNameLabel=[[UILabel alloc] init];
    _brandNameLabel.text=@"STATERFELL";
    _brandNameLabel.textColor=[UIColor whiteColor];
    _brandNameLabel.font=[UIFont systemFontOfSize:15];
    [self addSubview:_brandNameLabel];
    
    _mapImageView=[[UIImageView alloc] init];
    _mapImageView.image=[UIImage imageNamed:@"map_Image"];
    [self addSubview:_mapImageView];
    
    _locationLabel=[[UILabel alloc] init];
    _locationLabel.text=@"深圳市西工业区23栋";
    _locationLabel.textColor=[UIColor whiteColor];
    _locationLabel.font=[UIFont systemFontOfSize:9];
    [self addSubview:_locationLabel];
    
    
    _namelabel=[[UILabel alloc] init];
    _namelabel.textColor=[UIColor whiteColor];
    _namelabel.text=@"10元现金券";
    _namelabel.font=[UIFont systemFontOfSize:20];
    [self addSubview:_namelabel];
    
    _lineView=[[UIView alloc] init];
    _lineView.backgroundColor=btnLineColor;
    [self addSubview:_lineView];
    
    
    _dateLabel=[[UILabel alloc] init];
    _dateLabel.text=@"有效期：2017-09-15   00：00   至2017-10-09   23：59";
    _dateLabel.textColor=[UIColor whiteColor];
    _dateLabel.font=[UIFont systemFontOfSize:12];
    _dateLabel.numberOfLines=0;
    [self addSubview:_dateLabel];
    
    
    
    _starBgView=[[UIView alloc] init];
    _starBgView.backgroundColor=[UIColor clearColor];
    [self addSubview:_starBgView];
    
    
    
    
    
}

//星星评分
-(void)setStatNum:(float)statNum{
    
    StarView*starVC=[[StarView alloc] initWithFrame:CGRectMake(0, 0, 80, 15) withFloatNum:statNum];
    [_starBgView addSubview:starVC];
    
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    __weak typeof(self) weakSelf=self;
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    [_backBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf).with.offset(16);
        make.top.equalTo(weakSelf).with.offset(32);
    }];
    
    
    [_rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(weakSelf).with.offset(-15);
        make.centerY.equalTo(_backBt);
    }];
    
    
    
    
    [_brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(33);
        make.top.equalTo(_backBt.mas_bottom).with.offset(22);
        make.size.mas_equalTo(CGSizeMake(72, 72));
    }];
    
    
    [_brandNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(_brandImageView);
        make.top.equalTo(_brandImageView.mas_bottom).with.offset(12);
    }];
    
    
    [_mapImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(23);
        make.bottom.equalTo(weakSelf).with.offset(-10);
    }];
    
    
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_mapImageView.mas_right).with.offset(6);
        make.centerY.equalTo(_mapImageView);
    }];
    
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-29);
        make.top.equalTo(_rightBt.mas_bottom).with.offset(42);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_brandImageView.mas_right).with.offset(26);
        make.right.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(_namelabel.mas_bottom).with.offset(12);
        make.height.equalTo(@1);
    }];
    
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_brandImageView.mas_right).with.offset(26);
        make.right.equalTo(weakSelf).with.offset(-45);
        make.top.equalTo(_lineView.mas_bottom).with.offset(14);
    }];
    
    [_starBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakSelf).with.offset(-5);
        make.bottom.equalTo(weakSelf).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];
}

-(void)btBack{
    
    self.backRunVC();
    
    
}


-(void)rightBtClick{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

}

@end
