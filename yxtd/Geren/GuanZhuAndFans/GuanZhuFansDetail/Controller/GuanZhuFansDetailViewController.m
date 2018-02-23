//
//  GuanZhuFansDetailViewController.m
//  yxtd
//
//  Created by qin on 2018/2/6.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "GuanZhuFansDetailViewController.h"
#import "DetailHeaderView.h"
#import "DetailTableViewCell.h"
#import "DetailImageCellView.h"
#import "ShowUserContentHttp.h"
#import "MyFocusParam.h"
#import "DetailFansAndFocusModel.h"
#import "DetailArrayModel.h"

@interface GuanZhuFansDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 *  存放详情页头部的模型
 */
@property (nonatomic, strong) DetailFansAndFocusModel *userHeaderModel;


@property (nonatomic,strong) DetailHeaderView*headerView;

@property (nonatomic,strong)UITableView*tableView;


@property (nonatomic,assign) CGFloat labelHeight;


@property (nonatomic,strong) NSMutableArray*dataArray;


@property (nonatomic,strong) NSMutableArray*imageArray;

@property (nonatomic,strong) NSMutableArray*contentArray;

@end

@implementation GuanZhuFansDetailViewController

    NSString*detailCellID=@"ID";


-(NSMutableArray*)contentArray{
    
    
    if (!_contentArray) {
        
        _contentArray=[NSMutableArray array];
    }
    
    return _contentArray;
    
}

//图片数组懒加载
-(NSMutableArray*)imageArray{
    
    
    if (_imageArray) {
        
        _imageArray=[NSMutableArray array];
        
    }
    
    return _imageArray;
}


//懒加载发布动态话题的内容
-(NSMutableArray*)dataArray{
    
    if (!_dataArray) {
        
        _dataArray=[NSMutableArray array];
    }
    
    return _dataArray;
}

/**
 *  懒加载-当前查看用户的头部信息模型
 */
- (DetailFansAndFocusModel *)userHeaderModel:(NSDictionary *)dict
{
    if(!_userHeaderModel)
    {
        _userHeaderModel = [[DetailFansAndFocusModel alloc] initWithDictionary:dict error:nil];
        
        //传值
        self.headerView.model=_userHeaderModel;
    }
    return _userHeaderModel;
}


-(DetailHeaderView*)headerView{
    
    if (_headerView==nil) {
        
        _headerView=[[DetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, 205)];
        _headerView.backgroundColor=[UIColor lightGrayColor];
        _headerView.is_admin=self.is_admin;
        _headerView.user_id=self.user_id;
    }
    
    return _headerView;
}


-(UITableView*)tableView{
    
    
    if (!_tableView) {
        
        _tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:detailCellID];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    __weak GuanZhuFansDetailViewController*blockSelf=self;
    self.headerView.buttonBackBlock = ^{
      
        [blockSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
   
    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.mas_bottom).mas_offset(0);
    }];
    
    //获取数据
     [self getFansAndFocusDetailHttpData];

    
}

#pragma mark -获取关注和粉丝发布话题的详情数据接口
-(void)getFansAndFocusDetailHttpData{
    

    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    
    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];
    
    NSString*member_idStr=[userInformation objectForKey:@"member_id"];
    
    MyFocusParam*params=[[MyFocusParam alloc] init];
    
    params.api_token=api_tokenStr;
    
    params.member_id=member_idStr;
    
    params.user_id=self.user_id;
    
    params.is_admin=self.is_admin;
    
    
    NSLog(@"api_token值-----------：%@",api_tokenStr);
    NSLog(@"member_idStr----------:%@",member_idStr);
    NSLog(@"user_id---------------:%@",self.user_id);
    NSLog(@"is_admin--------------:%@",self.is_admin);
    
    [ShowUserContentHttp httpShowUserContent:params success:^(id responseObject) {
        
        NSLog(@"粉丝和关注详情页的数据显示================：%@",responseObject);
        
        
        if ([responseObject[@"code"] integerValue]==200) {
            

                self.userHeaderModel=nil;
                
              NSDictionary*info=responseObject[@"data"];
            
                [self userHeaderModel:info];
            
            
               NSArray*array=info[@"list"];
     
            for (NSDictionary*tempDict in array) {
                
                DetailArrayModel*model=[[DetailArrayModel alloc] init];
                [model setValuesForKeysWithDictionary:tempDict];
            
               //数组用来装发布的图片
//                _imageArray=tempDict[@"img_url"];
                
                _imageArray=(NSMutableArray*)model.img_url;
                
                _contentArray=(NSMutableArray*)model.content;
                
                [self.dataArray addObject:model];
                
                [self.tableView reloadData];
                
            }
            
        }
        
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"获取用户详情页头部信息失败");
             
        
    }];
    
    
    
}

#pragma mark -表格视图的代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
   return self.dataArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:detailCellID];
    
    [cell fillCellWithModel:self.dataArray[indexPath.row] indexPath:indexPath];
    
    //头像传值
    cell.model=self.userHeaderModel;
    
    //图片点击的下标
    cell.indexPath = indexPath;
 
    //图片传值
    cell.dataArray = _imageArray;
    
    //发布的内容
    cell.contentArray=_contentArray;
    
    cell.cellView.ReturnImageClickItemIndex = ^(NSIndexPath *itemtIP, NSInteger itemIndex) {
        
         NSLog(@"----###----###---(%ld,%ld)----##---%ld----###-----",itemtIP.section,itemtIP.row,itemIndex);
    };
    cell.backgroundColor=[UIColor lightGrayColor];
    
    self.labelHeight=cell.getLabelCellHeight;
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHt = 0.0;
    
    
    if (_imageArray.count != 0) {
        DetailImageCellView * cellView = [[DetailImageCellView alloc] init];
        cellView.dataArrayCount = _imageArray.count;
        cellHt += cellView.cellHeight;
    }
    
    
    return cellHt+160+self.labelHeight;
    
   
    
}



@end
