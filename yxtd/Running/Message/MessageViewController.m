//
//  MessageViewController.m
//  yxtd
//
//  Created by qin on 2017/12/27.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "MessageViewController.h"

#import "MessageTableViewCell.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView*tableView;

@property (nonatomic,strong) NSMutableArray*dataArr;

@end

@implementation MessageViewController

   NSString*messageID=@"ID";


-(NSMutableArray*)dataArr{
    
    if (!_dataArr) {
        
        //_dataArr=@[@"注意查看活动安徽省看到机会案例发生发的",@"爱好发挥大撒客服电话卡号",@"安徽罚款酸辣粉好饿uwuifwiefh",@"就撒飞机哦IER级发文件覅就",@"阿阿斯蒂芬发生纠纷顽皮区瑞强",@"额咳咳咳咳咳咳看",@"股份RIP儿童票威迫额葡萄味"];
        _dataArr=[NSMutableArray arrayWithObjects:@"注意查看活动安徽省看到机会案例发生发的",@"爱好发挥大撒客服电话卡号",@"安徽罚款酸辣粉好饿uwuifwiefh",@"就撒飞机哦IER级发文件覅就",@"阿阿斯蒂芬发生纠纷顽皮区瑞强",@"额咳咳咳咳咳咳看",@"股份RIP儿童票威迫额葡萄味", nil];
    }
    
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.rightBt setBackgroundImage:nil  forState:UIControlStateNormal];
    
    self.title=@"消息";
    
   
    [self addTableView];
   
    
}



#pragma mark 创建表格
-(void)addTableView{
    
        
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    
    tableView.rowHeight=70;
    
    [tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:messageID];
    
    [self.view addSubview:self.tableView];
    
    
    
    //隐藏多余线条
    [self setExtraCellLineHidden:_tableView];
   
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MessageTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:messageID];

    cell.messageLabel.text=_dataArr[indexPath.row];

    
    return cell;
    
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
       [self.dataArr removeObjectAtIndex:indexPath.row];
    
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
        
       // [self.tableView reloadData];
        
    }
}




-(void)leftBtnClick{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark    隐藏多余线条
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    
}


@end
