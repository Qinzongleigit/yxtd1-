//
//  JiangZhangTableViewController.m
//  yxtd
//
//  Created by qin on 2017/12/6.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "JiangZhangTableViewController.h"
#import "JiangZhangCellView.h"
#import "JiangZhangTableViewCell.h"

@interface JiangZhangTableViewController ()

@property (nonatomic,strong) NSMutableDictionary * dataDictionary;
@property (nonatomic,strong) NSArray * allkeys;

@end

@implementation JiangZhangTableViewController

static  NSString*cellId=@"id";

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"我的奖章";
    
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
    //左边按钮
    UIBarButtonItem*leftBt=[[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoriginName:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];
    self.navigationItem.leftBarButtonItem=leftBt;
    
    
    
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
    
     [self.tableView registerClass:[JiangZhangTableViewCell class] forCellReuseIdentifier:cellId];
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

  return self.allkeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    JiangZhangTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JiangZhangTableViewCell"];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JiangZhangTableViewCell" owner:nil options:nil] objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.indexPath = indexPath;
    NSString * keyStr = self.allkeys[indexPath.section];
    NSArray * array = [self.dataDictionary objectForKey:keyStr];
    cell.dataArray = array;

    cell.cellView.ReturnClickItemIndex = ^(NSIndexPath * itemtIP ,NSInteger itemIndex){
        NSLog(@"----###----###---(%ld,%ld)----##---%ld----###-----",itemtIP.section,itemtIP.row,itemIndex);
    };

    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    UIView*myView=[[UIView alloc] init];
    myView.backgroundColor=[UIColor redColor];
    return myView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat cellHt = 0.0;
    NSString * keyStr = self.allkeys[indexPath.section];
    NSArray * array = [self.dataDictionary objectForKey:keyStr];
    if (array.count != 0) {
        JiangZhangCellView * cellView = [[JiangZhangCellView alloc] init];
        cellView.dataArrayCount = array.count;
        cellHt += cellView.cellHeight;
    }

    return cellHt+35;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



//导航栏返回按钮
-(void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
