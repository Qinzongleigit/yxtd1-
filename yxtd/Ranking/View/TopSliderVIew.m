//
//  TopSliderVIew.m
//  SliderView
//
//  Created by qin on 2017/9/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "TopSliderVIew.h"

@interface TopSliderVIew ()

@end

@implementation TopSliderVIew
-(id)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        [self layoutUI];
    }
    return self;
    

}

-(void)layoutUI{
    
    NSArray*titleArr=[NSArray arrayWithObjects:@"排行",@"运动",@"赛事", nil];
    //选中图标的颜色
    UIView*colorV=[[UIView alloc] init];
//    colorV.layer.cornerRadius=10;
    self.coverView=colorV;
    colorV.backgroundColor=[UIColor redColor];
    [self addSubview:colorV];
    
    //创建按钮
    for (int i=0; i<=2; i++) {
        
        UIButton*slicdeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        slicdeButton.frame=CGRectMake(i*(KscreenW-80)/3+20*(i+1),5 ,(KscreenW-80)/3 ,40 );
        [slicdeButton setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
        [slicdeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [slicdeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        slicdeButton.tag=i+5;
        [self addSubview:slicdeButton];
        
        if (i==0) {
            
            _coverView.frame=CGRectMake(i*(KscreenW-80)/3+20*(i+1), 40, (KscreenW-80)/3, 1) ;
        }
    }
    
    UIView*line=[[UIView alloc] initWithFrame:CGRectMake(0, 43, KscreenW, 1)];
    line.backgroundColor=[UIColor grayColor];
    [self addSubview:line];
    
    
}

//按钮点击事件
-(void)buttonClick:(UIButton*)bt{
    
    [UIView animateWithDuration:0.5 animations:^{
        
       // self.coverView.frame=bt.frame;
         _coverView.frame=CGRectMake((bt.tag-5)*(KscreenW-80)/3+20*(bt.tag-4), 40, (KscreenW-80)/3, 1) ;
        
        if (self.myIndexBlock) {
            
            self.myIndexBlock(bt.tag);
        }
        
    } completion:nil];
}


@end
