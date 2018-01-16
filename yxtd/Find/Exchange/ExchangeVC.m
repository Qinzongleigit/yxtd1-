//
//  ExchangeVC.m
//  yxtd
//
//  Created by qin on 2017/11/10.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "ExchangeVC.h"
#import "ExchangeCell.h"

@interface ExchangeVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView*tableView;

@end

@implementation ExchangeVC

static  NSString*cellId=@"id";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self initNavi];
    
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 65, KscreenW, KscreenH-50-64)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.rowHeight=120;
    
    [tableView registerClass:[ExchangeCell class] forCellReuseIdentifier:cellId];
    [self.view addSubview:tableView];
    
  
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    ExchangeCell*cell=[tableView dequeueReusableCellWithIdentifier:cellId];

    return cell;
}


-(void)initNavi{
 
    //设置导航条
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 44)];
    navigationBar.tintColor=[UIColor whiteColor];
    navigationBar.translucent = NO;
    [self.view addSubview:navigationBar];
    
    UINavigationItem *navigationItem=[[UINavigationItem alloc]init];
    
    //设置左边返回按钮
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    //设置标题
    navigationItem.title = @"互换";
    
    
    
    UIView*tabbarView=[[UIView alloc] initWithFrame:CGRectMake(0, KscreenH-49, KscreenW, 49)];
    tabbarView.backgroundColor=COLORWITHRGB(0, 219, 220);
    [self.view addSubview:tabbarView];
    
    UIButton*barBt=[UIButton buttonWithType:UIButtonTypeCustom];
    barBt.frame=tabbarView.bounds;
    [barBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [barBt setTitle:@"我要发布" forState:UIControlStateNormal];
    barBt.titleLabel.font=[UIFont systemFontOfSize:17];
    [tabbarView addSubview:barBt];
    [barBt addTarget:self action:@selector(barClick) forControlEvents:UIControlEventTouchUpInside];
    
   
    
}

-(void)barClick{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"发布成功" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

}

-(void)backBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
