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

@property (nonatomic,strong) UIView*lineView;

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
    
    
    _guanzhuBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [_guanzhuBt setBackgroundImage:[UIImage imageWithoriginName:@"leftLoginImage"] forState:UIControlStateNormal];
    [_guanzhuBt addTarget:self action:@selector(guanzhuBtAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_guanzhuBt];
    
    
    _iconImage=[[UIImageView alloc] init];
    _iconImage.layer.cornerRadius=46/2;
    _iconImage.clipsToBounds=YES;
    _iconImage.backgroundColor=[UIColor purpleColor];
    [self addSubview:_iconImage];
    
    
    _nickNamelabel=[[UILabel alloc] init];
    _nickNamelabel.text=@"跑券官方";
    _nickNamelabel.textColor=[UIColor whiteColor];
    _nickNamelabel.font=[UIFont systemFontOfSize:15];
    [self addSubview:_nickNamelabel];
    
    
    _guanzhulabel=[[UILabel alloc] init];
    _guanzhulabel.text=@"关注";
    _guanzhulabel.textColor=[UIColor whiteColor];
    _guanzhulabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:_guanzhulabel];
    
    
    _guanzhuNunberlabel=[[UILabel alloc] init];
    _guanzhuNunberlabel.text=@"213";
    _guanzhuNunberlabel.textColor=[UIColor whiteColor];
    _guanzhuNunberlabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:_guanzhuNunberlabel];
    
    
    _lineView=[[UIView alloc] init];
    _lineView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_lineView];
    
    
    _fansLabel=[[UILabel alloc] init];
    _fansLabel.text=@"粉丝";
    _fansLabel.textColor=[UIColor whiteColor];
    _fansLabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:_fansLabel];
    
    _fansNumberlabel=[[UILabel alloc] init];
    _fansNumberlabel.text=@"6907";
    _fansNumberlabel.textColor=[UIColor whiteColor];
    _fansNumberlabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:_fansNumberlabel];
    
    
    
}


//位置坐标
-(void)layoutSubviews{
    
    [_detailBackBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(14);
        make.top.mas_equalTo(32);
    }];
    
    [_guanzhuBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.detailBackBt);
        make.right.mas_equalTo(-15);
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(46, 46));
        make.top.mas_equalTo(self.guanzhuBt.mas_bottom).offset(8);
        
    
    }];
    
    
    [_nickNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.iconImage);
        make.top.mas_equalTo(self.iconImage.mas_bottom).offset(8);
    }];
    
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.nickNamelabel);
        make.top.mas_equalTo(self.nickNamelabel.mas_bottom).offset(22);

        
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(self.fansLabel.mas_height);
    }];
    
    
    [_guanzhulabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.lineView);
        make.right.mas_equalTo(self.lineView.mas_left).offset(-25);
    }];
    
    
    [_guanzhuNunberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.guanzhulabel);
        make.top.mas_equalTo(self.guanzhulabel.mas_bottom).offset(13);
    }];
    
    
    [_fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(self.lineView);
        make.left.mas_equalTo(self.lineView.mas_right).offset(25);
    
        
    }];
    
    [_fansNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.fansLabel);
        make.top.mas_equalTo(self.fansLabel.mas_bottom).offset(13);
    }];
    
    
}



#pragma mark -关注按钮点击
-(void)guanzhuBtAction{
    
    
    
    
}

#pragma mark -返回上一级页面
-(void)detailBtBack{
    
    self.buttonBackBlock();
    
    
    
}



@end
