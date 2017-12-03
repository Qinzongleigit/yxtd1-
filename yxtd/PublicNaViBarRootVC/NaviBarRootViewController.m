//
//  NaviBarRootViewController.m
//  yxtd
//
//  Created by qin on 2017/11/29.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "NaviBarRootViewController.h"

@interface NaviBarRootViewController ()

@end

@implementation NaviBarRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //左边按钮
    _leftBt=[UIButton buttonWithType:UIButtonTypeCustom];
    _leftBt.frame=CGRectMake(16, 11, 22, 22);
    [_leftBt setBackgroundImage:[UIImage imageWithoriginName:@"back"] forState:UIControlStateNormal];
    [_leftBt addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem*leftBtItem=[[UIBarButtonItem alloc] initWithCustomView:_leftBt];
    self.navigationItem.leftBarButtonItem=leftBtItem;
    
   
    
    //右边按钮
    _rightBt=[UIButton buttonWithType:UIButtonTypeCustom];
    _rightBt.frame=CGRectMake(KscreenW-33, 11, 22, 22);
    [_rightBt setBackgroundImage:[UIImage imageWithoriginName:@"back"] forState:UIControlStateNormal];
    [_rightBt addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem*rightBtItem=[[UIBarButtonItem alloc] initWithCustomView:_rightBt]; self.navigationItem.rightBarButtonItem=rightBtItem;
    
   
    self.view.backgroundColor=[UIColor whiteColor];
    

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
}


//左边按钮点击
-(void)leftBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


//右边按钮点击
-(void)rightBtnClick{
    
    NSLog(@"导航栏右边按钮点击了");
    
}

@end
