//
//  MineViewController.m
//  yxtd
//
//  Created by qin on 2017/9/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "MineViewController.h"
#import "MineOneCell.h"
#import "GeRenZiLiaoViewController.h"
#import "JiFenViewController.h"




@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView*tableView;

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSArray *dataSource1;
@property (nonatomic,strong) NSArray *dataSource_;
@property (nonatomic,strong) NSArray *dataSource1_;
@property (nonatomic,strong) NSArray *dataSource2;
@property (nonatomic,strong) NSArray *dataSource2_;
@end

@implementation MineViewController

  static NSString*cellID=@"ID";
  static NSString*oneCell=@"cell";



- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH-49-64)];
    self.tableView=tableView;
    tableView.showsVerticalScrollIndicator=NO;
    tableView.delegate=self;
    tableView.dataSource=self;
    self.tableView=tableView;
    [self.view addSubview:tableView];
    tableView.separatorInset=UIEdgeInsetsMake(0, 16, 0, 15);
 
    [tableView registerClass:[MineOneCell class] forCellReuseIdentifier:oneCell];
    
    //实例化装主标题的数组
    _dataSource = [[NSArray alloc] init];
    _dataSource1 =[NSArray array];
    
    _dataSource=@[@"奖章",@"步数排行"];
    _dataSource1=@[@"我的优惠券",@"收藏商家",@"商家打星",@"我的活动",@"兑换记录"];
    _dataSource2=@[@"关于",@"评价",@"意见反馈"];
    
    _dataSource_=@[@"jiangzhang_Image",@"paihang_Image"];
    
 _dataSource1_=@[@"youhuiquan_Image",@"shangjia_Image",@"shangjiastar_Image",@"ranking",@"jilu_Image"];
    _dataSource2_=@[@"guanyu_Image",@"pingjia_Image",@"yijian_Image"];
    
    [self initNavi];

    
}


//设置段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 12;
}
//组尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
  
        UIView*footerView=[[UIView alloc] init];
        
        footerView.backgroundColor=btnLineColor;
 
        return footerView;
 
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (!indexPath.section) {
        
        if (indexPath.row==0) {
            
            return 108;
            
        }else if (indexPath.row==1){
            
            return 90;
        }
    }
    return 60;
    
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        
        return 3;
        
    }else if (section==1){
        
        return 2;
    }else if (section==2){
        
        return 5;
    }else{
        
        return 3;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   if (indexPath.section==0&&indexPath.row==0) {
       
       MineOneCell*Onecell=[tableView dequeueReusableCellWithIdentifier:oneCell];
       
       UIImageView*imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cee_rightImage"]];
       
       [Onecell.contentView addSubview:imageView];
       
       [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.centerY.equalTo(Onecell);
           make.size.mas_equalTo(CGSizeMake(9, 16));
           make.right.equalTo(Onecell.contentView).with.offset(-15);
       }];
       
       Onecell.selectionStyle=UITableViewCellEditingStyleNone;
        return Onecell;
       
       

   }else{
       
       UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
       if (!cell) {
           
           cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];

       }else{
           
           //消除cell的重影
           for (UIView*view in cell.contentView.subviews) {
               
               [view removeFromSuperview];
           }
       }
       
       
       if (!indexPath.section&&indexPath.row==1) {
           
           NSMutableArray*cellArray=[NSMutableArray new];
           
           for (int i=0; i<5; i++) {
               
               UIView*cellView=[UIView new];
               cellView.backgroundColor=[UIColor greenColor];
               cellView.layer.cornerRadius=5;
               cellView.clipsToBounds=YES;
               [cell.contentView addSubview:cellView];
               
               [cellArray addObject:cellView];
           }
           //水平方向控件间隔固定等间隔
           [cellArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:9 leadSpacing:14 tailSpacing:14];
           
           [cellArray mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(@15);
               make.height.equalTo(@60);
           }];
           
           
       }else{
           
           UIImageView*imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cee_rightImage"]];
           
           [cell.contentView addSubview:imageView];
           
           [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.size.mas_equalTo(CGSizeMake(9, 16));
               make.centerY.equalTo(cell);
               make.right.equalTo(cell.contentView).with.offset(-15);
           }];
       }
       

       UILabel*label=[[UILabel alloc] init];
       label.font=[UIFont systemFontOfSize:15];
       label.textColor=BlackHexColor;
       [cell.contentView addSubview:label];
       
       UIImageView*imageView0=[[UIImageView alloc] init];
       [cell.contentView addSubview:imageView0];
       
       [imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.centerY.equalTo(cell.contentView);
           make.left.equalTo(cell.mas_left).with.offset(22);
       }];
       
       [label mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.left.equalTo(imageView0.mas_right).with.offset(15);
           make.centerY.equalTo(imageView0);
           
       }];
       
       if (!indexPath.section) {
           
           if (indexPath.row==2) {

               imageView0.image=[UIImage imageNamed:@"jifen_Image"];

               label.text=@"积分";
             
  
               UILabel*label1=[[UILabel alloc] init];
               label1.text=@"兑换装备";
               label1.font=[UIFont systemFontOfSize:15];
               label1.textColor=COLORWITHRGB(0,219,220);
               [cell.contentView addSubview:label1];
 
               [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                   
                   make.centerY.equalTo(cell.contentView);
                   make.right.equalTo(cell.mas_right).with.offset(-40);
               }];
           }
       }else if (indexPath.section==1){
           
           label.text=_dataSource[indexPath.row];

           imageView0.image=[UIImage imageNamed:_dataSource_[indexPath.row]];
         
       }else if (indexPath.section==2){

           label.text=_dataSource1[indexPath.row];

           imageView0.image=[UIImage imageNamed:_dataSource1_[indexPath.row]];

       }else if(indexPath.section==3){

           label.text=_dataSource2[indexPath.row];
          
           imageView0.image=[UIImage imageNamed:_dataSource2_[indexPath.row]];
     
       }
       cell.selectionStyle=UITableViewCellEditingStyleNone;
       
       return cell;
   }
    
}


#pragma mark -选中某行跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //第一组
    if (!indexPath.section) {
        
        if (!indexPath.row) {
            GeRenZiLiaoViewController*ziliaoVC=[[GeRenZiLiaoViewController alloc] init];

            ziliaoVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:ziliaoVC animated:YES];
          
            
        }if (indexPath.row==2) {
            
            JiFenViewController*jifenVc=[[JiFenViewController alloc] init];
             jifenVc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:jifenVc animated:YES];

        }
    }
  
    //反选
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


-(void)initNavi{

    UIBarButtonItem*rightBarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoriginName:@"run_NavLeft"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButton)];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    

}




-(void)rightButton{
    
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"消息提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
