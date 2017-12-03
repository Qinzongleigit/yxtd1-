//
//  TopicVC.m
//  yxtd
//
//  Created by qin on 2017/11/10.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "TopicVC.h"

@interface TopicVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView*tableView;

@end

@implementation TopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initNavi];
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 65, KscreenW, KscreenH-64)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=100;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString*cellID=@"topID";
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    UIImageView*cellImage=[[UIImageView alloc] init];
    //cellImage.frame=CGRectMake(5, 5, KscreenW-10, 90);
    cellImage.backgroundColor=[UIColor redColor];
    cellImage.layer.cornerRadius=5;
    cellImage.clipsToBounds=YES;
    [cell.contentView addSubview:cellImage];
    
    [cellImage mas_makeConstraints:^(MASConstraintMaker *make) {

        make.center.equalTo(cell);
        make.edges.mas_offset(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    
    return cell;
}


#pragma mark-自定义导航栏
-(void)initNavi{
    
    
    
    UIView*lineH=[[UIView alloc] initWithFrame:CGRectMake(0, 64, KscreenW, 1)];
    lineH.backgroundColor=btnLineColor;
    [self.view addSubview:lineH];
    
    UIView*naviBgV=[[UIView alloc] init];
    naviBgV.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:naviBgV];
    
    
    UIButton*leftBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBt setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(leftBtClick) forControlEvents:UIControlEventTouchUpInside];
    [naviBgV addSubview:leftBt];
    
    
    UILabel*titleLabel=[[UILabel alloc] init];
    titleLabel.text=@"话题";
    titleLabel.font=[UIFont systemFontOfSize:17];
    titleLabel.textColor=BlackHexColor;
    [naviBgV addSubview:titleLabel];
    
    
    [naviBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@64);
    }];
    
    [leftBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(naviBgV.mas_top).with.offset(32);
        make.left.equalTo(naviBgV.mas_left).with.offset(15);
    }];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(naviBgV);
        make.top.equalTo(naviBgV.mas_top).with.offset(35);
        make.size.mas_equalTo(CGSizeMake(40, 17));
    }];
    
}

-(void)leftBtClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
