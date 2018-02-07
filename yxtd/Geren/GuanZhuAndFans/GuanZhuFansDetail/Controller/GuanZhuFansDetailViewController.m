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

@interface GuanZhuFansDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) DetailHeaderView*headerView;

@property (nonatomic,strong)UITableView*tableView;

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
    
 
    
}

#pragma mark -表格视图的代理方法

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    DetailTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:detailCellID];
    
    return cell;
    
    
}



@end
