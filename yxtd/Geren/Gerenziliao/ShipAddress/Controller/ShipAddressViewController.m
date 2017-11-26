//
//  ShipAddressViewController.m
//  yxtd
//
//  Created by qin on 2017/11/24.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "ShipAddressViewController.h"
#import "AddAddressVC.h"

@interface ShipAddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *addressArr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ShipAddressViewController

static NSString*addresID=@"ID";

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
    
   
    [self initNavi];
    
    [self setUptableView];
    
}

#pragma mark -创建表格视图
-(void)setUptableView{
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
   
}


#pragma mark-表格视图代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:addresID];
    if (!cell) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addresID];
    }
    
    cell.textLabel.text=@"123";
    
    return cell;
}

#pragma mark-初始化导航栏
-(void)initNavi{
    
    
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
    
    AddAddressVC*addressVC=[[AddAddressVC alloc] init];
    
    [self.navigationController pushViewController:addressVC animated:YES];
    
}


-(void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
