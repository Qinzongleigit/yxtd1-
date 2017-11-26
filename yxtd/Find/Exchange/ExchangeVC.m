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
    
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 65, KscreenW, KscreenH-49-65)];
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
    
    
    UIView*lineH=[[UIView alloc] initWithFrame:CGRectMake(0, 64, KscreenW, 1)];
    lineH.backgroundColor=btnLineColor;
    [self.view addSubview:lineH];
    
    UIView*naviBgV=[[UIView alloc] init];
    naviBgV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:naviBgV];
    
    
    UIButton*leftBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBt setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(leftBtClick) forControlEvents:UIControlEventTouchUpInside];
    [naviBgV addSubview:leftBt];
    
    
    UILabel*titleLabel=[[UILabel alloc] init];
    titleLabel.text=@"互换";
    titleLabel.font=[UIFont systemFontOfSize:17];
    titleLabel.textColor=BlackHexColor;
    [naviBgV addSubview:titleLabel];
    

    [naviBgV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@64);
    }];
    
    [leftBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(naviBgV.mas_top).with.offset(32);
        make.left.equalTo(naviBgV.mas_left).with.offset(15);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(naviBgV);
        make.top.equalTo(naviBgV.mas_top).with.offset(35);
        make.size.mas_equalTo(CGSizeMake(40, 17));
    }];
    

    
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

-(void)leftBtClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
