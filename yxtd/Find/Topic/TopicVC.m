//
//  TopicVC.m
//  yxtd
//
//  Created by qin on 2017/11/10.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "TopicVC.h"

@interface TopicVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView*tableView;

@end

@implementation TopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initNavi];
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 65, KscreenW, KscreenH-64)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=100;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString*cellID=@"topID";
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    UIImageView*cellImage=[[UIImageView alloc] init];
    //cellImage.frame=CGRectMake(5, 5, KscreenW-10, 90);
    cellImage.backgroundColor=[UIColor redColor];
    cellImage.layer.cornerRadius=5;
    cellImage.clipsToBounds=YES;
    [cell.contentView addSubview:cellImage];
    
    [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {

        make.center.equalTo(cell);
        make.edges.mas_offset(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    
    return cell;
}


#pragma mark-自定义导航栏
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
    navigationItem.title = @"话题";
    
    
    
}

-(void)backBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
