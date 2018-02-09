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

@interface GuanZhuFansDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) DetailHeaderView*headerView;

@property (nonatomic,strong)UITableView*tableView;


@property (nonatomic,strong) NSArray * allkeys;

@property (nonatomic,strong) NSMutableDictionary * dataDictionary;

@property (nonatomic,assign) CGFloat labelHeight;


@end

@implementation GuanZhuFansDetailViewController

    NSString*detailCellID=@"ID";

-(DetailHeaderView*)headerView{
    
    if (_headerView==nil) {
        
        _headerView=[[DetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, 205)];
        _headerView.backgroundColor=[UIColor lightGrayColor];
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
    
    
    self.allkeys = @[@"A",@"B",@"C"];
    
    
    self.dataDictionary = [NSMutableDictionary dictionary];
    
    for (NSString * keyStr in self.allkeys) {
        
        NSMutableArray * array = [NSMutableArray array];
        int count = arc4random() % 9 + 1;
        
        for (int i = 1; i <= count; i++) {
            
            [array addObject:[NSString stringWithFormat:@"%2d",i]];
        }
        
        [self.dataDictionary setObject:array forKey:keyStr];
    }
    
    
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
    
    NSLog(@"%@",self.user_id);
    NSLog(@"%@",self.is_admin);
    NSLog(@"%@",member_idStr);
    NSLog(@"%@",api_tokenStr);
    
    [ShowUserContentHttp httpShowUserContent:params success:^(id responseObject) {
        
        NSLog(@"粉丝和关注详情页的数据显示================：%@",responseObject);
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

#pragma mark -表格视图的代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.allkeys.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DetailTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:detailCellID];
    
    cell.indexPath = indexPath;
    NSString * keyStr = self.allkeys[indexPath.row];
    NSArray * array = [self.dataDictionary objectForKey:keyStr];
    cell.dataArray = array;
    cell.cellView.ReturnImageClickItemIndex = ^(NSIndexPath *itemtIP, NSInteger itemIndex) {
        
         NSLog(@"----###----###---(%ld,%ld)----##---%ld----###-----",itemtIP.section,itemtIP.row,itemIndex);
    };
    cell.backgroundColor=[UIColor lightGrayColor];
    
    self.labelHeight=cell.getLabelCellHeight;
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHt = 0.0;
    
    NSString * keyStr = self.allkeys[indexPath.row];
    NSArray * array = [self.dataDictionary objectForKey:keyStr];
    
    if (array.count != 0) {
        DetailImageCellView * cellView = [[DetailImageCellView alloc] init];
        cellView.dataArrayCount = array.count;
        cellHt += cellView.cellHeight;
    }
    
    
    return cellHt+160+self.labelHeight;
    
   
    
}



@end
