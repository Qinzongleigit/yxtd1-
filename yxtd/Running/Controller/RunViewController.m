//
//  RunViewController.m
//  yxtd
//
//  Created by qin on 2017/9/13.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "RunViewController.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

// 自定义大头针 气泡
#import "CurrentLocationAnnotation.h"
#import "CustomAnnotationView.h"

@interface RunViewController ()<MAMapViewDelegate,AMapSearchDelegate>

// 地图
@property (nonatomic, strong) MAMapView            *mapView;

// 搜索引擎
@property (nonatomic, strong) AMapSearchAPI        *search;

// 自定义大头针
@property (nonatomic, strong) UIImageView          *centerAnnotationView;
// 防止重复点击
@property (nonatomic, assign) BOOL                  isMapViewRegionChangedFromTableView;
// 是否正在定位
@property (nonatomic, assign) BOOL                  isLocated;

// 定位
@property (nonatomic, strong) UIButton             *locationBtn;

// 用户自定义大头针
@property (nonatomic, strong) UIImage              *imageLocated;
@property (nonatomic, strong) UIImage              *imageNotLocate;

// 选项卡
@property (nonatomic, strong) UISegmentedControl    *searchTypeSegment;

// 当前选中类型
@property (nonatomic, copy) NSString               *currentType;

// 当前类型下标
@property (nonatomic, copy) NSArray                *searchTypes;

// 坐标数据源
@property (nonatomic, strong) NSMutableArray *searchPoiArray;


@property (nonatomic,weak) UIView*bgView;
@property (nonatomic,weak) UIView*popView;
@property (nonatomic,weak) UIView*oneView;




@end

@implementation RunViewController


// 懒加载(装载周边搜索数据坐标)
-(NSMutableArray *)searchPoiArray
{
    if (!_searchPoiArray) {
        _searchPoiArray = [[NSMutableArray alloc]init];
    }
    return _searchPoiArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //导航栏初始化及添加按钮
     [self setUpNavi];
    
     [self initSearch];
    
     [self initMapView];
    
    
   
}

#pragma mark -周边搜索
-(void)initSearch{
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

#pragma mark - 初始化地图
// 主视图
-(void)initMapView{
    
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.view.bounds.size.height)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    self.isLocated = NO;
}

//不显示状态栏
//-(BOOL)prefersStatusBarHidden{
//    
//    return YES;
//}


#pragma mark - MapViewDelegate
/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    // 防止重复点击
    if (!self.isMapViewRegionChangedFromTableView && self.mapView.userTrackingMode == MAUserTrackingModeNone)
    {
        [self actionSearchAroundAt:self.mapView.centerCoordinate];
    }
    self.isMapViewRegionChangedFromTableView = NO;
}




#pragma mark - userLocation
/**
 * @brief 当userTrackingMode改变时，调用此接口
 * @param mapView 地图View
 * @param mode 改变后的mode
 * @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(!updatingLocation)
        return ;
    
    if (userLocation.location.horizontalAccuracy < 0)
    {
        return ;
    }
    
    if (!self.isLocated)
    {
        self.isLocated = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
        
        [self actionSearchAroundAt:userLocation.location.coordinate];
    }
}



/**
 * @brief 当userTrackingMode改变时，调用此接口
 * @param mapView 地图View
 * @param mode 改变后的mode
 * @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView  didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    //定位按钮随着大头针的位置改变选择样式
    if (mode == MAUserTrackingModeNone)
    {
        [self.locationBtn setImage:self.imageNotLocate forState:UIControlStateNormal];
    }
    else
    {
        [self.locationBtn setImage:self.imageLocated forState:UIControlStateNormal];
    }
}

/**
 * @brief 定位失败后，会调用此函数
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"----报错的原因：error = %@",error);
}


/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    // 自定义坐标
    if ([annotation isKindOfClass:[CurrentLocationAnnotation class]])
    {
        static NSString *reuseIndetifier = @"CustomAnnotationView";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"HomePage_nearbyRedPacket"];
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
        
    }
    return nil;
}

/**
 * @brief POI查询回调函数
 * @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{

    [self.mapView removeAnnotations:self.searchPoiArray];
    [self.searchPoiArray removeAllObjects];
    
    if (response.pois.count == 0)
    {
        return;
    }
    //解析response获取POI信息，具体解析见 Demo
    NSLog(@" >>> %@",response.pois);
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        // 这里使用了自定义的坐标是为了区分系统坐标 不然蓝点会被替代
        CurrentLocationAnnotation *annotation = [[CurrentLocationAnnotation alloc] init];
        [annotation setCoordinate:CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude)];
        [annotation setTitle:[NSString stringWithFormat:@"%@ - %ld米", obj.name, (long)obj.distance]];
        [annotation setSubtitle:obj.address];
        
        [self.searchPoiArray addObject:annotation];
    }];
    
    [self showPOIAnnotations];
}


// 设置地图使其可以显示数组中所有的annotation
- (void)showPOIAnnotations
{
    // 向地图窗口添加一组标注
    [self.mapView addAnnotations:self.searchPoiArray];
    
    if (self.searchPoiArray.count == 1)
    {
        //  如果数组中只有一个则直接设置地图中心为annotation的位置。
        self.mapView.centerCoordinate = [(MAPointAnnotation *)self.searchPoiArray[0] coordinate];
        [self.mapView setZoomLevel:16 animated:NO];
    }
}




#pragma mark - Handle Action
- (void)actionSearchAroundAt:(CLLocationCoordinate2D)coordinate
{
    [self searchReGeocodeWithCoordinate:coordinate];
    
    [self searchPoiWithCenterCoordinate:coordinate];
    
    [self centerAnnotationAnimimate];
}



/**
 * @brief 逆地址编码查询接口
 */
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}

#pragma mark - 中心点坐标来搜周边的POI

/**
 * @brief 根据中心点坐标来搜周边的POI.
 */
- (void)searchPoiWithCenterCoordinate:(CLLocationCoordinate2D )coord
{
    AMapPOIAroundSearchRequest*request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location = [AMapGeoPoint locationWithLatitude:coord.latitude  longitude:coord.longitude];
    
    request.radius   = 500;             /// 搜索范围
    request.types = self.currentType;   ///搜索类型
    request.sortrule = 0;               ///排序规则
    
    [self.search AMapPOIAroundSearch:request];
}


/* 移动窗口弹一下的动画 */
- (void)centerAnnotationAnimimate
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint center = self.centerAnnotationView.center;
                         center.y -= 20;
                         [self.centerAnnotationView setCenter:center];
                     }
                     completion:nil];
    
    [UIView animateWithDuration:0.45
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGPoint center = self.centerAnnotationView.center;
                         center.y += 20;
                         [self.centerAnnotationView setCenter:center];}
                     completion:nil];
}


#pragma mark --导航栏初始化及添加按钮
-(void)setUpNavi{
    
    //导航栏标题设置
    self.title=@"跑卷";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#313a3f"]}];
    
    //设置导航栏左右两边按钮
    
    UIBarButtonItem*leftBarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoriginName:@"run_NavRight"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButton)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
     UIBarButtonItem*rightBarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageWithoriginName:@"run_NavLeft"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButton)];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    
}

#pragma mark -搜索周边类型
-(void)initSearchTypeView{
    
    self.searchTypes = @[@"办公大夏", @"学校", @"楼宇", @"商场"];
    self.currentType = self.searchTypes.firstObject;
    self.searchTypeSegment = [[UISegmentedControl alloc] initWithItems:self.searchTypes];
    self.searchTypeSegment.frame = CGRectMake(6, CGRectGetHeight(self.view.bounds) - 82, CGRectGetWidth(self.mapView.bounds) - 80, 32);
    self.searchTypeSegment.layer.cornerRadius = 3;
    self.searchTypeSegment.backgroundColor = [UIColor whiteColor];
    self.searchTypeSegment.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.searchTypeSegment.selectedSegmentIndex = 0;
    [self.searchTypeSegment addTarget:self action:@selector(actionTypeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.searchTypeSegment];
    

}

#pragma mark -选项卡点击事件
-(void)actionTypeChanged:(UISegmentedControl *)sender{
    
    self.currentType = self.searchTypes[sender.selectedSegmentIndex];
    [self actionSearchAroundAt:self.mapView.centerCoordinate];
}

#pragma mark -用户自定义大头针
-(void)initCenterView{
    
    // 自己的坐标
    self.centerAnnotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage_wholeAnchor"]];
    self.centerAnnotationView.center = CGPointMake(self.mapView.center.x, self.mapView.center.y - CGRectGetHeight(self.centerAnnotationView.bounds) / 2);
    
    [self.mapView addSubview:self.centerAnnotationView];
}


#pragma mark -定位按钮
-(void)initLocationButton{
    
    self.imageLocated = [UIImage imageNamed:@"gpssearchbutton"];
    self.imageNotLocate = [UIImage imageNamed:@"gpsnormal"];
    self.locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(self.mapView.bounds) - 150, 32, 32)];
    self.locationBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    //self.locationBtn.backgroundColor = [UIColor whiteColor];
    
    //self.locationBtn.layer.cornerRadius = 3;
    [self.locationBtn addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.locationBtn setImage:self.imageNotLocate forState:UIControlStateNormal];
    
    [self.view addSubview:self.locationBtn];
    
}

//定位按钮点击事件
-(void)actionLocation{
    
    if (self.mapView.userTrackingMode == MAUserTrackingModeFollow)
    {
        [self.mapView setUserTrackingMode:MAUserTrackingModeNone animated:YES];
    }
    else
    {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            // 因为下面这句的动画有bug，所以要延迟0.5s执行，动画由上一句产生
            [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        });
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
     [self initCenterView];
    
     [self initLocationButton];
    
    [self initSearchTypeView];
    
    
    self.mapView.zoomLevel = 17;              ///缩放级别（默认3-19，有室内地图时为3-20）
    self.mapView.showsUserLocation = YES;    ///是否显示用户位置
    self.mapView.showsCompass =NO;           /// 是否显示指南针
    self.mapView.showsScale = YES;          ///是否显示比例尺
    self.mapView.minZoomLevel =14;          /// 限制最小缩放级别
    self.mapView.showTraffic = NO;         /// 是否显示交通
    self.mapView.showsBuildings = NO;      /// 是否显示建筑物
    
    self.mapView.scaleOrigin=CGPointMake(20, 0); ///比例尺的位置
    
    //用户定位样式
    MAUserLocationRepresentation*location=[[MAUserLocationRepresentation alloc] init];
    location.image=[UIImage imageNamed:@"locationImage"];
    
    [self.mapView updateUserLocationRepresentation:location];
   
    /** MAMapTypeStandard = 0,  ///< 普通地图
    MAMapTypeSatellite,     ///< 卫星地图
    MAMapTypeStandardNight, ///< 夜间视图
    MAMapTypeNavi,          ///< 导航视图
    MAMapTypeBus
     
     */
    self.mapView.mapType=MAMapTypeBus;
    
}


//导航栏左边按钮点击事件
-(void)leftButton{
    
 
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden=YES;
    
  
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.bgView=bgView;
    [self.view addSubview:bgView];
    // blur效果
    UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEfView.frame = self.bgView.frame;
    visualEfView.alpha = 0.9;
    [bgView addSubview:visualEfView];
    
    //设置弹出视图
    UIView * oneView = [[UIView alloc]initWithFrame:self.view.bounds];
    oneView.backgroundColor = [UIColor clearColor];
    self.oneView=oneView;
    [self.view addSubview:oneView];
    [self.view bringSubviewToFront:oneView];

    [self addButtonWithFram:CGRectMake(20, 40, 35, 35) bgImage:[UIImage imageNamed:@"navigation_close"] Tag:1000];

    [self addButtonWithFram:CGRectMake((KscreenW-200)/3, KscreenH/2-50, 100, 100) bgImage:[UIImage imageNamed:@"content_jianzou_dianji"] Tag:1001];
    
    [self addButtonWithFram:CGRectMake((KscreenW-200)/3*2+100, KscreenH/2-50, 100, 100) bgImage:[UIImage imageNamed:@"content_paobu_dianji"] Tag:1002];
    

    
}

#pragma mark -毛玻璃界面按钮点击事件
-(void)closeButton:(UIButton*)bt{
    
    if (bt.tag==1000) {
        [self.bgView removeFromSuperview];
        [self.oneView removeFromSuperview];
        
        self.bgView=nil;
        self.oneView=nil;
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tabBarController.tabBar.hidden=NO;
        
    }else{
        
        
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"图标点击了" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        [alter show];

    }
  
    
    
}


-(void)rightButton{
    
    NSLog(@"右边按钮点击");
}



//快速创建多个按钮
-(void)addButtonWithFram:(CGRect)frame bgImage:(UIImage*)bgImage Tag:(NSInteger)tag{
    
    UIButton*myButton=[UIButton buttonWithType:UIButtonTypeCustom];
     myButton.frame=frame;
     myButton.tag=tag;
    [myButton setBackgroundImage:bgImage forState:UIControlStateNormal];
    [myButton addTarget:self action:@selector(closeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.oneView addSubview:myButton];
    
}




@end
