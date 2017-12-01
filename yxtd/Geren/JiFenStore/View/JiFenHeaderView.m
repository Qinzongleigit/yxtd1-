//
//  JiFenHeaderView.m
//  yxtd
//
//  Created by qin on 2017/12/1.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "JiFenHeaderView.h"

@interface JiFenHeaderView ()

@property (nonatomic,strong) UIImageView*headeImageView;

@property (nonatomic,strong) UIButton*leftBt;

@property (nonatomic,strong) UIButton*rightBt;

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
    
    
}


-(void)leftBtBack{
    
    self.gotoBack();
    
}

-(void)jifenrightBt{
    
    self.jifenRight();
}


@end
