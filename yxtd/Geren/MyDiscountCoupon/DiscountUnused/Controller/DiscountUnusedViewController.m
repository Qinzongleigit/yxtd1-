//
//  DiscountUnusedViewController.m
//  yxtd
//
//  Created by 覃宗雷 on 2017/12/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "DiscountUnusedViewController.h"
#import "UnusedTableViewCell.h"

@interface DiscountUnusedViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView*tableView;

@end

@implementation DiscountUnusedViewController

    NSString*unusedID=@"ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH-64-40)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.rowHeight=174;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor whiteColor];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerClass:[UnusedTableViewCell class] forCellReuseIdentifier:unusedID];

   
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UnusedTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:unusedID];
    cell.backgroundColor=[UIColor whiteColor];
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
