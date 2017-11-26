//
//  SaiShiDetailedViewController.m
//  yxtd
//
//  Created by qin on 2017/9/18.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "SaiShiDetailedViewController.h"
#import "SaiShiDetailedHeaderView.h"

@interface SaiShiDetailedViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView*tableView;
@property (nonatomic,strong)SaiShiDetailedHeaderView*headerView;

@end

 static NSString*cellID=@"yxtd";

@implementation SaiShiDetailedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
 
    //表格视图
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH-49) style:UITableViewStylePlain];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
   tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    [self setUpTableViewHeaderView];
    
    [self setUpTableViewFootView];
    
    
    
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, KscreenH-49, KscreenW, 49)];
    style.layer.backgroundColor = [[UIColor colorWithRed:49.0f/255.0f green:58.0f/255.0f blue:63.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 1;
    
    
    
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(KscreenW/2-94/2, 13, 94, 21);
    [button setTitle:@"立即报名" forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [style addSubview:button];
    
    
    [self.view addSubview:style];
    
    
    
    
}



-(void)buttonClick:(UIButton*)btClick{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"立即报名?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

    
}


#pragma mark --tableView的代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
 
    return cell;
}



#pragma mark -  设置表头视图
- (void)setUpTableViewHeaderView
{
    
    [self.headerView removeFromSuperview];
    
    self.headerView = nil;
    
    SaiShiDetailedHeaderView *headerView = [[SaiShiDetailedHeaderView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, 352)];
    
   headerView.myIndexBlock = ^(NSInteger index) {
        
       if (index==100) {
           [self dismissViewControllerAnimated:YES completion:nil];
       }else{
           
           UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"分享提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
           [alter show];

       }
    };
    
    self.headerView = headerView;
    
   headerView.backgroundColor =btnLineColor;
    
    self.tableView.tableHeaderView = headerView;
    
}



-(void)setUpTableViewFootView{
    
    
    
    UIView*footView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, 300)];
    footView.backgroundColor=[UIColor whiteColor];
    
    
    self.tableView.tableFooterView = footView;
    
    UIView*rightLine=[[UIView alloc] initWithFrame:CGRectMake(16, 16, 4, 16)];
    rightLine.backgroundColor=GreenkHexColor;
    [footView addSubview:rightLine];
    
    
    UILabel*saishilabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rightLine.frame)+7, 17, 52, 12)];
    saishilabel.text=@"赛事介绍";
    saishilabel.font=[UIFont systemFontOfSize:12];
    saishilabel.textColor=BlackHexColor;
    saishilabel.textAlignment=NSTextAlignmentLeft;
    
    
    UILabel*saishilabel1=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(saishilabel.frame)+15, KscreenW-20, 48)];
    saishilabel1.text=@"1.报名该赛事需要消耗300积分，赛事完成者积分返还,未在规定时间完成赛事则积分消耗。（积分返还跟奖励不冲突）";
    saishilabel1.font=[UIFont systemFontOfSize:12];
    saishilabel1.textColor=BlackHexColor;
    saishilabel1.numberOfLines=0;
    saishilabel1.textAlignment=NSTextAlignmentLeft;
    
    UILabel*saishilabel2=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(saishilabel1.frame)+14, KscreenW-20, 12)];
    saishilabel2.text=@"2.完成赛事，领取奖励方式在（我的-参加赛事）中查看。";
    saishilabel2.font=[UIFont systemFontOfSize:12];
    saishilabel2.numberOfLines=0;
    saishilabel2.textColor=BlackHexColor;
    saishilabel2.textAlignment=NSTextAlignmentLeft;
    
    
    UILabel*saishilabel3=[[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(saishilabel2.frame)+20, KscreenW, 12)];
    saishilabel3.text=@"3.该赛事最终解释权为跑券官方所有。";
    saishilabel3.font=[UIFont systemFontOfSize:12];
    saishilabel3.textColor=BlackHexColor;
    saishilabel3.textAlignment=NSTextAlignmentLeft;
    
    [footView addSubview:saishilabel];
    [footView addSubview:saishilabel1];
    [footView addSubview:saishilabel2];
    [footView addSubview:saishilabel3];
    
    
    
    UIView*rightLine2=[[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(saishilabel3.frame)+32, 4, 16)];
    rightLine2.backgroundColor=GreenkHexColor;
    [footView addSubview:rightLine2];
    
    
    UILabel*jianglilabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rightLine2.frame)+7, CGRectGetMaxY(saishilabel3.frame)+33, 52, 12)];
    jianglilabel.text=@"赛事奖励";
    jianglilabel.font=[UIFont systemFontOfSize:12];
    jianglilabel.textColor=BlackHexColor;
    jianglilabel.textAlignment=NSTextAlignmentLeft;
    
    [footView addSubview:jianglilabel];
    
    
    UIView*imageView=[[UIView alloc] initWithFrame:CGRectMake(27, CGRectGetMaxY(jianglilabel.frame)+14, 94, 59)];
    imageView.backgroundColor=[UIColor purpleColor];
    [footView addSubview:imageView];
    
    
    for (int i=0; i<3; i++) {
        
    }
    UILabel*awardlabel=[[UILabel alloc] initWithFrame:CGRectMake(KscreenW-16-160, CGRectGetMaxY(jianglilabel.frame)+36, 160, 15)];
    awardlabel.text=@"100元男女运动服装";
    awardlabel.textColor=BlackHexColor;
    awardlabel.font=[UIFont systemFontOfSize:15];
    [footView addSubview:awardlabel];
    
    
}



@end
