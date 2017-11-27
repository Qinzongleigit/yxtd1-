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
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH-49-64)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;

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
    
    
    UIButton*addBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [addBt setTitle:@"添加地址" forState:UIControlStateNormal];
    [addBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBt setBackgroundColor:COLORWITHRGB(43, 51, 55)];
    [addBt addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBt];
    
    [addBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@49);
    }];
    
    

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
