//
//  DetailHeaderView.m
//  yxtd
//
//  Created by qin on 2018/2/6.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "DetailHeaderView.h"

@interface DetailHeaderView ()

@property (nonatomic,strong) UIImageView*bgImageView;

@property (nonatomic,strong) UIButton*detailBackBt;

@property (nonatomic,strong) UIButton*guanzhuBt;

@property (nonatomic,strong) UIImageView*iconImage;

@property (nonatomic,strong) UILabel*nickNamelabel;

@property (nonatomic,strong)UILabel*guanzhulabel;

@property (nonatomic,strong) UILabel*guanzhuNunberlabel;

@property (nonatomic,strong) UILabel*fansLabel;

@property (nonatomic,strong) UILabel*fansNumberlabel;

@end

@implementation DetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self makeDetailHeaderView];
    }
    
    return self;
}



#pragma mark -详情页头部视图5
-(void)makeDetailHeaderView{
    
    _bgImageView=[[UIImageView alloc] initWithFrame:self.bounds];
    _bgImageView.image=[UIImage imageWithoriginName:@"jifenheader_Image"];
    [self addSubview:_bgImageView];
    
    _detailBackBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [_detailBackBt setBackgroundImage:[UIImage imageWithoriginName:@"leftLoginImage"] forState:UIControlStateNormal];
    [_detailBackBt addTarget:self action:@selector(detailBtBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_detailBackBt];
    
    
    
    
}

#pragma mark -返回上一级页面
-(void)detailBtBack{
    
    
    
}



@end
