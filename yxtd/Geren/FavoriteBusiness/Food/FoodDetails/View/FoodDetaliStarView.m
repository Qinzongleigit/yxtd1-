//
//  FoodDetaliStarView.m
//  yxtd
//
//  Created by qin on 2017/12/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "FoodDetaliStarView.h"

@implementation FoodDetaliStarView

-(instancetype)initWithFrame:(CGRect)frame withFloatNum:(float) starNum{
    
    if ([super initWithFrame:frame]) {
        
        NSMutableArray*starArray=[NSMutableArray new];
        NSMutableArray*starArray1=[NSMutableArray new];
        NSMutableArray*starArray2=[NSMutableArray new];
        
        for (NSInteger  i = 0; i<5; i++)
        {
            UIImageView * starImg = [UIImageView new];
            //灰色星星
            starImg.image = [UIImage imageNamed:@"ico_star"];
            [self addSubview:starImg];
            [starArray addObject:starImg];
            
            UIImageView * starImg1 = [UIImageView new];
            //实心星星
            starImg1.image = [UIImage imageNamed:@"ico_star1"];
            starImg1.hidden = YES;
            [self addSubview:starImg1];
            [starArray1 addObject:starImg1];
            
            UIImageView * starImg2 = [UIImageView new];
            //半星星星
            starImg2.image = [UIImage imageNamed:@"ico_star3"];
            starImg2.hidden = YES;
            [self addSubview:starImg2];
            [starArray2 addObject:starImg2];
            
            
            if (i<starNum)
            {
                if(starNum == i+0.5)
                {
                    starImg2.hidden = NO;
                    
                }
                else
                {
                    starImg1.hidden = NO;
                }
                
            }
            
        }
        //水平方向控件间隔固定等间隔
        [starArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:2 leadSpacing:0 tailSpacing:15];
        
        [starArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.height.equalTo(@15);
        }];
        
        [starArray1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:2 leadSpacing:0 tailSpacing:15];
        
        [starArray1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.height.equalTo(@15);
        }];
        
        [starArray2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:2 leadSpacing:0 tailSpacing:15];
        
        [starArray2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.height.equalTo(@15);
        }];
    }
    
    return self;
}

@end
