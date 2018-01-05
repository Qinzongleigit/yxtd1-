//
//  ShangJiaViewController.m
//  yxtd
//
//  Created by qin on 2018/1/5.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "ShangJiaViewController.h"
#import "FavoriteSliderTopView.h"
#import "AlreadyEvaluatedViewController.h"
#import "NotEvaluatedViewController.h"

@interface ShangJiaViewController ()<seletedControllerDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) FavoriteSliderTopView*titleScroll;

@property (nonatomic,strong) UIScrollView*mainScroll;
@property (nonatomic,strong) NotEvaluatedViewController*NotEvaluatedVC;

@property (nonatomic,strong) AlreadyEvaluatedViewController*alreadyEvaluatedVC;


@end

@implementation ShangJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title=@"商家打星";
    self.rightBt.hidden=YES;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //创建头部视图(滑动视图)
    self.titleScroll= [[FavoriteSliderTopView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, 40)];
    NSArray *titleArr = @[@"未评价",@"已评价"];
    
    self.titleScroll.headArray = titleArr.mutableCopy;
    
    //设置代理
    self.titleScroll.SeletedDelegate = self;
    //添加
    [self.view addSubview:self.titleScroll];
    
    
    
    //创建一个滑动视图用来滑动Viewcontroller
    self.mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, KscreenW, KscreenH-40)];
    //设置代理
    self.mainScroll.delegate = self;
    //设置滑动区域
    self.mainScroll.contentSize = CGSizeMake(KscreenW*titleArr.count, 0) ;
    //打开分页功能
    self.mainScroll.pagingEnabled = YES;
    //设置背景颜色
    self.mainScroll.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.mainScroll];
    //设置当前子控制器
    self.NotEvaluatedVC = [[NotEvaluatedViewController alloc] init];
    [self addChildViewController:self.NotEvaluatedVC];
    
    self.NotEvaluatedVC.view.frame = CGRectMake(0, 0, KscreenW, KscreenH);
    //将当前的子视图控制器的view添加到主滑动视图上
    [self.mainScroll addSubview:self.NotEvaluatedVC.view];
    
    
    self.alreadyEvaluatedVC = [[AlreadyEvaluatedViewController alloc] init];
    [self addChildViewController:self.alreadyEvaluatedVC];
    self.alreadyEvaluatedVC.view.frame = CGRectMake(KscreenW, 0, KscreenW, KscreenH);
    //将当前的子视图控制器的view添加到主滑动视图上
    [self.mainScroll addSubview:self.alreadyEvaluatedVC.view];
    
    
    UIView*lineH=[[UIView alloc] init];
    lineH.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:lineH];
    
    [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleScroll.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(KscreenW, 1));
        make.left.mas_equalTo(0);
        
    }];
    
    
    
}



#pragma mark -滚动视图即将开始拖动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.titleScroll changeBtntitleColorWith:scrollView.contentOffset.x/KscreenW+1000];
}


#pragma mark -滚动视图结束拖动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self.titleScroll changeBtntitleColorWith:scrollView.contentOffset.x/KscreenW+1000];
    
}

#pragma mark -头部scrollView的代理方法的实现
-(void)seletedControllerWith:(UIButton *)btn{
    
    self. mainScroll.contentOffset = CGPointMake(KscreenW*(btn.tag - 1000), 0);
    
    [self.titleScroll changeBtntitleColorWith:self.mainScroll.contentOffset.x/KscreenW+1000];
    
    
}


-(void)leftBtnClick{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
