//
//  JiFenViewController.m
//  yxtd
//
//  Created by qin on 2017/11/17.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "JiFenViewController.h"
#import "JiFenHeaderView.h"
#import "CanDuihuanCell.h"
#import "OverDuihuanCell.h"
#import "SaishiGoodsCell.h"
#import "JiFenShuoMingViewController.h"
#import "MineUserMessageParam.h"
#import "JiFenStoreHttp.h"
#import "JiFenStoreOverHttp.h"
#import "JiFenCanDuiHuanModel.h"
#import "JiFenSaiShiModel.h"

@interface JiFenViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView*collectionView;

@property (nonatomic,strong) JiFenHeaderView*headerView;

@property (nonatomic,assign) NSInteger selectTag;

//可兑换数组
@property (nonatomic,strong) NSMutableArray*dataArray;

//已兑换数组
@property (nonatomic,strong) NSMutableArray*dataSource;

@property (nonatomic,strong) NSMutableArray*saishiArray;




@end

@implementation JiFenViewController

 static NSString*cellString=@"cell";


//可兑换懒加载
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}
//已兑换了懒加载
-(NSMutableArray*)dataSource{
    
    if (_dataSource==nil) {
        
        _dataSource=[NSMutableArray array];
        
    }
    
    return _dataSource;
}

//赛事懒加载
-(NSMutableArray*)saishiArray{
    
    if (!_saishiArray) {
        
        _saishiArray=[NSMutableArray array];
    }
    
    return _saishiArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    //获取可兑换数据
    [self getCanDuiHuanHttpData];
    
    //添加头视图的内容
    [self addHeaderView];
    UICollectionViewFlowLayout*flowlayout=[[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing=1;
    flowlayout.minimumInteritemSpacing=0.5;
    flowlayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    UICollectionView*collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, SYRealValueHeight(205), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-SYRealValueHeight(205)) collectionViewLayout:flowlayout];
    
    self.collectionView=collectionView;
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.showsVerticalScrollIndicator=NO;
    
    //纯代码注册
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellString];
     [self.view addSubview:self.collectionView];
    
    // 注册cell
    [self.collectionView registerClass:[CanDuihuanCell class] forCellWithReuseIdentifier:@"CanDuihuanCell"];
    [self.collectionView registerClass:[OverDuihuanCell class] forCellWithReuseIdentifier:@"OverDuihuanCell"];
    [self.collectionView registerClass:[SaishiGoodsCell class] forCellWithReuseIdentifier:@"SaishiGoodsCell"];
    
   
}

#pragma mark--代理方法的实现
//item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

        return CGSizeMake((CGRectGetWidth(self.view.frame)-1)/2, 200) ;
  
    
}

//item的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
    
    if (self.selectTag==101) {
        
        return self.dataSource.count;
        
    }else if (self.selectTag==102){
        
        return self.saishiArray.count;
        
    }else{
        
        return self.dataArray.count;
    }
    

}



//填充cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellString forIndexPath:indexPath];
    
    
    if (self.selectTag==101){
        
        OverDuihuanCell*overCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"OverDuihuanCell" forIndexPath:indexPath];
        [overCell fillCellWithModel:_dataSource[indexPath.row] indexPath:indexPath];
        return overCell;
        
    }else if(self.selectTag==102){
    
    
        SaishiGoodsCell*saishiCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SaishiGoodsCell" forIndexPath:indexPath];
        
        [saishiCell fillCellWithModel:_saishiArray[indexPath.row] indexPath:indexPath];
        
        return saishiCell;
        
    }else{
        
       CanDuihuanCell*duihuanCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CanDuihuanCell" forIndexPath:indexPath];
        
        [duihuanCell fillCellWithModel:_dataArray[indexPath.row] indexPath:indexPath];
        
        return duihuanCell;
    }
   
    
    return cell;
    
    
}

//添加头部视图
-(void)addHeaderView{
    
    JiFenHeaderView*headerView=[[JiFenHeaderView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, SYRealValueHeight(205))];
    headerView.backgroundColor=[UIColor redColor];
    self.headerView=headerView;
    
    [self.view addSubview:headerView];
    
   
    headerView.gotoBack = ^{
     
        [self dismissViewControllerAnimated:YES completion:nil];
    };

    headerView.jifenRight = ^{
    
        JiFenShuoMingViewController*shuomingVC=[[JiFenShuoMingViewController alloc] init];
       [self presentViewController:shuomingVC animated:YES completion:nil];
       
        
    };
    
    headerView.headerBtClick = ^(NSInteger tag) {
      
        self.selectTag=tag;
        
       [self.collectionView reloadData];
        //已兑换点击
        if (self.selectTag==101) {
            
            [self getOverDuiHuanHttpData];
           //赛事奖品点击
        }else if (self.selectTag==102){
            
            [self getSaiShiGoodsHttpData];
           //可兑换点击
        }else{
            [self getCanDuiHuanHttpData];
        }


    };

}

#pragma mark - 获取积分商场赛事奖品接口数据
-(void)getSaiShiGoodsHttpData{
    
    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    
    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];

   [CDHttpTool GET:[NSString stringWithFormat:@"%@?api_token=%@",JiFenStoreSaiShiGoods,api_tokenStr] parameters:nil success:^(id responseObject) {
   
        
        NSLog(@"积分商城赛事数据====================：%@",responseObject);
       
       [self.saishiArray removeAllObjects];
       
       if ([responseObject[@"code"] integerValue]==200) {
           
        NSArray *array=responseObject[@"data"];

           // 字段转模型
           for(NSDictionary *tempDict in array){
               
         JiFenSaiShiModel*model = [[JiFenSaiShiModel alloc] init];
               
               [model setValuesForKeysWithDictionary:tempDict];
               
               [self.saishiArray addObject:model];
               
               [_collectionView reloadData];
               
           }
       }
        
    } failure:^(NSError *error) {
       
        NSLog(@"积分商城赛事奖品数据获取失败");
        
    }];
    
   
}

#pragma mark -获取积分商城已兑换接口数据
-(void)getOverDuiHuanHttpData{
    
    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    
    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];
    
    NSString*member_idStr=[userInformation objectForKey:@"member_id"];
    
    MineUserMessageParam*params=[[MineUserMessageParam alloc] init];
    
    params.api_token=api_tokenStr;
    
    //先用member_id为1来测试
    params.member_id=@"1";
    
    [self.dataSource removeAllObjects];
    
    [JiFenStoreOverHttp httpJiFenStoreOver:params success:^(id responseObject) {
        
        
        if ([responseObject[@"code"] integerValue]==200) {
            
            NSDictionary*dict=responseObject[@"data"];
 
            
            NSArray *array = dict[@"list"];
            // 字段转模型
            for(NSDictionary *tempDict in array){
                
                JiFenCanDuiHuanModel *model = [[JiFenCanDuiHuanModel alloc] init];
                
                [model setValuesForKeysWithDictionary:tempDict];
                
                [self.dataSource addObject:model];
                
                [_collectionView reloadData];
                
            }
        }
        
        
    } failure:^(NSError *error) {
        
        NSLog(@"积分商城获取已兑换数据失败");
        
    }];
    
    
    
}

#pragma  mark -获取积分商城可兑换接口数据
-(void)getCanDuiHuanHttpData{
    
    NSUserDefaults *userInformation = [NSUserDefaults standardUserDefaults];
    
    NSString*api_tokenStr=[userInformation objectForKey:@"api_token"];
    
    NSString*member_idStr=[userInformation objectForKey:@"member_id"];
    
    MineUserMessageParam*params=[[MineUserMessageParam alloc] init];
    
    params.api_token=api_tokenStr;
    
    params.member_id=member_idStr;
    
    [self.dataArray removeAllObjects];
    
    [JiFenStoreHttp httpJiFenStore:params success:^(id responseObject) {

        if ([responseObject[@"code"] integerValue]==200) {
            
            NSDictionary*dict=responseObject[@"data"];
            
        
      self.headerView.jifenStr=dict[@"integral"];
              
            
            NSArray *array = dict[@"list"];
            // 字段转模型
            for(NSDictionary *tempDict in array){
                
                JiFenCanDuiHuanModel *model = [[JiFenCanDuiHuanModel alloc] init];
                
                [model setValuesForKeysWithDictionary:tempDict];
                
                [self.dataArray addObject:model];
                
                [_collectionView reloadData];
                
            }
        }
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"积分商城可兑换获取数据失败");
        
    }];





}


@end
