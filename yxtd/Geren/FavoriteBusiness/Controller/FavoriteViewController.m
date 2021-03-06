//
//  FavoriteViewController.m
//  yxtd
//
//  Created by 覃宗雷 on 2017/12/19.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FavoriteSliderTopView.h"
#import "FoodViewController.h"
#import "EntertainmentViewController.h"

#import "FootView.h"

@interface FavoriteViewController ()<seletedControllerDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) FavoriteSliderTopView*titleScroll;

@property (nonatomic,strong) UIScrollView*mainScroll;
@property (nonatomic,strong) FoodViewController*foodVC;
@property (nonatomic,strong) EntertainmentViewController*entertainmentVC;

@property (nonatomic, strong) FootView *footView;

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
        self.view.backgroundColor=[UIColor whiteColor];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnTitleText) name:@"changeEditingBtnTitleText" object:nil];
    
    [self initNaviBar];
    
    
    //创建头部视图(滑动视图)
    self.titleScroll= [[FavoriteSliderTopView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, 40)];
    NSArray *titleArr = @[@"美食",@"娱乐"];
    
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
    self.foodVC = [[FoodViewController alloc] init];
    [self addChildViewController:self.foodVC];
    
    self.foodVC.view.frame = CGRectMake(0, 0, KscreenW, KscreenH);
    //将当前的子视图控制器的view添加到主滑动视图上
    [self.mainScroll addSubview:self.foodVC.view];
    
    
    _entertainmentVC = [[EntertainmentViewController alloc] init];
    [self addChildViewController:_entertainmentVC];
    _entertainmentVC.view.frame = CGRectMake(KscreenW, 0, KscreenW, KscreenH);
    //将当前的子视图控制器的view添加到主滑动视图上
    [self.mainScroll addSubview:_entertainmentVC.view];
    
    
    UIView*lineV=[[UIView alloc] init];
    lineV.backgroundColor=[UIColor lightGrayColor];
    [self.titleScroll addSubview:lineV];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self.titleScroll);
        make.size.mas_equalTo(CGSizeMake(1, 20));
        
    }];
    
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


    

#pragma mark-初始化导航栏
-(void)initNaviBar{
    
    
    [self.rightBt setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBt setBackgroundImage:nil forState:UIControlStateNormal];
    self.rightBt.titleLabel.font=[UIFont systemFontOfSize:17];
    
     [self.rightBt addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.title=@"收藏商家";
  
    
}

#pragma mark--Editing
- (void)btnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
     if (btn.selected) {

         [btn setTitle:@"取消" forState:UIControlStateNormal];

     }else {

         
         [btn setTitle:@"编辑" forState:UIControlStateNormal];
     }
    
    
    //发送编辑点击事件通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"postNotiEditing" object:nil];

    

}

#pragma mark - 点击删除改变编辑按钮的title
-(void)btnTitleText{
    
    [self.rightBt setTitle:@"编辑" forState:UIControlStateNormal];
    
    
    //防止当全部选择时，点击删除，再次点击全部选择会无效
    self.rightBt.selected=NO;
    
    
}


-(void)dealloc{
    
    
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
