//
//  AlreadyEvaluatedViewController.m
//  yxtd
//
//  Created by qin on 2018/1/5.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "AlreadyEvaluatedViewController.h"
#import "ShangJiaTableViewCell.h"

@interface AlreadyEvaluatedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView*tableView;


@end

@implementation AlreadyEvaluatedViewController


NSString*strCellID=@"ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH-64-40)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerClass:[ShangJiaTableViewCell class] forCellReuseIdentifier:strCellID];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShangJiaTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:strCellID];
    cell.starButton.hidden=YES;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


@end
