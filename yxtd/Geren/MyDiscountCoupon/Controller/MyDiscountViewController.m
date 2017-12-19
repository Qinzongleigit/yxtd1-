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


#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface MyDiscountViewController ()<seletedControllerDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) MyDiscountTopSliderView*titleScroll;
@property (nonatomic,strong)UIScrollView*mainScroll;

@property (nonatomic,strong) DiscountUnusedViewController*unusedVC;

@property (nonatomic,strong) DiscountExpiredViewController*expiredVC;
@property (nonatomic,strong)DiscountUsedViewController*usedVC;



@end

@implementation MyDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"我的优惠券";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
      [self.rightBt setBackgroundImage:[UIImage imageWithoriginName:@"fenxaing_Image"] forState:UIControlStateNormal];
    
    
    //创建头部视图(滑动视图)
    self.titleScroll= [[MyDiscountTopSliderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    NSArray *titleArr = @[@"未使用",@"已过期",@"已使用"];
    
    self.titleScroll.headArray = titleArr.mutableCopy;
    
    //设置代理
    self.titleScroll.SeletedDelegate = self;
    //添加
    [self.view addSubview:self.titleScroll];
    
    //创建一个滑动视图用来滑动Viewcontroller
   self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-40)];
    //设置代理
    self.mainScroll.delegate = self;
    //设置滑动区域
    self.mainScroll.contentSize = CGSizeMake(ScreenWidth*titleArr.count, 0) ;
    //打开分页功能
    self.mainScroll.pagingEnabled = YES;
    //设置背景颜色
    self.mainScroll.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.mainScroll];
    //设置当前子控制器
    self.unusedVC = [[DiscountUnusedViewController alloc] init];
    [self addChildViewController:self.unusedVC];
    self.unusedVC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //将当前的子视图控制器的view添加到主滑动视图上
    [self.mainScroll addSubview:self.unusedVC.view];

    
}


#pragma mark -滚动视图即将开始拖动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.mainScroll.contentOffset.x < ScreenWidth) {
        _expiredVC = [[DiscountExpiredViewController alloc] init];
        [self addChildViewController:_expiredVC];
        _expiredVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
        [self.mainScroll addSubview:_expiredVC.view];
    }else if (self.mainScroll.contentOffset.x < ScreenWidth*2){
        _usedVC = [[DiscountUsedViewController alloc] init];
        [self addChildViewController:_usedVC];
        _usedVC.view.frame = CGRectMake(ScreenWidth*2, 0, ScreenWidth, ScreenHeight);
        [self.mainScroll addSubview:_usedVC.view];
    }
//    else if (mainScroll.contentOffset.x < ScreenWidth *3){
//        fourVC = [[FourViewController alloc]init];
//        [self addChildViewController:fourVC];
//        fourVC.view.frame = CGRectMake(ScreenWidth*3, 0, ScreenWidth, ScreenHeight);
//        [mainScroll addSubview:fourVC.view];
//    }

    
    [self.titleScroll changeBtntitleColorWith:scrollView.contentOffset.x/ScreenWidth+1000];
}


#pragma mark -滚动视图结束拖动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self.titleScroll changeBtntitleColorWith:scrollView.contentOffset.x/ScreenWidth+1000];
    
}

#pragma mark -头部scrollView的代理方法的实现
-(void)seletedControllerWith:(UIButton *)btn{
    
   self. mainScroll.contentOffset = CGPointMake(ScreenWidth*(btn.tag - 1000), 0);
    
    if (self.mainScroll.contentOffset.x == ScreenWidth) {
        _expiredVC = [[DiscountExpiredViewController alloc] init];
        [self addChildViewController:_expiredVC];
        _expiredVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
        [self.mainScroll addSubview:_expiredVC.view];
    }else if (self.mainScroll.contentOffset.x == ScreenWidth*2){
        _usedVC = [[DiscountUsedViewController alloc] init];
        [self addChildViewController:_usedVC];
        _usedVC.view.frame = CGRectMake(ScreenWidth*2, 0, ScreenWidth, ScreenHeight);
        [self.mainScroll addSubview:_usedVC.view];
    }
//    }else if (mainScroll.contentOffset.x == ScreenWidth *3){
//        fourVC = [[FourViewController alloc]init];
//        [self addChildViewController:fourVC];
//        fourVC.view.frame = CGRectMake(ScreenWidth*3, 0, ScreenWidth, ScreenHeight);
//        [mainScroll addSubview:fourVC.view];
  //  }
    [self.titleScroll changeBtntitleColorWith:self.mainScroll.contentOffset.x/ScreenWidth+1000];
    
    
}



#pragma mark-分享按钮点击事件
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
