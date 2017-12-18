//
//  SuccessDuiHuanAlter.m
//  yxtd
//
//  Created by qin on 2017/12/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "SuccessDuiHuanAlter.h"

@interface SuccessDuiHuanAlter ()

@end

@implementation SuccessDuiHuanAlter


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self setUpSuccessDuiHuanAlter];
    }
    return self;
}


#pragma mark -创建兑换成功后提示框
-(void)setUpSuccessDuiHuanAlter{
 
    UIImageView*wenhaoImageView=[[UIImageView alloc] init];
    wenhaoImageView.image=[UIImage imageNamed:@"alter_dagou_Image"];
    wenhaoImageView.layer.cornerRadius=64/2;
    wenhaoImageView.clipsToBounds=YES;
    [self addSubview:wenhaoImageView];
    
    [wenhaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(25);
    }];
    
    
    UILabel *successLabel = [[UILabel alloc] init];
    successLabel.text=@"兑换成功";
    successLabel.font=[UIFont systemFontOfSize:15];
    successLabel.textColor=BlackHexColor;
    [self addSubview:successLabel];
    [successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(wenhaoImageView.mas_bottom).offset(6);
        make.centerX.mas_equalTo(self);
        
    }];
    
    
    
    UILabel *successNameLabel = [[UILabel alloc] init];
    successNameLabel.text=@"运动吸汗毛巾";
    successNameLabel.font=[UIFont systemFontOfSize:15];
    successNameLabel.textColor=BlackHexColor;
    [self addSubview:successNameLabel];
    
    [successNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(wenhaoImageView.mas_bottom).offset(40);
        make.centerX.mas_equalTo(self);
        
    }];
    
    
    
   
    UILabel *jifenSuccessLabel = [[UILabel alloc] init];
    jifenSuccessLabel.text=@"450积分";
    jifenSuccessLabel.font=[UIFont systemFontOfSize:24];
    jifenSuccessLabel.textColor=[UIColor redColor];
    [self addSubview:jifenSuccessLabel];
    [jifenSuccessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(successNameLabel.mas_bottom).offset(24);
        make.centerX.mas_equalTo(self);
        
    }];
    
    
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"分 享" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancleBtn.layer.cornerRadius = 19;
    cancleBtn.tag=100;
    [cancleBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleBtn];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(jifenSuccessLabel.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(SYRealValueWidth(205), 37));
    }];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:COLORWITHRGB(0, 219, 220)];
    sureBtn.layer.cornerRadius = 19;
    
    [sureBtn addTarget:self action:@selector(successSureAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(cancleBtn.mas_bottom).offset(20);
        make.size.mas_equalTo(cancleBtn);
    }];
    
}

#pragma mark -分享
-(void)shareAction{
    
    
    self.alterSuccessBtClick();

    
}

#pragma mark-成功兑换
-(void)successSureAction{
    
    self.alterSuccessBtClick();
    
}


@end
