//
//  CanDuihuanCell.m
//  yxtd
//
//  Created by qin on 2017/12/6.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "CanDuihuanCell.h"
#import "DuiHuanAlter.h"
#import "UIImageView+WebCache.h"

@interface CanDuihuanCell()

@property (nonatomic,strong) UIImageView*mainImageView;
@property (nonatomic,strong) UILabel*jifenLabel;
@property (nonatomic,strong) UILabel*moneyLabel;
@property (nonatomic,strong) UILabel*nameLabe;
@property (nonatomic,strong) UIButton*duihuanBt;

@property (nonatomic,strong) DuiHuanAlter*alterView;

@property (nonatomic,assign) NSIndexPath *row;//当前第是几个item

@end

@implementation CanDuihuanCell

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
    mainImageView.backgroundColor=[UIColor clearColor];
    mainImageView.layer.cornerRadius=5;
    mainImageView.clipsToBounds=YES;
    [self addSubview:mainImageView];
    
    
    
    UILabel*jifenLabel=[[UILabel alloc] init];
    self.jifenLabel=jifenLabel;
    jifenLabel.text=@"5000积分";
    jifenLabel.textColor=BlackHexColor;
    jifenLabel.font=[UIFont systemFontOfSize:9];
    [self addSubview:jifenLabel];
    
//    UILabel*moneyLabel=[[UILabel alloc] init];
//    self.moneyLabel=moneyLabel;
//    moneyLabel.text=@"+20元";
//    moneyLabel.textColor=BlackHexColor;
//    moneyLabel.font=[UIFont systemFontOfSize:9];
//    [self addSubview:moneyLabel];
    
    
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
    [duihuanBt setBackgroundColor:COLORWITHRGB(0, 219, 220)];
    duihuanBt.layer.cornerRadius=11;
    duihuanBt.clipsToBounds=YES;
    duihuanBt.titleLabel.font=[UIFont systemFontOfSize:12];
    [duihuanBt addTarget:self action:@selector(duihuanBtClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:duihuanBt];
    
}

#pragma mark -赋值操作
-(void)fillCellWithModel:(JiFenCanDuiHuanModel *)model indexPath:(NSIndexPath *)path{
    
      self.row = path;
    
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",model.img_url]]];
    _nameLabe.text=[NSString stringWithFormat:@"%@",model.trade_name] ;
    _jifenLabel.text=[NSString stringWithFormat:@"%@ 积分",model.integral_price];
    
}


-(void)layoutSubviews{
    
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.mas_top).offset(25);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(SYRealValueHeight(101));
    }];
    
    [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
         make.centerX.mas_equalTo(self.mainImageView);
        make.top.equalTo(self.mainImageView.mas_bottom).offset(5);
        
    }];
    
//    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.equalTo(self.jifenLabel);
//        make.left.equalTo(self.jifenLabel.mas_right).offset(1);
//    }];
    
    
    
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

#pragma mark-兑换按钮点击事件
-(void)duihuanBtClick:(UIButton*)btn{
    
    DuiHuanAlter*alterView=[[DuiHuanAlter alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH)];
    self.alterView=alterView;
    [[UIApplication sharedApplication].keyWindow addSubview:alterView];
    
    alterView.alterBtClick = ^(NSInteger tag) {
      
        [self.alterView removeFromSuperview];
       
        self.alterView=nil;
        
    };

}

@end
