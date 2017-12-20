//
//  FoodDetailsViewController.m
//  yxtd
//
//  Created by qin on 2017/12/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "FoodDetailsViewController.h"
#import "FoodDetailHeaderView.h"
#import "FoodDetailTableViewCell.h"

@interface FoodDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView*bgView;

@property (nonatomic,strong) UITableView*tableView;

@end

@implementation FoodDetailsViewController

 NSString*detailStr=@"ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self addDetailHeaderView];
    
    [self creatCALandKM];
    
    [self creatTavleView];
    
    [self addGoToAddressBt];
}

#pragma mark -导航出发
-(void)addGoToAddressBt{
    
    UIButton*runButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [runButton setTitle:@"导航出发" forState:UIControlStateNormal];
    [runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    runButton.titleLabel.font=[UIFont systemFontOfSize:20];
    [runButton setBackgroundColor:COLORWITHRGB(0, 219, 220)];
    [self.view addSubview:runButton];
    [runButton addTarget:self action:@selector(runBtAction) forControlEvents:UIControlEventTouchUpInside];
    [runButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(KscreenW, 49));
        make.right.bottom.mas_equalTo(0);
    }];
    
    
}

-(void)runBtAction{
    
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"正在导航请稍等" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];

}

#pragma mark -添加表格视图
-(void)creatTavleView{
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0,270 , KscreenW, KscreenH-320)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=110;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[FoodDetailTableViewCell class] forCellReuseIdentifier:detailStr];
    [self.view addSubview:tableView];
   
}



#pragma mark -表格视图代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 15;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoodDetailTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:detailStr];
    
    return cell;
}



#pragma mark -距离和卡路里
-(void)creatCALandKM{
    
    _bgView=[[UIView alloc] init];
    _bgView.backgroundColor=COLORWITHRGB(244, 245, 245);
    [self.view addSubview:_bgView];
    
    UIImageView*distanceImage=[[UIImageView alloc] init];
    distanceImage.image=[UIImage imageNamed:@"distance_Image"];
    [_bgView addSubview:distanceImage];
    
    
    UILabel*distanceLabel=[[UILabel alloc] init];
    
    distanceLabel.text=@"21.2 KM";
    distanceLabel.textColor=BlackHexColor;
    distanceLabel.font=[UIFont systemFontOfSize:12];
    [_bgView addSubview:distanceLabel];
    
    UIImageView*CALImage=[[UIImageView alloc] init];
    CALImage.image=[UIImage imageNamed:@"calorie_Image"];
    [_bgView addSubview:CALImage];
    
    UILabel*CALLabel=[[UILabel alloc] init];
    CALLabel.text=@"128 CAl";
    CALLabel.textColor=BlackHexColor;
    CALLabel.font=[UIFont systemFontOfSize:12];
    [_bgView addSubview:CALLabel];
    
    
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(230);
        make.width.mas_equalTo(self.view);
        
        make.height.equalTo(@44);
        
    }];
    
    [distanceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bgView);
        make.left.equalTo(_bgView).with.offset(60);
    }];
    
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bgView);
        make.left.equalTo(distanceImage.mas_right).with.offset(6);
    }];
    
    [CALLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_bgView);
        make.right.equalTo(_bgView).with.offset(-60);
    }];
    
    [CALImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_bgView);
        make.right.equalTo(CALLabel.mas_left).with.offset(-6);
    }];
    
}


#pragma mark -添加头部视图
-(void)addDetailHeaderView{
    
    FoodDetailHeaderView*detailView=[[FoodDetailHeaderView alloc] init];
     detailView.backgroundColor=[UIColor whiteColor];
     detailView.starNumber=4.5;
    [self.view addSubview:detailView];
    
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(230);
        make.width.mas_equalTo(KscreenW);
    }];
    
    detailView.backToFavoriteVC = ^{
      
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
