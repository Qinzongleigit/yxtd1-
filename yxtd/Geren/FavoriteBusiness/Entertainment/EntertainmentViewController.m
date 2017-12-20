//
//  EntertainmentViewController.m
//  yxtd
//
//  Created by 覃宗雷 on 2017/12/19.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "EntertainmentViewController.h"
#import "EntertainmentTableViewCell.h"
#import "FoodDetailsViewController.h"

@interface EntertainmentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView*tableView;


@end

@implementation EntertainmentViewController

  NSString*cellStrID=@"ID";

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
    
    [tableView registerClass:[EntertainmentTableViewCell class] forCellReuseIdentifier:cellStrID
     ];
    [self.view addSubview:tableView];
    
    
}


#pragma mark -表格视图代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 15;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EntertainmentTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellStrID];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
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
