//
//  StepPaiHangViewController.m
//  yxtd
//
//  Created by qin on 2017/12/15.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "StepPaiHangViewController.h"
#import "UICountingLabel.h"

@interface StepPaiHangViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UICountingLabel*stepNumberLabel;
@property (nonatomic,strong) UILabel*nameLabel;
@property (nonatomic,strong) UITableView*tableView;
@end

@implementation StepPaiHangViewController
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=COLORWITHRGB(63, 72, 76);
    
    [self creatStepHeaderView];
    
    [self setUpPaihangbang];
  
    
}

#pragma mark -布局排行榜
-(void)setUpPaihangbang{
    //背景
    UIView*paihangBgView=[[UIView alloc] init];
    paihangBgView.backgroundColor=[UIColor whiteColor];
    paihangBgView.layer.cornerRadius=5;
    [self.view addSubview:paihangBgView];
    [paihangBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-SYRealValueHeight(73));
    }];
    
    
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"日",@"月",@"总",nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = COLORWITHRGB(49, 58, 63);
    
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [paihangBgView addSubview: segmentedControl];
    
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(19);
        make.right.mas_equalTo(-19);
        make.top.mas_equalTo(21);
        make.height.mas_equalTo(27);
        
    }];
    
    
    UILabel*jiayouLabel=[[UILabel alloc] init];
    jiayouLabel.text=@"元气满满的一天，加油哦~";
    jiayouLabel.textColor=BlackHexColor;
    jiayouLabel.alpha=0.5;
    jiayouLabel.font=[UIFont systemFontOfSize:12];
    [paihangBgView addSubview:jiayouLabel];
    
    [jiayouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
    make.centerX.mas_equalTo(paihangBgView);
        make.top.mas_equalTo(segmentedControl.mas_bottom).offset(15);
    }];
    
    
    UIView*paihangLine=[[UIView alloc] init];
    paihangLine.backgroundColor=btnLineColor;
    [paihangBgView addSubview:paihangLine];
    [paihangLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(paihangBgView.mas_width);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(paihangBgView).offset(0);
       make.top.mas_equalTo(jiayouLabel.mas_bottom).offset(20);
    }];
    
    UITableView*tableView=[[UITableView alloc] init];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    
    [paihangBgView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(paihangBgView.mas_width);
        make.top.mas_equalTo(paihangLine.mas_bottom).offset(2);
        make.bottom.mas_equalTo(-20);
        make.left.mas_equalTo(paihangBgView).offset(0);
    }];
    
    
}

#pragma mark-表格视图代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellID=@"ID";
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text=@"测试";
    cell.textLabel.textColor=[UIColor redColor];
    
    return cell;
}


#pragma mark-分段选择器点击事件
-(void)indexDidChangeForSegmentedControl:(UISegmentedControl*)sender{
    
    NSInteger selecIndex = sender.selectedSegmentIndex;
    
   
    switch(selecIndex){
        case 0:
        
            sender.selectedSegmentIndex=0;


            break;
            
        case 1:

            sender.selectedSegmentIndex = 1;
            
            
            break;
            
        case 2:
            
            sender.selectedSegmentIndex=2;
            
            break;
            
        default:
            break;
    }
    

    
}





#pragma mark-布局头部
-(void)creatStepHeaderView{
    
    UIButton*stepLeftBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [stepLeftBt setBackgroundImage:[UIImage imageNamed:@"leftLoginImage"] forState:UIControlStateNormal];
    [self.view addSubview:stepLeftBt];
    [stepLeftBt addTarget:self action:@selector(setpBtBack) forControlEvents:UIControlEventTouchUpInside];
    [stepLeftBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(33);
        
    }];
    
    
    UIButton*stepShareBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [stepShareBt setBackgroundImage:[UIImage imageNamed:@"step_shareImage"] forState:UIControlStateNormal];
    [self.view addSubview:stepShareBt];
    [stepShareBt addTarget:self action:@selector(shareBt) forControlEvents:UIControlEventTouchUpInside];
    [stepShareBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(stepLeftBt);
        make.right.mas_equalTo(-16);
        
    }];
    
    
    //头像
    UIImageView*iconImageView=[[UIImageView alloc] init];
    iconImageView.backgroundColor=[UIColor redColor];
    iconImageView.layer.cornerRadius=47/2;
    iconImageView.clipsToBounds=YES;
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(stepLeftBt.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake(47, 47));
        
    }];
    
    //昵称
    UILabel*nameLabel=[[UILabel alloc] init];
    self.nameLabel=nameLabel;
    nameLabel.text=@"印度阿三";
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(iconImageView);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(15);
    }];
    
    
    //显示多少步数
    UICountingLabel *stepNumberLabel = [[UICountingLabel alloc] init];
    self.stepNumberLabel=stepNumberLabel;
    stepNumberLabel.font = [UIFont fontWithName:@"Avenir Next" size:24];
    stepNumberLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:stepNumberLabel];
    //设置跳动时间和跳动范围
    [stepNumberLabel jumpNumberWithDuration:1.0f fromNumber:0 toNumber:3259];
    [stepNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(49);
        make.top.mas_equalTo(stepLeftBt.mas_bottom).offset(30);
    }];
    
    
    UIView*stepLineView=[[UIView alloc] init];
    stepLineView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:stepLineView];
    [stepLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(stepNumberLabel.mas_width);
        make.height.mas_equalTo(1);
        make.centerX.equalTo(stepNumberLabel);
        make.top.mas_equalTo(stepNumberLabel.mas_bottom).offset(5);
        
    }];
    
    //步数
    UILabel*stepLabel=[[UILabel alloc] init];
    stepLabel.text=@"步数";
    stepLabel.textColor=[UIColor lightGrayColor];
    stepLabel.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:stepLabel];
    [stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(stepLineView);
        make.top.mas_equalTo(stepLineView.mas_bottom).offset(5);
    }];
    
    
    
    
    
    //显示排名
    UICountingLabel *mingciNumberLabel = [[UICountingLabel alloc] init];
   
    mingciNumberLabel.font = [UIFont fontWithName:@"Avenir Next" size:24];
    mingciNumberLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:mingciNumberLabel];
    //设置跳动时间和跳动范围
    [mingciNumberLabel jumpNumberWithDuration:1.0f fromNumber:0 toNumber:50];
    [mingciNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-49);
        make.centerY.mas_equalTo(stepNumberLabel);
    }];
    
    
    UIView*mingciLineView=[[UIView alloc] init];
    mingciLineView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:mingciLineView];
    [mingciLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(stepNumberLabel.mas_width);
        make.height.mas_equalTo(1);
        make.centerX.equalTo(mingciNumberLabel);
        make.top.mas_equalTo(mingciNumberLabel.mas_bottom).offset(5);
        
    }];
    
    //名次
    UILabel*mingciLabel=[[UILabel alloc] init];
    mingciLabel.text=@"名次";
    mingciLabel.textColor=[UIColor lightGrayColor];
    mingciLabel.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:mingciLabel];
    [mingciLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(mingciLineView);
        make.top.mas_equalTo(mingciLineView.mas_bottom).offset(5);
    }];
    
    
}


#pragma mark-分享按钮点击事件
-(void)shareBt{
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"分享提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

    
    
}
-(void)setpBtBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
