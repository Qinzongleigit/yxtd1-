//
//  ShipAddressViewController.m
//  yxtd
//
//  Created by qin on 2017/11/24.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "ShipAddressViewController.h"

@interface ShipAddressViewController ()

@property (nonatomic, strong) NSMutableArray *addressArr;

@end

@implementation ShipAddressViewController

//懒加载
-(NSMutableArray*)addressArr{
    
    if (!_addressArr) {
        _addressArr=[NSMutableArray array];
    }
    return _addressArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"地址列表";
    //左边按钮
    UIBarButtonItem*leftBt=[[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoriginName:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    self.navigationItem.leftBarButtonItem=leftBt;
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] init];
    
    [rightBtn setTitle:@"添加地址"];
    
    [rightBtn setTarget:self];
    
    [rightBtn setAction:@selector(addAddress)];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}


#pragma mark -添加地址按钮点击
-(void)addAddress{
    
    
    
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
