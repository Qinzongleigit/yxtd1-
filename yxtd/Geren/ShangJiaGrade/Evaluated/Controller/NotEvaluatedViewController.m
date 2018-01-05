//
//  NotEvaluatedViewController.m
//  yxtd
//
//  Created by qin on 2018/1/5.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "NotEvaluatedViewController.h"
#import "ShangJiaTableViewCell.h"
#import "ShanJiaGradeViewController.h"


@interface NotEvaluatedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView*tableView;



@end

@implementation NotEvaluatedViewController

 NSString*shangjiaID=@"ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    

     UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH-64-40)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];

   [tableView registerClass:[ShangJiaTableViewCell class] forCellReuseIdentifier:shangjiaID];
    
    
   
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ShangJiaTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:shangjiaID];
    
    cell.starVC.hidden=YES;
    
    cell.starButtonBlock = ^{
        
        [self goToShangJiaGradeVC];
    };
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


#pragma mark -跳转到商家评价界面
-(void)goToShangJiaGradeVC{
    
    
    ShanJiaGradeViewController*gradeVC=[[ShanJiaGradeViewController alloc] init];
    
    [self presentViewController:gradeVC animated:YES completion:nil];
    
}

@end
