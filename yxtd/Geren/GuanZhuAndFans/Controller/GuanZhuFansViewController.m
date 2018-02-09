//
//  GuanZhuFansViewController.m
//  yxtd
//
//  Created by qin on 2018/1/26.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "GuanZhuFansViewController.h"
#import "AddGuanZhuViewController.h"
#import "TitleView.h"
#import "GuanZhuTableViewCell.h"
#import "MineUserMessageParam.h"
#import "GuanZhuHttp.h"
#import "FansHttp.h"
#import "GuanZhuModel.h"
#import "GuanZhuFansDetailViewController.h"

@interface GuanZhuFansViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) TitleView*titleView;

@property (nonatomic,strong) UITableView*tableView;

@property (nonatomic,strong) NSMutableArray*dataArr;

@property (nonatomic,strong) NSMutableArray*dataFansArr;

@property (nonatomic,assign) NSInteger selectTag;

@end

@implementation GuanZhuFansViewController

  NSString*cellStr=@"ID";

-(NSMutableArray*)dataArr{
    
    if (_dataArr==nil) {
        
        _dataArr=[NSMutableArray array];
        
        
    }
    return _dataArr;
}

-(NSMutableArray*)dataFansArr{
    
    if (!_dataFansArr) {
        
        _dataFansArr=[NSMutableArray array];
    }
    
    return _dataFansArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initNavi];

    [self creatTableView];
    
    if (self.tag==1001) {
        
        [self getFansHttpData];
    }else{
        
        [self getGuanZhuHttpData];
    }
    
}

#pragma mark -粉丝网络接口信息

-(void)getFansHttpData{
    
    
    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    
    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];
    
    NSString*member_idStr=[userInformation objectForKey:@"member_id"];
    
    MineUserMessageParam*params=[[MineUserMessageParam alloc] init];
    
    params.api_token=api_tokenStr;
 
    //先用member_id为1来测试
    params.member_id=member_idStr;
    
    
    [self.dataFansArr removeAllObjects];
    
    [FansHttp httpFans:params success:^(id responseObject) {
        
        if ([responseObject[@"code"] integerValue]==200) {
            
            NSArray *array=responseObject[@"data"];
            
            // 字段转模型
            for(NSDictionary *tempDict in array){
                
                GuanZhuModel *model = [[GuanZhuModel alloc] init];
                
                [model setValuesForKeysWithDictionary:tempDict];
                
                [self.dataFansArr addObject:model];

                [_tableView reloadData];
                
            }
        }
        
    } failure:^(NSError *error) {
       
        NSLog(@"粉丝获取失败");
    }];
    
}


#pragma mark -获取关注网络接口信息
-(void)getGuanZhuHttpData{
   
    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    
    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];
    
    NSString*member_idStr=[userInformation objectForKey:@"member_id"];
    
  MineUserMessageParam*params=[[MineUserMessageParam alloc] init];

    params.api_token=api_tokenStr;

    //先用member_id为1来测试
    params.member_id=@"1";
    
    [self.dataArr removeAllObjects];
    
    [GuanZhuHttp httpGuanzhu:params success:^(id responseObject) {
        
  
        if ([responseObject[@"code"] integerValue]==200) {
            
           NSArray *array=responseObject[@"data"];
            
            // 字段转模型
            for(NSDictionary *tempDict in array){
                
                GuanZhuModel *model = [[GuanZhuModel alloc] init];
                
                [model setValuesForKeysWithDictionary:tempDict];
                
               [self.dataArr addObject:model];
                
                
               [_tableView reloadData];
                
            }
        }
            
        
    } failure:^(NSError *error) {
       
        NSLog(@"关注接口获取信息失败");
        
    }];
    
    
}

#pragma mark -创建关注tableView
-(void)creatTableView{

    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH-64)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=70;
    [self.view addSubview:tableView];
    [tableView registerClass:[GuanZhuTableViewCell class] forCellReuseIdentifier:cellStr];
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    if (self.selectTag==101||self.tag==1001) {
        
          //从粉丝点击进入
        if (self.selectTag==100) {
            
            return self.dataArr.count;
        }else{
            
        return self.dataFansArr.count;
            
        }
        
    }else{
        
      
    return self.dataArr.count;
        
    }
    return 0;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

  
    GuanZhuTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellStr forIndexPath:indexPath];
    
    if (self.selectTag==101||self.tag==1001) {
        //从粉丝点击进入
        if (self.selectTag==100) {
             [cell fillCellWithModel:_dataArr[indexPath.row] indexPath:indexPath];
            
        }else{

       [cell fillCellWithModel:_dataFansArr[indexPath.row] indexPath:indexPath];
        }

    }else{
    
       [cell fillCellWithModel:_dataArr[indexPath.row] indexPath:indexPath];
    }
    
    
    return cell;
}


//点击选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GuanZhuModel *model= self.dataArr[indexPath.row];
    GuanZhuFansDetailViewController*detailVC=[[GuanZhuFansDetailViewController alloc] init];
    
    detailVC.user_id=model.focus_id;
    detailVC.is_admin=model.flag;
    
    [self.navigationController presentViewController:detailVC animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark -初始化导航栏
-(void)initNavi{
    
    
    TitleView*titleView =[[TitleView alloc] init];
    titleView.backgroundColor=[UIColor clearColor];
    self.titleView=titleView;
    self.titleView.numTag=self.tag;
    self.navigationItem.titleView = self.titleView;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(200, 44));
    }];
    
    __block GuanZhuFansViewController *blockSelf = self;
    
    self.titleView.titleBtBlock = ^(NSInteger tag) {
        
        blockSelf.selectTag=tag;
        
           //粉丝点击
           if (blockSelf.selectTag==101) {
              
                [blockSelf getFansHttpData];
               
               }else{
                     //关注点击
                   [blockSelf getGuanZhuHttpData];
               }
    };

    [self.rightBt setBackgroundImage:[UIImage imageNamed:@"addguanzhu_Image"] forState:UIControlStateNormal];
    
    
}

-(void)rightBtnClick{
    
    
    AddGuanZhuViewController*addguanzhuVC=[[AddGuanZhuViewController alloc] init];
    addguanzhuVC.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:addguanzhuVC animated:YES];
    
    
}



@end
