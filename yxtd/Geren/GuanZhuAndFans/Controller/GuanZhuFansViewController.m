//
//  GuanZhuFansViewController.m
//  yxtd
//
//  Created by qin on 2018/1/26.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "GuanZhuFansViewController.h"
#import "TitleView.h"
#import "GuanZhuTableViewCell.h"
#import "MineUserMessageParam.h"
#import "GuanZhuHttp.h"
#import "FansHttp.h"
#import "GuanZhuModel.h"

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
    
    [self getGuanZhuHttpData];
    
  
    
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
        
           NSLog(@"粉丝接口返回的信息==================:%@",responseObject);
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
        
        NSLog(@"关注接口返回的信息==================:%@",responseObject);
        
        
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
    
    if (self.selectTag==101) {
        
        return self.dataFansArr.count;
        
    }else{
        
    return self.dataArr.count;
        
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

  
    GuanZhuTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellStr forIndexPath:indexPath];
    
    if (self.selectTag==101) {

       [cell fillCellWithModel:_dataFansArr[indexPath.row] indexPath:indexPath];

    }else{
    
       [cell fillCellWithModel:_dataArr[indexPath.row] indexPath:indexPath];
    }
    
    
    return cell;
}


#pragma mark -初始化导航栏
-(void)initNavi{
    
    
    TitleView*titleView =[[TitleView alloc] init];
    titleView.backgroundColor=[UIColor clearColor];
    self.titleView=titleView;
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
               
                 //粉丝点击
               }else{
                     //关注点击
                   [blockSelf getGuanZhuHttpData];
               }
    };

    [self.rightBt setBackgroundImage:[UIImage imageNamed:@"addguanzhu_Image"] forState:UIControlStateNormal];
    
    
}

-(void)rightBtnClick{
    
    NSLog(@"添加了关注");
    
    
}



@end
