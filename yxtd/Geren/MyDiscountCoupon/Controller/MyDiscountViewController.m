//
//  MyDiscountViewController.m
//  yxtd
//
//  Created by qin on 2017/12/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "MyDiscountViewController.h"

@interface MyDiscountViewController ()

@end

@implementation MyDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"我的优惠券";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
      [self.rightBt setBackgroundImage:[UIImage imageWithoriginName:@"fenxaing_Image"] forState:UIControlStateNormal];
    
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
