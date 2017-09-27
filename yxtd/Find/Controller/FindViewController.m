//
//  FindViewController.m
//  yxtd
//
//  Created by qin on 2017/9/13.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "FindViewController.h"
#import "CDFindHeaderView.h"



@interface FindViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DataBackProcotol>

@property (nonatomic,strong) UICollectionView*collectionView;

@property (nonatomic,strong) CDFindHeaderView*headerView;

@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,assign) int num;
@property (nonatomic,strong) NSArray*imageArray;



@end

@implementation FindViewController

 static NSString*string=@"cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UICollectionViewFlowLayout*flowlayout=[[UICollectionViewFlowLayout alloc] init];
    flowlayout.minimumLineSpacing=1;
    flowlayout.minimumInteritemSpacing=0.5;
    flowlayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    UICollectionView*collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:flowlayout];
    
    self.collectionView=collectionView;
    
    self.collectionView.backgroundColor=[UIColor grayColor];
    
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.showsVerticalScrollIndicator=NO;
    
    //纯代码注册
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:string];
    
    //组头注册
 
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    
    [self.view addSubview:self.collectionView];

    
    
}


#pragma mark--代理方法的实现
//item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((CGRectGetWidth(self.view.frame)-1)/2, CGRectGetHeight((self.view.frame))/2) ;
    
}

//item的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio{
    
    
    return 20;
    
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
        
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
            
            //添加头视图的内容
            [self addHeaderView];
            self.headerView.delegete=self;
            //头视图添加view
            [header addSubview:self.headerView];
            
            
            //头部视图点击
            UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
            
            tap.numberOfTapsRequired = 1;
            
            [self.headerView addGestureRecognizer:tap];
            
            return header;
      }
    }
    
    return nil;
  }


//回调方法
-(void)DataBack:(int )index{
    
     _num=index-1;
   
    
    
}

-(void)tapClick{
    
    
    if(self.num==_imageArray.count||self.num==0) {
        
        
    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
    [alter show];
    }

    
}


#pragma mark --collectionView头部视图
-(void)addHeaderView{
    
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    self.imageArray=imagesURLStrings;
    

    CDFindHeaderView*headerView=[[CDFindHeaderView alloc] initWithFrame:CGRectMake(0, 0, KscreenW, KscreenW/2) NSArray:imagesURLStrings];
    self.headerView=headerView;
 
    
}
#pragma mark - 头部视图大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size = CGSizeMake(KscreenW, KscreenW/2);
    return size;
}








#pragma mark - 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
   
    //修改状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //修改电池条
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

#pragma mark - 视图即将消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}



@end
