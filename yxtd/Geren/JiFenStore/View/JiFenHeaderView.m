//
//  JiFenHeaderView.m
//  yxtd
//
//  Created by qin on 2017/12/1.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "JiFenHeaderView.h"
#import "UICountingLabel.h"

@interface JiFenHeaderView ()

@property (nonatomic,strong) UIImageView*headeImageView;

@property (nonatomic,strong) UIButton*leftBt;

@property (nonatomic,strong) UIButton*rightBt;
@property (nonatomic,strong) UILabel*jifenTitle;

@property (nonatomic,strong) UICountingLabel*jifenNumberLabel;

@property (nonatomic,assign) NSInteger ratio;


@end

@implementation JiFenHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self headerUI];
    }
    
    return self;
}

#pragma mark -创建头部视图
-(void)headerUI{
    
    UIImageView*headerImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, self.height+20)];
    headerImageView.backgroundColor=[UIColor grayColor];
    [self addSubview:headerImageView];
    
    UIButton*leftBt=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBt=leftBt;
    [leftBt setBackgroundImage:[UIImage imageWithoriginName:@"leftLoginImage"] forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(leftBtBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBt];
    
    
    UIButton*rightBt=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBt=rightBt;
    [rightBt setBackgroundImage:[UIImage imageWithoriginName:@"wenhao_Image"] forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(jifenrightBt) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBt];
    
    UILabel*jifenTitle=[[UILabel alloc] init];
    jifenTitle.text=@"积分商城";
    self.jifenTitle=jifenTitle;
    jifenTitle.font=[UIFont systemFontOfSize:15];
    [jifenTitle setTextColor:[UIColor whiteColor]];
    [self addSubview:jifenTitle];
    
    
    //不能用定时器来做，时间太慢了，用封装一个label
    UICountingLabel *jifenNumberLabel = [[UICountingLabel alloc] init];
    self.jifenNumberLabel=jifenNumberLabel;
    jifenNumberLabel.font = [UIFont fontWithName:@"Avenir Next" size:48];
    jifenNumberLabel.textColor = [UIColor whiteColor];
    [self addSubview:jifenNumberLabel];
    //设置格式
    jifenNumberLabel.format = @"%d";
    //设置变化范围及动画时间
    [jifenNumberLabel countFrom:0 to:1000 withDuration:2.0f];
    

    
   
  
    
}






#pragma mark -坐标
-(void)layoutSubviews{
    
    
    [self.leftBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(32);
        
    }];
    
    [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.leftBt);
        make.right.equalTo(self).offset(-15);
    }];
    
    [self.jifenTitle mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.leftBt);
    }];
    
    [self.jifenNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.jifenTitle);
        make.top.equalTo(self.jifenTitle.mas_bottom).offset(10);
    }];
    
}




-(void)leftBtBack{
    
    self.gotoBack();
    
}

-(void)jifenrightBt{
    
    self.jifenRight();
}



@end
