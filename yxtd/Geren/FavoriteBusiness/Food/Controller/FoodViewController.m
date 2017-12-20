//
//  FoodViewController.m
//  yxtd
//
//  Created by 覃宗雷 on 2017/12/19.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "FoodViewController.h"
#import "FoodTableViewCell.h"
#import "FoodDetailsViewController.h"

@interface FoodViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView*tableView;

@end

@implementation FoodViewController

  NSString*cellID=@"ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH-64-40)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=115;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [tableView registerClass:[FoodTableViewCell class] forCellReuseIdentifier:cellID
     ];
    [self.view addSubview:tableView];
    
   
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.selectionStyle=UITableViewCellEditingStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    FoodDetailsViewController*detailVC=[[FoodDetailsViewController alloc] init];
    [self presentViewController:detailVC animated:YES completion:nil];
    
    //反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
