//
//  RunViewController.m
//  yxtd
//
//  Created by qin on 2017/9/13.
//  Copyright © 2017年 qin. All rights reserved.
//


#define showViewHeight 110
#import "RunViewController.h"
#import "JSQuanShowView.h"
#import "SelectableOverlay.h"
#import "RunLocationGaoDeManager.h"
#import "JSCenterAnnotation.h"
#import "DetailedViewController.h"

#import "ShowAnimationView.h"
#import "MyTabarController.h"



@interface RunViewController ()<MAMapViewDelegate,AMapNaviWalkManagerDelegate>
{
    
    NSMutableArray *all_arrayList;
    RunLocationGaoDeManager *currentPosition;
    
    BOOL isShowView;//上部自行车信息框弹出
    BOOL isMoveView;//是否移动地图
    CLLocationCoordinate2D currentCoordinate;
    
    JSCenterAnnotation *centerAnnotaion;
    MAAnnotationView *centerAnnoView;
    
    AMapNaviWalkManager *js_walkManager;
    
    UIView*myView;
    
}


@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) JSQuanShowView *showView;

@property (nonatomic,strong) ShowAnimationView*animationView1;

@property (nonatomic,strong) UIButton *btn_local;
@property (nonatomic,assign) CLLocationCoordinate2D startCoordinate;
@property (nonatomic,assign) CLLocationCoordinate2D endCoordinate;

@property (nonatomic, strong) AMapNaviPoint *startPoint;

@property (nonatomic, strong) AMapNaviPoint *endPoint;


@property (nonatomic,weak) UIView*bgView;

@property (nonatomic,weak) UIView*popView;

@property (nonatomic,weak) UIView*oneView;

@property (nonatomic,copy) NSString*address;

@property (nonatomic,copy) NSString *label_distance;



@end

@implementation RunViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
   js_walkManager.delegate = self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    [self setUpData];

    [self setUpMapView];

    //导航栏初始化及添加按钮
    [self setUpNavi];
 
    
}
- (void)setUpData{
    
    all_arrayList = [[NSMutableArray alloc]init];
    
    CLLocationCoordinate2D coor;
    coor.longitude = [self.show_longitude doubleValue];
    coor.latitude = [self.show_latitude doubleValue];
    currentCoordinate = coor;
    
    isMoveView = YES;
    
    
    
   NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nearBicycle" ofType:@"json"]];

    NSDictionary*dataDict=[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    NSArray *result = dataDict[@"bicyles"];
    [all_arrayList addObjectsFromArray:result];
    
 
}


#pragma mark -初始化地图
- (void)setUpMapView{
    
  
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] init];

    ///把地图添加至view
   [self.view addSubview:self.mapView];
   [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(self.view);
    }];
    
    self.mapView.delegate = self;
    
    self.mapView.zoomLevel = 15;   //缩放等级
    
    self.mapView.showsUserLocation = true; //是否显示用户位置
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;   //跟随用于位置更新
    
    self.mapView.showsCompass=NO;  //是否显示指南针
    self.mapView.showsScale = YES;          ///是否显示比例尺
    self.mapView.showTraffic = NO;        // 是否显示交通
    self.mapView.showsBuildings = NO;      // 是否显示建筑物
    
   self.mapView.scaleOrigin=CGPointMake(20, -KscreenH+64); ///比例尺的位置
   
    /** MAMapTypeStandard = 0,  ///< 普通地图
     MAMapTypeSatellite,     ///< 卫星地图
     MAMapTypeStandardNight, ///< 夜间视图
     MAMapTypeNavi,          ///< 导航视图
     MAMapTypeBus
     
     */
    
    //self.mapView.mapType=MAMapTypeBus;  //地图样式
    
    [self.mapView addAnnotation:centerAnnotaion];
    
    [self addAnnotations];
    
    MAUserLocationRepresentation *localPoint = [[MAUserLocationRepresentation alloc] init];
    localPoint.showsHeadingIndicator = YES;
    
    [self.mapView updateUserLocationRepresentation:localPoint];
    //初始化步行导航
    js_walkManager = [[AMapNaviWalkManager alloc]init];
    js_walkManager.delegate = self;
    
    self.btn_local = [[UIButton alloc]init];
    [self.btn_local setImage:[UIImage imageNamed:@"gpsnormal"] forState:0];
    [self.btn_local addTarget:self action:@selector(local) forControlEvents:1 <<  6];
    [self.view addSubview:self.btn_local];
    
    [self.btn_local mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@22);
        make.bottom.equalTo(@-200);
    }];

    
    //第一进入app显示引导图
       [self firstLogin];
    
    
    //定位精度圈
    //MAUserLocationRepresentation*r=[[MAUserLocationRepresentation alloc] init];

   // r.fillColor = [UIColor redColor];///精度圈 填充颜色, 默认
    
  
   // r.enablePulseAnnimation = YES;///内部蓝色圆点是否使用律动效果, 默认YES
   // r.locationDotFillColor = [UIColor grayColor];///定位点蓝色圆点颜色，不设置默认蓝色
 
   // [self.mapView updateUserLocationRepresentation:r];
}

#pragma mark -第一次进入显示引导图

-(void)firstLogin{

    self.animationView1=[[ShowAnimationView alloc] initWithFrame:self.view.bounds];
    [self.animationView1 showView];



//     [[UIApplication sharedApplication].keyWindow addSubview:myView];
}



//定位按钮点击事件处理
- (void)local{
    
    self.mapView.zoomLevel=15;
    
    self.mapView.showsUserLocation = true;
    
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}


#pragma mark - 添加大头针和动画
//添加大头针
- (void)addAnnotations{
    NSMutableArray *array_annotations = [[NSMutableArray alloc]init];
    
  for (NSDictionary *dict in all_arrayList) {
        MAPointAnnotation *annotation =  [[MAPointAnnotation alloc]init];
        annotation.coordinate = CLLocationCoordinate2DMake([dict[@"gLat" ] doubleValue], [dict[@"gLng"] doubleValue]);
    
        annotation.title = dict[@"name"];
        annotation.subtitle = [NSString stringWithFormat:@"%@|%@",dict[@"availTotal"],dict[@"emptyTotal"]];
        [array_annotations addObject:annotation];
    }
    [self.mapView addAnnotations:array_annotations];
}

#pragma mark - mapViewDelete
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    if (!isMoveView) {
        //不能移动
        centerAnnotaion.lockedToScreen = NO;
    }else{
        centerAnnotaion.lockedToScreen = YES;
    }
}

- (void)mapInitComplete:(MAMapView *)mapView{
  
    centerAnnotaion = [[JSCenterAnnotation alloc]init];
    
    centerAnnotaion.coordinate = currentCoordinate;//self.mapView.centerCoordinate;
    
    centerAnnotaion.lockedScreenPoint = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    centerAnnotaion.lockedToScreen = YES;
    //
    [self.mapView addAnnotation:centerAnnotaion];
    
    [self.mapView showAnnotations:@[centerAnnotaion] animated:YES];
}


//加载大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    
    if ([annotation isMemberOfClass:[MAUserLocation class]]) {
        
        return nil;
    }
    
    if ([annotation isMemberOfClass:[JSCenterAnnotation class]]) {
        static NSString *reuseCneterid = @"myCenterId";
        MAAnnotationView *annotationView= [self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseCneterid];
        if (!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:reuseCneterid];
        }
        annotationView.image = [UIImage imageNamed:@"homePage_wholeAnchor"];
        annotationView.canShowCallout = NO;
        centerAnnoView = annotationView;
        return annotationView;
    }
    
    static NSString *reuseid = @"myId";
    
    MAAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseid];
    if (!annotationView) {
        annotationView = [[MAAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:reuseid];
    }
    
    annotationView.image = [UIImage imageNamed:@"HomePage_nearbyRedPacket"];
    //    annotationView.canShowCallout = YES;
    return annotationView;
}


//单击地图
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    if (isShowView) {
        
        [self.showView setHidden:YES];
        
        [self.btn_local setHidden:NO];
    }
    
    self.mapView.zoomLevel = 15;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    
    [self addAnnotations];
    [self.mapView addAnnotation:centerAnnotaion];
    
    isMoveView = YES;
}


- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    
    
    if ([view.annotation isMemberOfClass:[MAUserLocation class]]) {
        
        return;
    }
    
    if ([view.annotation isMemberOfClass:[JSCenterAnnotation class]]) {
        
        return;
    }
  
  
    isMoveView = NO;
    
    //记录下点击的经纬度
    NSString *didAddress = view.annotation.title;
    
    if (!self.showView) {
      // self.showView = [[JSQuanShowView alloc]initWithFrame:CGRectMake(27, KscreenH+showViewHeight, KscreenW-54, showViewHeight)];
        
        self.showView=[[JSQuanShowView alloc] init];
        
        self.showView.backgroundColor = [UIColor whiteColor];
        self.showView.alpha = 0.9;
        [self.view addSubview:self.showView];
        
        [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.mas_equalTo(120);
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(KscreenW-54, showViewHeight));
        }];
        
        [self.showView.superview layoutIfNeeded];//如果其约束还没有生成的时候需要动画的话，就请先强制刷新后才写动画，否则所有没生成的约束会直接跑动画
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.showView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.mas_equalTo(-62);
                
            }];
            
            [self.view layoutIfNeeded];//强制绘制
            
        }];
        
        
//        [UIView animateWithDuration:1 animations:^{
//
//           self.showView.frame = CGRectMake(27, KscreenH-171-64, KscreenW-54, 0);
//
//
//        } completion:^(BOOL finished) {
//
//            self.showView.frame = CGRectMake(27, KscreenH-171-64, KscreenW-54, showViewHeight);
//        }];
    }
    isShowView = YES;
    [self.showView setHidden:NO];
    [self.btn_local setHidden:YES];
    
    ZXNWeakSelf(self)
    self.showView.gotoDetailVC = ^(){
        [weakself gotoVC];
    };
    
    //星星等级
    self.showView.statNum=4.5;
    
    
    //self.showView.label_address.text = view.annotation.title;
//    self.address=view.annotation.title;
    
    NSArray *counts = [view.annotation.subtitle componentsSeparatedByString:@"|"];
    self.showView.label_availTotal.text = counts[0];
    self.showView.label_emptyTotal.text = counts[1];
    
    
    //步行导航
    self.startCoordinate = centerAnnotaion.coordinate;
    self.endCoordinate = view.annotation.coordinate;
    
    self.startPoint = [AMapNaviPoint locationWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude];
    
    self.endPoint = [AMapNaviPoint locationWithLatitude:self.endCoordinate.latitude longitude:self.endCoordinate.longitude];
    [js_walkManager calculateWalkRouteWithStartPoints:@[self.startPoint] endPoints:@[self.endPoint]];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    NSMutableArray *array_annotations = [[NSMutableArray alloc]init];
    [array_annotations addObject:centerAnnotaion];
    
    for (NSDictionary *dict in all_arrayList) {
        MAPointAnnotation *annotation =  [[MAPointAnnotation alloc]init];
    
        NSLog(@"%@,%@",dict[@"name"],didAddress);
        
        if ([dict[@"name"] isEqualToString:didAddress]) {
            annotation.coordinate = CLLocationCoordinate2DMake([dict[@"gLat" ] doubleValue], [dict[@"gLng"] doubleValue]);
            annotation.title = dict[@"name"];
            annotation.subtitle = [NSString stringWithFormat:@"%@|%@",dict[@"availTotal"],dict[@"emptyTotal"]];
            [array_annotations addObject:annotation];
            
             self.address=annotation.title;
        }
        
        self.address=[NSString stringWithFormat:@"%@,%@",dict[@"name"],didAddress];
        
    }
    
    [self.mapView addAnnotations:array_annotations];
    
    [self.mapView showAnnotations:array_annotations edgePadding:UIEdgeInsetsMake(300, 100, 50, 100) animated:YES];
    
}

#pragma mark - AMapNaviWalkManagerDelegate 导航代理

- (void)walkManagerOnCalculateRouteSuccess:(AMapNaviWalkManager *)walkManager{
    
    NSLog(@"步行路线规划成功！");
    
    if (walkManager.naviRoute == nil){
        return;
    }
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    //将路径显示到地图上
    AMapNaviRoute *aRoute = walkManager.naviRoute;
    int count = (int)[[aRoute routeCoordinates] count];
    
    //添加路径Polyline
    CLLocationCoordinate2D *coords = (CLLocationCoordinate2D *)malloc(count * sizeof(CLLocationCoordinate2D));
    for (int i = 0; i < count; i++)
    {
        AMapNaviPoint *coordinate = [[aRoute routeCoordinates] objectAtIndex:i];
        coords[i].latitude = [coordinate latitude];
        coords[i].longitude = [coordinate longitude];
    }
    
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coords count:count];
    
    SelectableOverlay *selectablePolyline = [[SelectableOverlay alloc] initWithOverlay:polyline];
    
    [self.mapView addOverlay:selectablePolyline];
    free(coords);
    
    NSString *subtitle = [NSString stringWithFormat:@"长度:%ld米 | 预估时间:%ld秒 | 分段数:%ld", (long)aRoute.routeLength, (long)aRoute.routeTime, (long)aRoute.routeSegments.count];
    NSLog(@"%@",subtitle);
    
    long walkMinute = walkManager.naviRoute.routeTime / 60;
    NSString *timeDesc = @"1分钟以内";
    if (walkMinute > 1){
        timeDesc = [NSString stringWithFormat:@"%ld分钟",walkMinute];
    }
    
    self.showView.label_minutes.text = timeDesc;
    //self.showView.label_distance.text = [NSString stringWithFormat:@"%.1fkm",(float)aRoute.routeLength/1000];
    
    self.label_distance=[NSString stringWithFormat:@"%.1fkm",(float)aRoute.routeLength/1000];
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    
    if ([overlay isKindOfClass:[SelectableOverlay class]])
    {
        SelectableOverlay * selectableOverlay = (SelectableOverlay *)overlay;
        id<MAOverlay> actualOverlay = selectableOverlay.overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:actualOverlay];
        
        polylineRenderer.lineWidth = 4.f;
        polylineRenderer.strokeColor = selectableOverlay.isSelected ? selectableOverlay.selectedColor : selectableOverlay.regularColor;
        
        //是否虚线
        polylineRenderer.lineDash=YES;
        
        return polylineRenderer;
    }
    
    return nil;
}
- (void)selecteOverlayWithRouteID:(NSInteger)routeID{
    
    [self.mapView.overlays enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id<MAOverlay> overlay, NSUInteger idx, BOOL *stop)
     {
         if ([overlay isKindOfClass:[SelectableOverlay class]])
         {
             SelectableOverlay *selectableOverlay = overlay;
             
             /* 获取overlay对应的renderer. */
             MAPolylineRenderer * overlayRenderer = (MAPolylineRenderer *)[self.mapView rendererForOverlay:selectableOverlay];
             
             if (selectableOverlay.routeID == routeID)
             {
                 /* 设置选中状态. */
                 selectableOverlay.selected = YES;
                 
                 /* 修改renderer选中颜色. */
                 overlayRenderer.fillColor   = selectableOverlay.selectedColor;
                 overlayRenderer.strokeColor = selectableOverlay.selectedColor;
                 
                 /* 修改overlay覆盖的顺序. */
                 [self.mapView exchangeOverlayAtIndex:idx withOverlayAtIndex:self.mapView.overlays.count - 1];
             }
             else
             {
                 /* 设置选中状态. */
                 selectableOverlay.selected = NO;
                 
                 /* 修改renderer选中颜色. */
                 overlayRenderer.fillColor   = selectableOverlay.regularColor;
                 overlayRenderer.strokeColor = selectableOverlay.regularColor;
                 
             }
             
             [overlayRenderer glRender];
         }
     }];
}

#pragma mark -跳转详情页
- (void)gotoVC{
    
    DetailedViewController*detailedVC=[[DetailedViewController alloc] init];
    
    detailedVC.addressLabel=self.address;
    
    detailedVC.distanceLabel=self.label_distance;
    
    [self presentViewController:detailedVC animated:YES completion:nil];
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
    visualEfView.alpha = 0.2;
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

