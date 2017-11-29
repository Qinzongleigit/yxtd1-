//
//  HuatiDongtaiViewController.m
//  yxtd
//
//  Created by qin on 2017/11/29.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "HuatiDongtaiViewController.h"

@interface HuatiDongtaiViewController ()

@end

@implementation HuatiDongtaiViewController
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    [self.rightBt setBackgroundImage:[UIImage imageWithoriginName:@"fabu_Image"] forState:UIControlStateNormal];
    
    

    
}

-(void)rightBtnClick{
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"动态发布" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
