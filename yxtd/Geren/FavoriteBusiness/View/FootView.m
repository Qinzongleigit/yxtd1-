//
//  FootView.m
//  tableViewtest
//
//  Created by 覃宗雷 on 2017/12/28.
//  Copyright © 2017年 leizongqin. All rights reserved.
//

#import "FootView.h"

@implementation FootView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        
        [self makeUI];
    }
    return self;
}

-(void)makeUI{
    
    _allBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _allBtn.backgroundColor=[UIColor redColor];
    _allBtn.frame=CGRectMake(20, 10, 150, 30);
    [_allBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside ];
    [_allBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:_allBtn];
    
    
    
    _deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.backgroundColor=[UIColor redColor];
    _deleteBtn.frame=CGRectMake(200, 10, 100, 30);
    [_deleteBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside ];
    [self addSubview:_deleteBtn];
    
}

-(void)buttonAction{
    
    self.deleteBtnBolock();
    
    
}

-(void)buttonClick:(UIButton*)btn{
    
    
    self.allBtnBolock(btn);
    
}

@end
