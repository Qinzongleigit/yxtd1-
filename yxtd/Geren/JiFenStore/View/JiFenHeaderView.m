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


@property (nonatomic,strong) UIButton*leftBt;

@property (nonatomic,strong) UIButton*rightBt;
@property (nonatomic,strong) UILabel*jifenTitle;

@property (nonatomic,strong) UICountingLabel*jifenNumberLabel;

@property (nonatomic,strong) UILabel*myjifenLabel;

@property (nonatomic,strong) UIImageView*coverImageView;

@property (nonatomic,strong) UIImageView*headerImageView;


@property (nonatomic,assign) NSInteger index;


@end

@implementation JiFenHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self headerUI];
        self.userInteractionEnabled=YES;
    }
    
    return self;
}

#pragma mark -创建头部视图
-(void)headerUI{
    
    UIImageView*headerImageView=[[UIImageView alloc] initWithFrame:self.bounds];
    self.headerImageView=headerImageView;
    headerImageView.backgroundColor=[UIColor grayColor];
    headerImageView.userInteractionEnabled=YES;
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
    jifenTitle.font=[UIFont systemFontOfSize:17];
    [jifenTitle setTextColor:[UIColor whiteColor]];
    [self addSubview:jifenTitle];


    //不能用定时器来做，时间太慢了，用封装一个label
    UICountingLabel *jifenNumberLabel = [[UICountingLabel alloc] init];
    self.jifenNumberLabel=jifenNumberLabel;
    jifenNumberLabel.font = [UIFont fontWithName:@"Avenir Next" size:47];
    jifenNumberLabel.textColor = [UIColor whiteColor];

    [self addSubview:jifenNumberLabel];
    //设置跳动时间和跳动范围
    [jifenNumberLabel jumpNumberWithDuration:1.0f fromNumber:0 toNumber:6321];


    UILabel*myjifenLabel=[[UILabel alloc] init];
    myjifenLabel.text=@"我的积分";
    self.myjifenLabel=myjifenLabel;
    myjifenLabel.font=[UIFont systemFontOfSize:12];
    [myjifenLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:myjifenLabel];
    
    
    [self creatButton];
    
    
}

#pragma mark -创建按钮
-(void)creatButton{

        NSArray*titleArr=[NSArray arrayWithObjects:@"可兑换",@"已兑换",@"赛事奖品", nil];

        NSMutableArray*cellArray=[NSMutableArray new];
        for (int i=0; i<titleArr.count; i++) {
            
            UIButton*slicdeButton=[UIButton buttonWithType:UIButtonTypeCustom];
           
            [slicdeButton setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
            slicdeButton.titleLabel.font=[UIFont systemFontOfSize:12];
            
            [slicdeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [slicdeButton setTitleEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
            
            [slicdeButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, -25, -50)];
            
            [slicdeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            slicdeButton.tag=100+i;
            
            [slicdeButton setImage:[UIImage imageWithoriginName:@"bt_jifen_Image"] forState:UIControlStateNormal];
            
            [slicdeButton setImage:[UIImage imageWithoriginName:@"bgButtonImage"] forState:UIControlStateSelected];

            
            [self addSubview:slicdeButton];
            
           if (i==0) {

               slicdeButton.selected=YES;
    
              
           }
            
            [cellArray addObject:slicdeButton];
        }
        //水平方向控件间隔固定等间隔
        [cellArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:30 tailSpacing:30];
        
        [cellArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headerImageView.mas_bottom).offset(-1);
            make.height.equalTo(@25);
        }];
        
    
 }
    

    //按钮点击事件
-(void)buttonClick:(UIButton*)btn{
    
    for (int i = 0; i <= 2; i++) {

        UIButton *bt = (UIButton *)[self viewWithTag:100 + i];
        //选中当前按钮时
        if (btn== bt) {

            btn.selected = YES;

        }else{

            [bt setSelected:NO];

        }


    }
    
    self.headerBtClick(btn.tag);
    
}
    


#pragma mark -坐标
-(void)layoutSubviews{
    
    
    [self.leftBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(25);
        
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
        make.top.equalTo(self.jifenTitle.mas_bottom).offset(8);
    }];
    
    [self.myjifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.jifenNumberLabel);
        make.top.equalTo(self.jifenNumberLabel.mas_bottom).offset(-5);
    }];
    
}




-(void)leftBtBack{
    
    self.gotoBack();
    
}

-(void)jifenrightBt{
    
    self.jifenRight();
}



@end
