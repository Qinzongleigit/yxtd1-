//
//  FoodViewController.m
//  yxtd
//
//  Created by 覃宗雷 on 2017/12/19.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "FoodViewController.h"
#import "FoodTableViewCell.h"
#import "FoodDetailsViewController.h"
#import "FootView.h"

@interface FoodViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView*tableView;

@property (nonatomic, strong) FootView *footView;

@property (nonatomic, strong) NSMutableArray *cellArray;

@end

@implementation FoodViewController

  NSString*cellID=@"ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UITableView*tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenH-64-40)];
    self.tableView=tableView;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=40;
 tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
     _tableView.allowsMultipleSelectionDuringEditing = YES;//设置tableView在编辑模式下可多选
    
    
#warning 没有数据先先不创建自己布局的cell
#if 0
   [tableView registerClass:[FoodTableViewCell class] forCellReuseIdentifier:cellID
    ];
#endif
    
    
    [self.view addSubview:tableView];
    
    
 
    //弹出全选和删除view
      _footView=[[FootView alloc] initWithFrame:CGRectMake(0, KscreenH, KscreenW, 49)];
    _footView.backgroundColor=[UIColor grayColor];
    
    __block FoodViewController*blockSelf=self;
    
    _footView.allBtnBolock = ^(UIButton *myBt) {
        
        //全选按钮
       [blockSelf footAllSelectedBtnClick:myBt];
        
    };
    
    _footView.deleteBtnBolock = ^{
        
        //删除按钮
      [blockSelf footDeleteBtnClick];
    };
    
    [self.view addSubview:_footView];
    
    
    // 数据
    _cellArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", nil];
    
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingTongZhi) name:@"postNotiEditing" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenFootView) name:@"postHiddenFootView" object:nil];
   
    
   
}

#pragma mark 隐藏全选删除按钮

-(void)hiddenFootView{
    
    [self.tableView setEditing:NO animated:YES];
    
    _footView.frame=CGRectMake(0, KscreenH, KscreenW, 49);
    
    [_tableView setFrame:CGRectMake(0, 0, KscreenW, KscreenH-104)];
    
    
}

#pragma mark -编辑按钮点击发送通知
-(void)editingTongZhi{
    
    
    //让tableView进入编辑模式
    [_tableView setEditing:!_tableView.isEditing animated:YES];
    
    if (_tableView.isEditing) {
        
        [_footView.allBtn setTitle:@"全部选择" forState:UIControlStateNormal];
        [_footView.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        
        _footView.allBtn.selected = NO;
        
        [_tableView setFrame:CGRectMake(0, 0, KscreenW, KscreenH - 49-64-40)];
        
        _footView.frame=CGRectMake(0, KscreenH-49-64-40, KscreenW, 49);
    }else {
        
        [_tableView setFrame:CGRectMake(0, 0, KscreenW, KscreenH-104)];
        
        _footView.frame=CGRectMake(0, KscreenH, KscreenW, 49);
    }
    
    //根据偏移量计算是否滑动到tableView最后一行 count为无符号整型 强转一下
    if (_tableView.contentOffset.y > 50.0000000*(NSInteger)(_cellArray.count - 12 - 2)) {
        //cell高度*(模型数组个数 - 页面展示总cell数 + 2) = 滑动到tableView倒数第二行的偏移量
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_cellArray indexOfObject:[_cellArray lastObject]] inSection:0];
        
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.cellArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.tintColor = [UIColor yellowColor];// 改变编辑状态左侧勾选颜色
    cell.textLabel.text=_cellArray[indexPath.row];
    
    return cell;
    
}



#pragma mark--删除按钮点击事件
- (void)footDeleteBtnClick{
    
    NSMutableArray *deleteArr = [[NSMutableArray alloc] init];
    // 确定选择哪条数据
    for (NSIndexPath *indexPath in _tableView.indexPathsForSelectedRows) {
        
        [deleteArr addObject:_cellArray[indexPath.row]];
    }
    // 从总数据删除被选中的数据
    [_cellArray removeObjectsInArray:deleteArr];
    
    [_tableView reloadData];
    
    
    _footView.frame=CGRectMake(0, KscreenH, KscreenW, 0) ;
    
    [_tableView setFrame:CGRectMake(0, 0, KscreenW, KscreenH-104)];
    
    //取消表格编辑状态
    [self.tableView setEditing:NO animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeEditingBtnTitleText" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTableViewEditingState" object:nil];
    
    
    
}

#pragma mark--全选按钮点击事件
- (void)footAllSelectedBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    for (int i = 0; i < _cellArray.count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        if (btn.selected) {
            
            [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
            [btn setTitle:@"取消全选" forState:UIControlStateNormal];
        }else {
            
            [_tableView deselectRowAtIndexPath:indexPath animated:NO];
            [btn setTitle:@"全部选择" forState:UIControlStateNormal];
        }
    }
}


#warning 隐藏自定义cell布局
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return 20;
//}
//
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    FoodTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellID];
//
//    cell.selectionStyle=UITableViewCellEditingStyleNone;
//    return cell;
//}
//
//
#pragma mark - 选中某行跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (![tableView isEditing]) {
        
        FoodDetailsViewController*detailVC=[[FoodDetailsViewController alloc] init];
        [self presentViewController:detailVC animated:YES completion:nil];
        
        //反选
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }


}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
