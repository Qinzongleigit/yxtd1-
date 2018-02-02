//
//  TitleView.m
//  UInabarView
//
//  Created by qin on 2018/1/26.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "TitleView.h"

@interface TitleView ()


@end

@implementation TitleView

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self creatUI ];
    }
    
    return self;
}


-(void)creatUI{
    
    NSMutableArray *array = [NSMutableArray new];
    _titleArr=@[@"关注",@"粉丝"];
    for (int i = 0; i < _titleArr.count ; i ++) {
        
        UIButton*bt=[UIButton buttonWithType:UIButtonTypeCustom];
        [bt setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        bt.backgroundColor=[UIColor clearColor];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        bt.tag=100+i;
        [bt addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
        if (bt.tag==100) {
            
            bt.selected=YES;
            bt.transform= CGAffineTransformMakeScale(1.2, 1.2);
        }
        [self addSubview:bt];
        [array addObject:bt]; //保存添加的控件
    
    }

    //水平方向控件间隔固定等间隔
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:14 leadSpacing:14 tailSpacing:14];

    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.height.equalTo(@35);
    }];
  
}

-(void)btClick:(UIButton*)bt{
    
    for (int i=0; i<_titleArr.count; i++) {
        
        UIButton*btn=(UIButton*)[self viewWithTag:100+i];
        btn.selected=NO;
        
        btn.transform= CGAffineTransformMakeScale(1.0,1.0);
       
    }
     bt.selected=YES;
     bt.transform= CGAffineTransformMakeScale(1.2, 1.2);
    
    self.titleBtBlock(bt.tag);
    
}

@end
