//
//  MySportsController.m
//  yxtd
//
//  Created by 覃宗雷 on 2018/1/14.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "MySportsController.h"
#import "MySportsTableViewCell.h"

@interface MySportsController ()

@end

@implementation MySportsController

   NSString*strID=@"ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"我的活动";
    
    //左边按钮
    UIBarButtonItem*leftBt=[[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoriginName:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(spotrsBackBtn)];
    self.navigationItem.leftBarButtonItem=leftBt;
    
    [self.tableView registerClass:[MySportsTableViewCell class] forCellReuseIdentifier:strID];
    
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    MySportsTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:strID];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


-(void)spotrsBackBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
