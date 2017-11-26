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
    self.coverView=colorV;
    colorV.backgroundColor=BlackHexColor;
    [self addSubview:colorV];
    
     NSMutableArray*cellArray=[NSMutableArray new];
     for (int i=0; i<=2; i++) {

         UIButton*slicdeButton=[UIButton buttonWithType:UIButtonTypeCustom];
         [slicdeButton setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
         slicdeButton.titleLabel.font=[UIFont systemFontOfSize:17];
         UIColor*titleColor=BlackHexColor;
         [slicdeButton setTitleColor:titleColor forState:UIControlStateNormal];

         [slicdeButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
         [slicdeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
         slicdeButton.tag=i+5;
         [self addSubview:slicdeButton];

        if (i==0) {
    
            //_coverView.frame=CGRectMake(i*(KscreenW-80)/6+40*(i+1), 83, (KscreenW-80)/6, 1) ;
            
            _coverView.frame=CGRectMake((KscreenW-90-90-20)/12+90, 83, (KscreenW-90-90-20)/6, 1);
    
       }

       [cellArray addObject:slicdeButton];
    }
    //水平方向控件间隔固定等间隔
    [cellArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:90 tailSpacing:90];
    
    [cellArray mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(@20);
         make.height.equalTo(@64);
    }];
    

      UIView*line=[[UIView alloc] initWithFrame:CGRectMake(0, 84, KscreenW, 1)];
       line.backgroundColor=btnLineColor;
       [self addSubview:line];

    }
    


    


//按钮点击事件
-(void)buttonClick:(UIButton*)bt{
    
    [UIView animateWithDuration:0.5 animations:^{
        

        // _coverView.frame=CGRectMake((bt.tag-5)*(KscreenW-80)/6+40*(bt.tag-4), 83, (KscreenW-80)/6, 1) ;

        _coverView.frame=CGRectMake(bt.frame.size.width/4+90+(bt.tag-5)*(bt.frame.size.width+10), 83, bt.frame.size.width/2, 1);
        

        if (self.myIndexBlock) {

            self.myIndexBlock(bt.tag);
            
        }
        
    } completion:nil];
}


@end
