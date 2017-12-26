//
//  ExchangeRecordsViewController.m
//  yxtd
//
//  Created by qin on 2017/12/26.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "ExchangeRecordsViewController.h"
#import "RecodeTimeLineTableViewCell.h"

@interface ExchangeRecordsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *tableView;
//@property(strong,nonatomic)UIView *topLine;
@property(strong,nonatomic)UIView *bottomLine;

@property(assign,nonatomic)CGFloat leadingSpaceOfLines;

@property(strong,nonatomic)NSArray *dataArray;

@end

@implementation ExchangeRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor grayColor];
    
    //返回按钮
    UIButton*recodesBackBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [recodesBackBt setBackgroundImage:[UIImage imageWithoriginName:@"leftLoginImage"] forState:UIControlStateNormal];
    [recodesBackBt addTarget:self action:@selector(recodesBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recodesBackBt];
    
    [recodesBackBt mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(10);
    }];
    
    
     [self addTableView];
    
    
}

- (void)addTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor = [UIColor grayColor];
   self.tableView.separatorColor =[UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    self.bottomLine = [UIView new];
    self.bottomLine.backgroundColor = btnLineColor;

    [self.view addSubview:self.bottomLine];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    RecodeTimeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[[ NSBundle mainBundle ]loadNibNamed:@"RecodeTimeLineTableViewCell" owner:nil options:nil] firstObject];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row==0) {
        
        cell.topLineView.hidden=YES;
        
        cell.recodeLabel.text=_dataArray[indexPath.row];
        cell.roundView.frame=CGRectMake(16, 14, 42, 42);
        cell.roundView.layer.cornerRadius=42/2;
        cell.roundView.clipsToBounds=YES;
        cell.bottomLineView.frame=CGRectMake(36, 56, 2, 35);
     
        
        [cell.recodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(cell.roundView.mas_right).offset(10);
            make.centerY.mas_equalTo(cell.contentView);
        }];
        cell.recodeLabel.font=[UIFont boldSystemFontOfSize:17];
        
        
    }else{
        cell.topLineView.hidden=NO;
       
        cell.recodeLabel.text=_dataArray[indexPath.row];
        
    }
    
   
    cell.topLineView.backgroundColor=btnLineColor;
    cell.bottomLineView.backgroundColor = cell.topLineView.backgroundColor;
    
    self.bottomLine.backgroundColor=cell.bottomLineView.backgroundColor;
    
    
    self.leadingSpaceOfLines =  [cell convertPoint:cell.topLineView.frame.origin toView:self.view].x;
    
    [self scrollViewDidScroll:tableView];
    
    
    return cell;
}

#pragma mark --important code--
//根据上下拉动，动态改变 topLine 和 bottomLine 的 y 轴坐标。
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat yOffSet = scrollView.frame.size.height - scrollView.contentSize.height + scrollView.contentOffset.y ;
    
    _bottomLine.frame = CGRectMake(_leadingSpaceOfLines, self.view.frame.size.height - yOffSet, 2, self.view.frame.size.height);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        return 80;
    }
    return 60.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"VICTONRY",@"灵感来源于：美团的订单详情页面 和 path软件",@"这只是个简单的实现，当然，你可以做的更丰富，左侧加头像或者其他..."];
    }
    return _dataArray;
}

-(void)recodesBackClick{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
