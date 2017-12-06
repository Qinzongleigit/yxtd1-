//
//  OverDuihuanCell.m
//  yxtd
//
//  Created by qin on 2017/12/6.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "OverDuihuanCell.h"


@interface OverDuihuanCell()

@property (nonatomic,strong) UIImageView*mainImageView;
@property (nonatomic,strong) UILabel*jifenLabel;
@property (nonatomic,strong) UILabel*moneyLabel;
@property (nonatomic,strong) UILabel*nameLabe;
@property (nonatomic,strong) UIButton*duihuanBt;
@property (nonatomic,strong) UILabel*overLabel;
@end

@implementation OverDuihuanCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self creatCell];
    }
    
    return self;
    
}


-(void)creatCell{
    
    UIImageView*mainImageView=[[UIImageView alloc] init];
    self.mainImageView=mainImageView;
    mainImageView.backgroundColor=[UIColor redColor];
    mainImageView.layer.cornerRadius=5;
    mainImageView.clipsToBounds=YES;
    [self addSubview:mainImageView];
    
    UILabel*overLabel=[[UILabel alloc] init];
    self.overLabel=overLabel;
    overLabel.text=@"已兑换";
    overLabel.textColor=[UIColor whiteColor];
    overLabel.font=[UIFont systemFontOfSize:15];
    [mainImageView addSubview:overLabel];
    
    UILabel*jifenLabel=[[UILabel alloc] init];
    self.jifenLabel=jifenLabel;
    jifenLabel.text=@"5000积分";
    jifenLabel.textColor=BlackHexColor;
    jifenLabel.font=[UIFont systemFontOfSize:9];
    [self addSubview:jifenLabel];
    
    UILabel*moneyLabel=[[UILabel alloc] init];
    self.moneyLabel=moneyLabel;
    moneyLabel.text=@"+20";
    moneyLabel.textColor=BlackHexColor;
    moneyLabel.font=[UIFont systemFontOfSize:9];
    [self addSubview:moneyLabel];
    
    
    UILabel*nameLabe=[[UILabel alloc] init];
    self.nameLabe=nameLabe;
    nameLabe.text=@"智能运动手环";
    nameLabe.textColor=BlackHexColor;
    nameLabe.font=[UIFont systemFontOfSize:15];
    [self addSubview:nameLabe];
    
    UIButton*duihuanBt=[UIButton buttonWithType:UIButtonTypeCustom];
    self.duihuanBt=duihuanBt;
    [duihuanBt setTitle:@"兑换" forState:UIControlStateNormal];
    [duihuanBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [duihuanBt setBackgroundColor:[UIColor lightGrayColor]];
    duihuanBt.titleLabel.font=[UIFont systemFontOfSize:12];
    duihuanBt.layer.cornerRadius=11;
    duihuanBt.clipsToBounds=YES;
    duihuanBt.enabled=NO;
    
    [self addSubview:duihuanBt];
    
}


-(void)layoutSubviews{
    
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(25);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(SYRealValueHeight(101));
    }];
    
    
    [self.overLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self.mainImageView);
       
    }];
    
    [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mainImageView. mas_left).offset(20);
        make.top.equalTo(self.mainImageView.mas_bottom).offset(5);
        
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.jifenLabel);
        make.left.equalTo(self.jifenLabel.mas_right).offset(1);
    }];
    
    
    
    [self.nameLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mainImageView);
        make.top.equalTo(self.jifenLabel.mas_bottom).offset(5);
    }];
    
    [self.duihuanBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerX.equalTo(self.mainImageView);
        make.top.equalTo(self.nameLabe.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(SYRealValueWidth(78), 23));
    }];
    
}




@end
