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

@interface GuanZhuFansDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) DetailHeaderView*headerView;

@property (nonatomic,strong)UITableView*tableView;


@property (nonatomic,strong) NSArray * allkeys;

@property (nonatomic,strong) NSMutableDictionary * dataDictionary;



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
    
    return cellHt+220;
    
}



@end
