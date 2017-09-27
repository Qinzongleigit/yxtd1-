//
//  RankingViewController.m
//  yxtd
//
//  Created by qin on 2017/9/13.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "RankingViewController.h"
#import "TopSliderVIew.h"
#import "SportViewController.h"
#import "SaiShiViewController.h"
#import "PaiHangViewController.h"

@interface RankingViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) TopSliderVIew*topView;




@end

@implementation RankingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //滚动视图
    //禁用掉自动设置的内边距，自行控制controller上index为0的控件以及scrollview控件的位置
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    
    UIScrollView*scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KscreenW, KscreenH-64)];
    scrollView.contentSize=CGSizeMake(3*KscreenW, 0);
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    
    self.topView=[[TopSliderVIew alloc] initWithFrame:CGRectMake(0, 20, KscreenW, 44)];
    self.topView.backgroundColor=[UIColor whiteColor];
    self.topView.myIndexBlock = ^(NSInteger index) {
        
        scrollView.contentOffset=CGPointMake(KscreenW*(index-5), 0);
    };
    //self.navigationItem.titleView = self.topView;
    [self.view addSubview:self.topView];
    
    //排行
    PaiHangViewController * paihangVC = [[PaiHangViewController alloc]init];
    paihangVC.view.frame =CGRectMake(0, 0, KscreenW, KscreenH-64);
    
    [scrollView addSubview:paihangVC.view];
    //添加子子视图
    [self addChildViewController:paihangVC]; // 此句话必须得加
    
    
    //运动
    SportViewController * sportVC = [[SportViewController alloc]init];
    sportVC.view.frame =CGRectMake(KscreenW, 0, KscreenW, KscreenH-64);
    [scrollView addSubview:sportVC.view];
    [self addChildViewController:sportVC];
    
    //赛事
    SaiShiViewController * saishiVC = [[SaiShiViewController alloc]init];
    saishiVC.view.frame =CGRectMake(2*KscreenW, 0, KscreenW, KscreenH-64);
    [scrollView addSubview:saishiVC.view];
    
    [self addChildViewController:saishiVC];
    
    
    

}


#pragma mark --滚动视图代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index=scrollView.contentOffset.x/KscreenW;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.topView.coverView.frame=CGRectMake(index*(KscreenW-80)/3+20*(index+1), 40, (KscreenW-80)/3, 1);
    }];
}


#pragma mark - 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    //修改状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //修改电池条
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

#pragma mark - 视图即将消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}






@end
