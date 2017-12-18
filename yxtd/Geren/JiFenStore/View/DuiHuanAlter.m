//
//  DuiHuanAlter.m
//  yxtd
//
//  Created by qin on 2017/12/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "DuiHuanAlter.h"
#import "SuccessDuiHuanAlter.h"

@interface DuiHuanAlter ()

@property (nonatomic,strong) UIView*alterBgView;

@property (nonatomic,strong) UIView*alterView;

@property (nonatomic,strong) SuccessDuiHuanAlter*successAlter;


@end

@implementation DuiHuanAlter

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self setUpDuiHuanAlter];
    }
    return self;
}


#pragma mark -创建兑换提示框
-(void)setUpDuiHuanAlter{
    
    
    UIView*alterBgView=[[UIView alloc] initWithFrame:self.bounds];
    alterBgView.backgroundColor=[UIColor grayColor];
    alterBgView.alpha=0.8;
    self.alterBgView=alterBgView;
    [self addSubview:alterBgView];
    
    
    //白色背景
    UIView*alterView=[[UIView alloc] init];
    self.alterView=alterView;
    alterView.backgroundColor=[UIColor whiteColor];
    alterView.layer.cornerRadius=5;
    alterView.clipsToBounds=YES;
    [self addSubview:alterView];
    [self bringSubviewToFront:alterView];
    
    [alterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(35);
        make.right.equalTo(self.mas_right).with.offset(-35);
        make.height.equalTo(@370);
    }];
    
    
    UIImageView*wenhaoImageView=[[UIImageView alloc] init];
    wenhaoImageView.image=[UIImage imageNamed:@"alter_wenhao_Image"];
    wenhaoImageView.layer.cornerRadius=64/2;
    wenhaoImageView.clipsToBounds=YES;
    [alterView addSubview:wenhaoImageView];
    
    [wenhaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(25);
    }];
    
   
    NSString *jifenStr = @"是否花费  2积分";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:jifenStr];
    
     [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(0, jifenStr.length)];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:24.0f]
                    range:NSMakeRange(6, jifenStr.length-6)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]
                    range:NSMakeRange(6, jifenStr.length-6)];
    
    UILabel *alterLabel = [[UILabel alloc] init];
    //自动换行
    alterLabel.numberOfLines = 0;
    //设置label的富文本
    alterLabel.attributedText = attrStr;
   
    [alterView addSubview:alterLabel];
    
    [alterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(wenhaoImageView.mas_bottom).offset(40);
        make.centerX.mas_equalTo(alterView);
        
    }];
    
    
    
    //兑换物品名字
    NSString *nameStr = @"兑换 运动吸汗毛巾";
    NSMutableAttributedString *attrNameStr = [[NSMutableAttributedString alloc] initWithString:nameStr];
    
     [attrNameStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(0, nameStr.length)];
    
    [attrNameStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:17.0f]
                    range:NSMakeRange(3,nameStr.length-3)];
    
    UILabel *alterNameLabel = [[UILabel alloc] init];
    //自动换行
    alterNameLabel.numberOfLines = 0;
    //设置label的富文本
    alterNameLabel.attributedText = attrNameStr;
    
    [alterView addSubview:alterNameLabel];
    
    [alterNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(alterLabel.mas_bottom).offset(24);
        make.centerX.mas_equalTo(alterView);
        
    }];
    
    
    //取消按钮
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取 消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancleBtn.layer.cornerRadius = 19;
    cancleBtn.tag=100;
    [cancleBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [alterView addSubview:cancleBtn];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(alterView);
        make.top.mas_equalTo(alterNameLabel.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(SYRealValueWidth(205), 37));
    }];
    
    //确认按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:COLORWITHRGB(0, 219, 220)];
    sureBtn.layer.cornerRadius = 19;
    
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [alterView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(alterView);
        make.top.mas_equalTo(cancleBtn.mas_bottom).offset(20);
        make.size.mas_equalTo(cancleBtn);
    }];
    
}


#pragma mark-确认按钮点击事件
-(void)sureAction{
    
    //首先移除上一个界面的白色背景视图
    [self.alterView removeFromSuperview];
     self.alterView=nil;
    //加载兑换成功视图
  SuccessDuiHuanAlter*successAlter=[[SuccessDuiHuanAlter alloc] init];
    self.successAlter=successAlter;
    successAlter.backgroundColor=[UIColor whiteColor];
    successAlter.layer.cornerRadius=5;
    successAlter.clipsToBounds=YES;
    [self addSubview:successAlter];
    [self bringSubviewToFront:successAlter];
    
    [successAlter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(35);
        make.right.equalTo(self.mas_right).with.offset(-35);
        make.height.equalTo(@370);
    }];
    
   //点击兑换成功界面确认按钮事件回调移除界面
    successAlter.alterSuccessBtClick = ^{
        
        [self.successAlter removeFromSuperview];
        [self.alterBgView removeFromSuperview];
        
        self.successAlter=nil;
        self.alterBgView=nil;
        
        //回调移除灰色全屏背景
        self.alterBtClick(100);
        
    };
    
}

#pragma mark-弹框取消按钮点击事件
-(void)cancleAction{
    
    [self.alterBgView removeFromSuperview];
    [self.alterView removeFromSuperview];
    
    self.alterBgView=nil;
    self.alterView=nil;
    
    //回调移除灰色全屏背景
    self.alterBtClick(100);
}



@end
