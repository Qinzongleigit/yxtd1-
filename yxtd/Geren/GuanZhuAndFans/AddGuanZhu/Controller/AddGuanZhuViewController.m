//
//  AddGuanZhuViewController.m
//  yxtd
//
//  Created by qin on 2018/2/3.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "AddGuanZhuViewController.h"
#import "SearchUserHttp.h"
#import "SearchUserTableViewCell.h"
#import "DataModel.h"

@interface AddGuanZhuViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong) UITableView*tableView;

@property (nonatomic,strong) UISearchBar*searchBar;

@property(nonatomic,strong)  NSMutableArray *resultArray;

@property (nonatomic,strong)  NSString*searchBarText;


@end

@implementation AddGuanZhuViewController

-(NSMutableArray *)resultArray{

    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.title=@"添加关注";
    
    self.rightBt.hidden=YES;
    

    [self.view addSubview:self.searchBar];
    
    [self.view addSubview:self.tableView];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.height.mas_equalTo(44);
       make.top.mas_equalTo(15);

    }];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(64);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);

    }];

    
}


#pragma mark -搜索关注接口
-(void)getSearchUserGetData{
    
    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    
    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];
    
    NSString*member_idStr=[userInformation objectForKey:@"member_id"];
    
    MineUserMessageParam*params=[[MineUserMessageParam alloc] init];
    
    params.api_token=api_tokenStr;
    
    params.member_id=member_idStr;
    
    params.nickname=self.searchBarText;
    
    [self.resultArray removeAllObjects];
    
    [SearchUserHttp  httpSearchUser:params success:^(id responseObject) {
        
        NSLog(@"搜索返回结果=========：%@",responseObject);

        if ([responseObject[@"code"] integerValue]==200) {
            
            NSArray *array=responseObject[@"data"];
            
            // 字段转模型
            for(NSDictionary *tempDict in array){
                
                DataModel *model = [[DataModel alloc] init];
                
                [model setValuesForKeysWithDictionary:tempDict];
                
                [self.resultArray addObject:model];
                
                
                [_tableView reloadData];
                
            }
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"搜索用户失败");
       
        
    }];
    
    
    
}

#pragma mark -搜索框
-(UISearchBar*)searchBar{
    if (!_searchBar) {

        _searchBar = [[UISearchBar alloc]init];
        _searchBar.keyboardType = UIKeyboardAppearanceDefault;
        _searchBar.placeholder = @"请输入搜索关键字";
        _searchBar.delegate = self;
        //光标的颜色
        _searchBar.tintColor=[UIColor yellowColor];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }

    return _searchBar;

}

//表格
-(UITableView*)tableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc] init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight = 60;
        _tableView.layer.cornerRadius = 5;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[SearchUserTableViewCell class] forCellReuseIdentifier:@"ID"];
    }
    return _tableView;
    
}

#pragma mark -表格视图代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     return self.resultArray.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString*cellStrID=@"ID";
    
   
    SearchUserTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellStrID forIndexPath:indexPath];
   
        [cell fillCellWithModel:_resultArray[indexPath.row] indexPath:indexPath];
    //消除重影
//    for (UIView *view in cell.contentView.subviews) {
//        [view removeFromSuperview];
//    }
//
   
    return cell;
}

//点击选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark-搜索框代理方法
//在搜索框中修改搜索内容时，自动触发下面的方法
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    NSLog(@"开始输入搜索内容");
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
    
    //改变取消的文本
    for(UIView *view in [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    NSLog(@"输入搜索内容完毕");
}


//搜框中输入关键字的事件响应
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.searchBarText=searchText;
    
  
}


//取消的响应事件
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"取消搜索");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

//键盘上搜索事件的响应
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"搜索");
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self getSearchUserGetData];
}

#pragma mark--获取汉字转成拼音字符串 通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字 搜索
- (NSString *)transformToPinyin:(NSString *)aString{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
            
        }
        [allString appendString:@","];
        count ++;
        
    }
    
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}





@end
