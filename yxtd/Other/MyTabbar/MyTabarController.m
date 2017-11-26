//
//  MyTabarController.m
//  UitabarController
//
//  Created by qin on 2017/9/11.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "MyTabarController.h"
#import "MyUINavigationController.h"
#import "RunViewController.h"
#import "RankingViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"






@interface MyTabarController ()<UITabBarControllerDelegate>

@end

@implementation MyTabarController



+(void)initialize{
    
    UITabBarItem*item=[UITabBarItem appearanceWhenContainedIn:self,nil];
    NSMutableDictionary*dictionary=[NSMutableDictionary dictionary];
    dictionary[NSForegroundColorAttributeName]=BlackHexColor;
    [item setTitleTextAttributes:dictionary forState:UIControlStateSelected];
    
    NSMutableDictionary*normalDict=[NSMutableDictionary dictionary];
    normalDict[NSForegroundColorAttributeName]=[UIColor grayColor];
    
    [item setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.delegate=self;
    
    UIView*whiteView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
    self.whiteView=whiteView;
    whiteView.backgroundColor=[UIColor whiteColor];
    
    [self.tabBar insertSubview:whiteView atIndex:0];
    
    [self setUpAllChildViewController];
    
    
    
}


#pragma mark --添加标签栏全部子控制器
-(void)setUpAllChildViewController{
    
    RunViewController*run=[[RunViewController alloc] init];
    
    [self setupOneChildViewController:run image:[UIImage imageWithoriginName:@"running"] selectedImage:[UIImage imageWithoriginName:@"running_select"] title:@"跑券"];
    
    //run.firstTabBarComeTag=YES;
    
    run.view.backgroundColor=[UIColor whiteColor];
    
    
    RankingViewController*rank=[[RankingViewController alloc] init];
    
    [self setupOneChildViewController:rank image:[UIImage imageWithoriginName:@"ranking"] selectedImage:[UIImage imageWithoriginName:@"ranking_select"] title:@"排行"];
    rank.view.backgroundColor=[UIColor whiteColor];
    

    
    FindViewController*find=[[FindViewController alloc] init];
    
    [self setupOneChildViewController:find image:[UIImage imageWithoriginName:@"find"] selectedImage:[UIImage imageWithoriginName:@"find_select"] title:@"发现"];
    find.view.backgroundColor=[UIColor whiteColor];
    
    MineViewController*mine=[[MineViewController alloc] init];
    
    [self setupOneChildViewController:mine image:[UIImage imageWithoriginName:@"mine"] selectedImage:[UIImage imageWithoriginName:@"mine_select"] title:@"我的"];
    mine.view.backgroundColor=[UIColor whiteColor];
    
}

#pragma mark --添加标签栏一个子控制器

-(void)setupOneChildViewController:(UIViewController*)vc image:(UIImage*)image selectedImage:(UIImage*)selectedImage title:(NSString*)title{
    
    vc.tabBarItem.title=title;
    
    //对文字进行偏移
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    vc.tabBarItem.image=image;
    
    vc.tabBarItem.selectedImage=selectedImage;
    
    
    UINavigationController*navi=[[UINavigationController alloc] initWithRootViewController:vc];
//    MyUINavigationController*navi=[[MyUINavigationController alloc] initWithRootViewController:vc];
    navi.navigationBar.translucent=NO;
    
    [self addChildViewController:navi];
    
}


#pragma mark- 选择控制器

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    UINavigationController*navi=(UINavigationController*)viewController;
    
    if ([navi.topViewController isKindOfClass:[RunViewController class]])
    {
        RunViewController *run = (RunViewController *)navi.topViewController;
         
        //first.firstTabBarComeTag=YES;
        
        
    }else if([navi.topViewController isKindOfClass:[MineViewController class]]){
        
        
        MineViewController *mine = (MineViewController *)navi.topViewController;
        
        mine.SecondTabBarComeTag=YES;
        
    }
    
    return YES;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self.selectedViewController beginAppearanceTransition:YES animated:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{

    [self.selectedViewController endAppearanceTransition];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
