//
//  UpdatePhoneNumberViewController.m
//  yxtd
//
//  Created by qin on 2017/11/24.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "UpdatePhoneNumberViewController.h"

@interface UpdatePhoneNumberViewController ()

@end

@implementation UpdatePhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initNavi];
    
    
  
    
    
}

#pragma mark -初始化导航栏
-(void)initNavi{
    
    self.title=@"修改手机号";
    
    //左边按钮
    UIBarButtonItem*leftBt=[[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoriginName:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    self.navigationItem.leftBarButtonItem=leftBt;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
}


-(void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];

    
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
