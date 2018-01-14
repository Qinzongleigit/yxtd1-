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
#import "TwoDimensionCodeVC.h"
#import "HuatiDongtaiViewController.h"
#import "JiangZhangTableViewController.h"
#import "StepPaiHangViewController.h"
#import "MyDiscountViewController.h"
#import "FavoriteViewController.h"
#import "ShangJiaViewController.h"

#import "RankingViewController.h"

#import "ExchangeRecordsViewController.h"
#import "AboutUsViewController.h"
#import "FeedbackViewController.h"
#import "MySportsController.h"




@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView*tableView;

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSArray *dataSource1;
@property (nonatomic,strong) NSArray *dataSource_;
@property (nonatomic,strong) NSArray *dataSource1_;
@property (nonatomic,strong) NSArray *dataSource2;
@property (nonatomic,strong) NSArray *dataSource2_;

@property (nonatomic,strong) UIButton*publishBt;

@end

@implementation MineViewController

  static NSString*cellID=@"ID";
  static NSString*oneCell=@"cell";


-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=NO;
   self.navigationController.navigationBar.hidden=NO;
    
 
}

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
    }else if (section==4){
        
        return 1;
        
    }else {
        
        return 3;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 5;
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
      
       Onecell.codeBtBlock = ^{
          //跳转到二维码界面
           TwoDimensionCodeVC*codeVC=[[TwoDimensionCodeVC alloc] init];
          
           [self presentViewController:codeVC animated:YES completion:nil];
           
       };
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
       
    //第一组二行
       if (!indexPath.section&&indexPath.row==1) {
           
           //从没有发布过动态时显示的界面
           [cell.contentView addSubview:self.publishBt];
           [_publishBt mas_makeConstraints:^(MASConstraintMaker *make) {
               make.center.equalTo(cell);
               make.width.equalTo(cell.mas_width).multipliedBy(0.72);
               make.height.mas_offset(@35);
           }];
           
#warning 有动态的时候显示的界面，没有数据先不显示
#if 0
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
           
#endif
           
           //第五组
       }else if (indexPath.section==4) {
          
           UILabel*outLabel=[[UILabel alloc] init];
           outLabel.text=@"退出登录";
           outLabel.font=[UIFont systemFontOfSize:14];
           outLabel.textColor=[UIColor redColor];
           outLabel.textAlignment=NSTextAlignmentCenter;
           [cell.contentView addSubview:outLabel];
           [outLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(cell.contentView);
               
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

            [self.navigationController pushViewController:ziliaoVC animated:YES];
          
            //积分商城
        }if (indexPath.row==2) {
            
            JiFenViewController*jifenVc=[[JiFenViewController alloc] init];
            
             jifenVc.hidesBottomBarWhenPushed=YES;
            
            [self.navigationController presentViewController:jifenVc animated:YES completion:nil];

        }
        //第五组
    }if (indexPath.section==4) {
        
        UIAlertController*alter=[UIAlertController alertControllerWithTitle:@"退出登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction*cancleAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        
        UIAlertAction*sureAction=[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }] ;

        
        [alter addAction:cancleAction];
        [alter addAction:sureAction];
        [self presentViewController:alter animated:YES completion:nil];
       //第二组
    }else if (indexPath.section==1){
        
        if (!indexPath.row) {
            //奖章
            JiangZhangTableViewController*jiangzhangVC=[[JiangZhangTableViewController alloc] init];
            [self.navigationController pushViewController:jiangzhangVC animated:YES];
            
        }else if (indexPath.row==1){
            //步数排行
            StepPaiHangViewController*stepVC=[[StepPaiHangViewController alloc] init];

            [self presentViewController:stepVC animated:YES completion:nil];
   
        }
        //第三组
    }else if (indexPath.section==2){
        
        if (!indexPath.row) {
            
            MyDiscountViewController*myDiscountVC=[[MyDiscountViewController alloc] init];
            myDiscountVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:myDiscountVC animated:YES];
            
        }else if (indexPath.row==1){
            
            FavoriteViewController*favoriteVC=[[FavoriteViewController alloc] init];
            favoriteVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:favoriteVC animated:YES ];
            
        }else if (indexPath.row==2){
            
            ShangJiaViewController*shangjiaVC=[[ShangJiaViewController alloc] init];
            shangjiaVC.hidesBottomBarWhenPushed=YES;
            
            [self.navigationController pushViewController:shangjiaVC animated:YES];
            
     
        }else if (indexPath.row==3){
            
     
            MySportsController*sportsVC=[[MySportsController alloc] init];
            sportsVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:sportsVC animated:YES];
            
        }else if (indexPath.row==4){
            
           
            ExchangeRecordsViewController*recodesVC=[[ExchangeRecordsViewController alloc] init];
            
            
            [self presentViewController:recodesVC animated:YES completion:nil];
            
        }
        //第四组
    }else if (indexPath.section==3){
        
        if (!indexPath.row) {
            
            AboutUsViewController*aboutVC=[[AboutUsViewController alloc] init];
            
              [self.navigationController presentViewController:aboutVC animated:YES completion:nil];
            //跳转到appStore评价
        }else if (indexPath.row==1){
            NSString*APPID=@"1138754653";
            
              NSString *itunesurl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8&action=write-review",APPID];
            
            //手机系统判断
            NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
            
            
            if (phoneVersion.floatValue<10) {
                
                //iOS10 以前使用
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
                
            }else{
                
                //iOS10 以后使用
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl] options:@{} completionHandler:nil];
                
            }
            
         
           //意见反馈
        }else if (indexPath.row==2){
            
            FeedbackViewController*feedbackVC=[[FeedbackViewController alloc] init];
             feedbackVC.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:feedbackVC animated:YES];
           
            
        }
    }
    //反选
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark -发布动态
-(UIButton*)publishBt{
    
    if (_publishBt==nil) {
        
        _publishBt=[UIButton buttonWithType:UIButtonTypeCustom];
        _publishBt.backgroundColor=COLORWITHRGB(234, 235, 235);
        [_publishBt setTitle:@"发布第一条动态" forState:UIControlStateNormal];
        [_publishBt setTitleColor:COLORWITHRGB(49, 58, 63) forState:UIControlStateNormal];
        _publishBt.titleLabel.alpha=0.5;
        [_publishBt addTarget:self action:@selector(publishBtClick) forControlEvents:UIControlEventTouchUpInside];
        _publishBt.titleLabel.font=[UIFont systemFontOfSize:15];
        _publishBt.layer.cornerRadius=18;
        _publishBt.clipsToBounds=YES;
    }
    
    return _publishBt;
}


#pragma mark -发布第一条动态点击事件
-(void)publishBtClick{
   
 HuatiDongtaiViewController*dongtaiVC=[[HuatiDongtaiViewController alloc] init];
    
    [self.navigationController pushViewController:dongtaiVC animated:YES];
    
}

-(void)initNavi{

    UIBarButtonItem*rightBarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoriginName:@"run_NavLeft"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButton)];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    
}




-(void)rightButton{
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"消息提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

}





@end
