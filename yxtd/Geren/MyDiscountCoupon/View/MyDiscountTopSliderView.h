//
//  MyDiscountTopSliderView.h
//  yxtd
//
//  Created by 覃宗雷 on 2017/12/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置代理
@protocol seletedControllerDelegate <NSObject>

-(void)seletedControllerWith:(UIButton *)btn;

@end

@interface MyDiscountTopSliderView : UIScrollView

@property (nonatomic,strong)UIView *indicatorView;


@property (nonatomic,assign)int currentBtn;
//设置头部的标题数组
@property (nonatomic,strong)NSMutableArray *headArray;
//设置实现代理方法的代理人
@property (nonatomic,weak)id<seletedControllerDelegate> SeletedDelegate;

//创建方法实现点击按钮改变按钮标题的颜色
-(void)changeBtntitleColorWith:(int)tag;

@end
