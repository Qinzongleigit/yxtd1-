//
//  MyDiscountViewController.m
//  yxtd
//
//  Created by qin on 2017/12/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "MyDiscountViewController.h"
#import "MyDiscountTopSliderView.h"
#import "DiscountUsedViewController.h"
#import "DiscountExpiredViewController.h"
#import "DiscountUnusedViewController.h"

@interface MyDiscountViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) MyDiscountTopSliderView*discountTopView;
@property (nonatomic,strong)UIScrollView*scrollView;


@end

@implementation MyDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"我的优惠券";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
      [self.rightBt setBackgroundImage:[UIImage imageWithoriginName:@"fenxaing_Image"] forState:UIControlStateNormal];
    
    
    //滚动视图
    //禁用掉自动设置的内边距，自行控制controller上index为0的控件以及scrollview控件的位置
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIScrollView*scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, KscreenW, KscreenH-40)];
    self.scrollView=scrollView;
    scrollView.contentSize=CGSizeMake(3*KscreenW, 0);
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    
    
    self.discountTopView=[[MyDiscountTopSliderView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, 40)];
    self.discountTopView.backgroundColor=[UIColor whiteColor];
    self.discountTopView.myDiscountIndexBlock = ^(NSInteger index) {
        
        scrollView.contentOffset=CGPointMake(KscreenW*(index-5), 0);
    };
  
    [self.view addSubview:self.discountTopView];
    
    
    //排行
    DiscountUnusedViewController * unusedVC = [[DiscountUnusedViewController alloc]init];
    unusedVC.view.frame =CGRectMake(0, 0, KscreenW, KscreenH-40);
    
    [scrollView addSubview:unusedVC.view];
    //添加子子视图
    [self addChildViewController:unusedVC];
    
    
    //运动
    DiscountExpiredViewController * expiredVC = [[DiscountExpiredViewController alloc]init];
    expiredVC.view.frame =CGRectMake(KscreenW, 0, KscreenW, KscreenH-40);
    [scrollView addSubview:expiredVC.view];
    
    [self addChildViewController:expiredVC];
    
    //赛事
    DiscountUsedViewController * usedVC = [[DiscountUsedViewController alloc]init];
    usedVC.view.frame =CGRectMake(2*KscreenW, 0, KscreenW, KscreenH-40);
    [scrollView addSubview:usedVC.view];
    [self addChildViewController:usedVC];


    
}

#pragma mark --滚动视图代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index=scrollView.contentOffset.x/KscreenW;
    
    self.discountTopView.slicdeButton= (UIButton *)[self.scrollView viewWithTag:5+index];
     self.discountTopView.slicdeButton.selected = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        
 self.discountTopView.coverView.frame=CGRectMake((KscreenW-40-40-20)/12+40+index*((KscreenW-40-40-20)/3+10), 39, (KscreenW-40-40-20)/6, 1);
        
        
    }];
  
}


-(void)rightBtnClick{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"分享提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

    
}

-(void)leftBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
