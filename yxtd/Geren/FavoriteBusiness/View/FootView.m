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
    
    //全选
    _allBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _allBtn.backgroundColor=[UIColor redColor];
    [_allBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside ];
    
    [self addSubview:_allBtn];
    
    [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    
    
    
    //删除
    _deleteBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.backgroundColor=[UIColor redColor];
    
    [_deleteBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside ];
    
    [self addSubview:_deleteBtn];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(_allBtn);
        make.size.mas_equalTo(_allBtn);
        make.right.mas_equalTo(-10);
    }];
    
}

-(void)buttonAction{
    
    self.deleteBtnBolock();
    
    
}

-(void)buttonClick:(UIButton*)btn{
    
    
    self.allBtnBolock(btn);
    
}

@end
