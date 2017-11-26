//
//  SexView.m
//  yxtd
//
//  Created by qin on 2017/11/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "SexView.h"

@interface SexView ()

@property (nonatomic,strong) UIView*btView;

@property (nonatomic,strong) UIView*oneView;

@property (nonatomic,assign) NSInteger index;


@end

@implementation SexView



-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self setUpBt];
    }
    return self;
}

#pragma mark-对弹出框设置
-(void)setUpBt{

    UIView*btView=[[UIView alloc] initWithFrame:self.bounds];
    btView.backgroundColor=[UIColor grayColor];
    btView.alpha=0.8;
    self.btView=btView;
    [self addSubview:btView];
    
    //添加手势
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    [btView addGestureRecognizer:tap];
    
    
    UIView*oneView=[[UIView alloc] init];
    self.oneView=oneView;
    oneView.backgroundColor=[UIColor whiteColor];
    oneView.layer.cornerRadius=5;
    oneView.clipsToBounds=YES;
    [self addSubview:oneView];
    [self bringSubviewToFront:oneView];
    
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(30);
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.height.equalTo(@103);
    }];
    

    
    NSArray*sexArr=@[@"男",@"女"];

    for (int i=0; i<sexArr.count; i++) {

        UIButton*manBt=[UIButton buttonWithType:UIButtonTypeCustom];

        [manBt setTitle:[NSString stringWithFormat:@"%@",sexArr[i]] forState:UIControlStateNormal];

        [manBt setTitleColor:[UIColor colorWithRed:0/255.0 green:214/255.0 blue:215/255.0 alpha:1] forState:UIControlStateSelected] ;
        
        manBt.titleLabel.font=[UIFont systemFontOfSize:12];

        [manBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        //默认的选中的图标大小一定要相等，否则点击时就会发生偏移效果
         
        [manBt setImage:[UIImage imageWithoriginName:@"sexBt_Image"] forState:UIControlStateNormal];

       [manBt setImage:[UIImage imageWithoriginName:@"sexBt_selectImage"] forState:UIControlStateSelected];


        [manBt setImageEdgeInsets:UIEdgeInsetsMake(0, SYRealValueWidth(250), 0, 0)];
        [manBt setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 0, SYRealValueWidth(250))];

        manBt.tag=100+i;

        [manBt addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
        [oneView addSubview:manBt];

        [manBt mas_makeConstraints:^(MASConstraintMaker *make) {

            make.height.mas_equalTo(@51);
            make.left.equalTo(oneView.mas_left).with.offset(0);
            make.right.equalTo(oneView.mas_right).with.offset(0);
            make.top.equalTo(oneView.mas_top).with.offset(i*(51+1));


        }];

        if (manBt.tag==100) {

            manBt.selected=YES;

        }


    }
    
    
     UIView*lineV=[[UIView alloc] init];
     lineV.backgroundColor=btnLineColor;
     [oneView addSubview:lineV];
     [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(oneView);
        make.left.equalTo(oneView.mas_left).with.offset(0);
        make.right.equalTo(oneView.mas_right).with.offset(0);
        make.height.mas_equalTo(@1);
    }];

}

#pragma mark -按钮点击事件处理
-(void)btClick:(UIButton*)btn{
    

    for (int i = 0; i < 2; i++) {
        
        UIButton *bt = (UIButton *)[self viewWithTag:100 + i];
        //选中当前按钮时
        if (btn.tag == bt.tag) {
            
            btn.selected = !btn.selected;
          
        }else{
            
             [bt setSelected:NO];
            
           
        }


    }
    
    _index=btn.tag-100;
  

   
    
}


#pragma mark-手势点击事件
-(void)tapClick{
    
    
    //block回调
    self.sexBtClick(self.index);
    
    [self.btView removeFromSuperview];
    
    [self.oneView removeFromSuperview];
    
    self.btView=nil;
    self.oneView=nil;
    
    
}

@end
