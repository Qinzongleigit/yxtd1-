//
//  MyDiscountTopSliderView.m
//  yxtd
//
//  Created by 覃宗雷 on 2017/12/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "MyDiscountTopSliderView.h"

@implementation MyDiscountTopSliderView

-(id)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        [self layoutTopSliderUI];
    }
    return self;
    
    
}

-(void)layoutTopSliderUI{
    
    NSArray*titleArr=[NSArray arrayWithObjects:@"未使用",@"已过期",@"已使用", nil];
    //选中图标的颜色
    UIView*colorV=[[UIView alloc] init];
    self.coverView=colorV;
    colorV.backgroundColor=COLORWITHRGB(0, 219, 220);
    [self addSubview:colorV];
    
    NSMutableArray*cellArray=[NSMutableArray new];
    for (int i=0; i<titleArr.count; i++) {
        
        UIButton*slicdeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.slicdeButton=slicdeButton;
        [slicdeButton setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
        slicdeButton.titleLabel.font=[UIFont systemFontOfSize:15];

        [slicdeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
         [slicdeButton setTitleColor:COLORWITHRGB(0, 219, 220) forState:UIControlStateSelected];
        [slicdeButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
        [slicdeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        slicdeButton.tag=i+5;
        [self addSubview:slicdeButton];
        
        if (i==0) {
     _coverView.frame=CGRectMake((KscreenW-40-40-20)/12+40, 39, (KscreenW-40-40-20)/6, 1);
            slicdeButton.selected=YES;
            
        }
        
        [cellArray addObject:slicdeButton];
    }
    //水平方向控件间隔固定等间隔
    [cellArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:40 tailSpacing:40];
    
    [cellArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.height.equalTo(@39);
    }];
    
    
    
}

//按钮点击事件
-(void)buttonClick:(UIButton*)bt{
    
    for (int i = 0; i <= 2; i++) {
        
        UIButton *btn = (UIButton *)[self viewWithTag:5 + i];
        //选中当前按钮时
        if (bt== btn) {
            
            bt.selected = YES;
            
        }else{
            
            [btn setSelected:NO];
            
        }
        
        
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
    _coverView.frame=CGRectMake(bt.frame.size.width/4+40+(bt.tag-5)*(bt.frame.size.width+10), 39, bt.frame.size.width/2, 1);
        
        
        if (self.myDiscountIndexBlock) {
            
            self.myDiscountIndexBlock(bt.tag);
            
        }
        
    } completion:nil];
}



@end
