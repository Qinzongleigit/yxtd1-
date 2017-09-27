//
//  SaiShiDetailedHeaderView.m
//  yxtd
//
//  Created by qin on 2017/9/19.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "SaiShiDetailedHeaderView.h"

@interface SaiShiDetailedHeaderView ()

@end

@implementation SaiShiDetailedHeaderView


//初始化位置
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self==[super initWithFrame:frame]) {
        
        [self setUpHeaderView];
    }
    return self;
}

#pragma mark --布局详情页头部控件
-(void)setUpHeaderView{
    
    
    UIView*bgHeaderView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, 340)];
    bgHeaderView.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgHeaderView];
    
    
   
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, 151)];
    headerView.layer.backgroundColor = [[UIColor colorWithRed:49.0f/255.0f green:58.0f/255.0f blue:63.0f/255.0f alpha:1.0f] CGColor];
    headerView.alpha = 0.75;
    
    [bgHeaderView addSubview:headerView];
    
    
    NSArray*arr=@[@"左边按钮",@"右边按钮"];
    
    for (int i=0; i<arr.count; i++) {
        
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(16+((KscreenW/2-16-100)*2+100)*i, 32, 100, 40);
        [button setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=100+i;
        [bgHeaderView addSubview:button];
    }
    
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake((KscreenW-77)/2, 112, 77, 77)];
    iconView.layer.backgroundColor = [[UIColor colorWithRed:0.0f/255.0f green:219.0f/255.0f blue:220.0f/255.0f alpha:1.0f] CGColor];
    iconView.alpha = 1;
    iconView.layer.cornerRadius=77/2;
    iconView.clipsToBounds=YES;
    
    [bgHeaderView  addSubview:iconView];
    

    UILabel*namelabel=[[UILabel alloc] initWithFrame:CGRectMake((KscreenW-94)/2, CGRectGetMaxY(iconView.frame)+21, 94, 21)];
    namelabel.text=@"健康达人";
    //粗体
    namelabel.font=[UIFont boldSystemFontOfSize:20];
    namelabel.textColor=[UIColor blackColor];
    namelabel.textAlignment=NSTextAlignmentCenter;
    [bgHeaderView addSubview:namelabel];
    
    UILabel*stepLabel=[[UILabel alloc] initWithFrame:CGRectMake((KscreenW-140)/2, CGRectGetMaxY(namelabel.frame)+15, 140, 12)];
    stepLabel.text=@"每月累计步数达60万步";
    stepLabel.font=[UIFont systemFontOfSize:12];
    stepLabel.textColor=BlackHexColor;
    stepLabel.textAlignment=NSTextAlignmentCenter;
    [bgHeaderView addSubview:stepLabel];
    
    
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(stepLabel.frame)+26, KscreenW, 1)];
    lineView.alpha = 1;
    lineView.backgroundColor=btnLineColor;
   
    [bgHeaderView addSubview:lineView ];
    
    
    NSArray*nameArr=@[@"名额上限",@"挑战人数",@"我的步数"];
   NSArray*numberArr=@[@"3000",@"1789",@"5000"];
    
    for (int i=0; i<nameArr.count; i++) {
        UILabel*label=[[UILabel alloc] initWithFrame:CGRectMake(KscreenW/3*i, CGRectGetMaxY(lineView.frame)+10, KscreenW/3, 10)];
        label.text=[NSString stringWithFormat:@"%@",nameArr[i]];
        label.font=[UIFont systemFontOfSize:10];
        label.textColor=BlackHexColor;
        label.textAlignment=NSTextAlignmentCenter;
        
        
        UILabel*numberlabel=[[UILabel alloc] initWithFrame:CGRectMake(KscreenW/3*i, CGRectGetMaxY(label.frame)+10, KscreenW/3, 10)];
        numberlabel.text=[NSString stringWithFormat:@"%@",numberArr[i]];
        numberlabel.font=[UIFont systemFontOfSize:10];
        numberlabel.textColor=BlackHexColor;
        numberlabel.textAlignment=NSTextAlignmentCenter;
    
       
        //竖线
        UIView*lineV=[[UIView alloc] initWithFrame:CGRectMake(KscreenW/3*i, CGRectGetMaxY(lineView.frame)+7, 1, 42)];
        lineV.backgroundColor=btnLineColor;
        
        
        [bgHeaderView addSubview:label];
        [bgHeaderView addSubview:numberlabel];
        [bgHeaderView addSubview:lineV];
    }

    
}


//头部左右按钮点击事件
-(void)buttonClick:(UIButton*)bt{
    
    if (self.myIndexBlock) {
        
        self.myIndexBlock(bt.tag);
    }
    
}

@end
