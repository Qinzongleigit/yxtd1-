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

@interface JiFenViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView*collectionView;

@property (nonatomic,strong) JiFenHeaderView*headerView;

@property (nonatomic,assign)NSInteger selectTag;


@end

@implementation JiFenViewController

 static NSString*cellString=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
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
  
        return 10;
   
}



//填充cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellString forIndexPath:indexPath];
    
    
    if (self.selectTag==101){
        
        OverDuihuanCell*overCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"OverDuihuanCell" forIndexPath:indexPath];
        return overCell;
        
    }else if(self.selectTag==102){
    
    
        SaishiGoodsCell*saishiCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SaishiGoodsCell" forIndexPath:indexPath];
        return saishiCell;
        
    }else{
        
        CanDuihuanCell*duihuanCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CanDuihuanCell" forIndexPath:indexPath];
        
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
      
        
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"信息提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        [alter show];

        
    };
    
    headerView.headerBtClick = ^(NSInteger tag) {
      
        self.selectTag=tag;
        
       [self.collectionView reloadData];


    };

}




@end
