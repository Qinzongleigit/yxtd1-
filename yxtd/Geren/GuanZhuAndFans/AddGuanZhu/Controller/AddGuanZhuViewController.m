//
//  AddGuanZhuViewController.m
//  yxtd
//
//  Created by qin on 2018/2/3.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "AddGuanZhuViewController.h"

@interface AddGuanZhuViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong) UITableView*tableView;

@property (nonatomic,strong) UISearchBar*searchBar;

@property (nonatomic, strong) UIView *searchBgView;

@property (nonatomic, strong) UIButton *cancleBtn;

@end

@implementation AddGuanZhuViewController

-(UITableView*)tableView{
    
    if (!_tableView) {
       _tableView=[[UITableView alloc] init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
    }
  
    return _tableView;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.title=@"添加关注";
    
    
    self.rightBt.hidden=YES;
    
    [self.view addSubview:self.searchBgView];
    
    [self.view addSubview:self.tableView];
    

    [self.searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
     
        make.top.mas_equalTo(0);
        make.left.and.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.mas_equalTo(self.searchBgView.mas_bottom);
        make.left.and.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
     
        make.left.mas_equalTo(8);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(-8);
        //make.right.mas_equalTo(_cancleBtn.mas_left).with.offset(-10);
    }];
//
//    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerY.mas_equalTo(self.searchBar.mas_centerY);
//        make.right.mas_equalTo(-15);
//        make.height.mas_equalTo(30);
//        make.left.mas_equalTo(self.searchBar.mas_right).with.offset(10);
//    }];
    
}

#pragma  mark 搜索栏
- (UIView *)searchBgView
{
    if (!_searchBgView) {
        _searchBgView = [[UIView alloc] init];
        _searchBgView.backgroundColor = [UIColor whiteColor];
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.showsCancelButton = NO;
        _searchBar.tintColor = BlackHexColor;
        _searchBar.placeholder = @"搜索券友";
        _searchBar.delegate = self;
        for (UIView *subView in _searchBar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                    
                    //设置默认文字颜色
                    UIColor *color = [UIColor grayColor];
                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索券友"
                                                                                        attributes:@{NSForegroundColorAttributeName:color}]];
                    //修改默认的放大镜图片
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
                    imageView.backgroundColor = [UIColor clearColor];
                    imageView.image = [UIImage imageNamed:@"search_ misplaces_Image"];
                    textField.leftView = imageView;
                }
            }
        }
        
        UIImage *image = [UIImage imageNamed:@"search_cancle_button_Image"];
        [_searchBar setImage:image forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];

       [_searchBgView addSubview:_searchBar];
        
        _cancleBtn = [[UIButton alloc] init];
        _cancleBtn.backgroundColor = [UIColor clearColor];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [_searchBgView addSubview:_cancleBtn];
        
        [_cancleBtn addTarget:self action:@selector(cancleBtnTouched) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _searchBgView;
    
    
}

#pragma mark ---searchBar delegate
//限制20个字符
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] > 20) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"字数不能超过20" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:nil completion:nil];
        [_searchBar setText:[searchText substringToIndex:20]];
    }
    
   // [self.viewModel filterObjectsWithKeyWords:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"========search");
    [self.searchBar resignFirstResponder];
    
   
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"9999999999999999");
    
    [self.searchBar becomeFirstResponder];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString*cellStrID=@"ID";
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellStrID];
    if (!cell) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStrID];
    }
    
    cell.textLabel.text=@"添加关注";
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
