//
//  SaiShiViewController.m
//  yxtd
//
//  Created by qin on 2017/9/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "SaiShiViewController.h"
#import "SaiShiDetailedViewController.h"
#import "MyTabarController.h"

@interface SaiShiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView*tableView;
@property (nonatomic,strong) MyTabarController*tabbar;
@end

@implementation SaiShiViewController

-(void)viewWillAppear:(BOOL)animated{

   //self.tabbar.tabBar.hidden=YES;
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [self creatableView];
}



#pragma mark --创建赛事界面
-(void)creatableView{

    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-66-49) style:UITableViewStylePlain];

    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=100;
    tableView.backgroundColor=[UIColor whiteColor];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:tableView];


}

#pragma mark --tableVie代理方法的实现

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString*cellStr=@"cellID";

    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {

        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }

    UIImageView*imageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.view.frame.size.width-20, 90)];
    imageView.backgroundColor=[UIColor purpleColor];
    imageView.layer.cornerRadius=10;
    imageView.clipsToBounds=YES;
    [cell addSubview:imageView];

    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"----------第%ld个点击了------------",indexPath.row);
    
    SaiShiDetailedViewController*saishiVC=[[SaiShiDetailedViewController alloc] init];
    
    [self presentViewController:saishiVC animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
