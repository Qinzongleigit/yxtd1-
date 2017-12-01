//
//  JiFenViewController.m
//  yxtd
//
//  Created by qin on 2017/11/17.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "JiFenViewController.h"
#import "JiFenHeaderView.h"

@interface JiFenViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView*collectionView;

@property (nonatomic,strong) JiFenHeaderView*headerView;


@end

@implementation JiFenViewController

 static NSString*string=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    UICollectionViewFlowLayout*flowlayout=[[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing=1;
    flowlayout.minimumInteritemSpacing=0.5;
    flowlayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    UICollectionView*collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:flowlayout];
    
    self.collectionView=collectionView;
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.showsVerticalScrollIndicator=NO;
    
    //纯代码注册
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:string];
     [self.view addSubview:self.collectionView];
    
    //组头注册
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    
    
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
    
    
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:string forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor purpleColor];
    
    
    return cell;
    
    
}



#pragma mark - 头部视图内容
// 分组头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    

        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
              UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            //添加头视图的内容
            [self addHeaderView];
            //头视图添加view
            [header addSubview:self.headerView];
            
            return header;
        }
    
     return nil;
}
   

//添加头部视图
-(void)addHeaderView{
    
    JiFenHeaderView*headerView=[[JiFenHeaderView alloc] initWithFrame:CGRectMake(0, -20, KscreenW, SYRealValueHeight(205))];
    headerView.backgroundColor=[UIColor clearColor];
    self.headerView=headerView;
    headerView.gotoBack = ^{
     
        [self dismissViewControllerAnimated:YES completion:nil];
    };

    headerView.jifenRight = ^{
      
        
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"信息提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        [alter show];

        
    };

}


#pragma mark - 头部视图大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
        CGSize size = CGSizeMake(KscreenW, SYRealValueHeight(205));
    
        return size;
    
}



@end
