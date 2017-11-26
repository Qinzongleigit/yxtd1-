//
//  RunLocationGaoDeManager.m
//  yxtd
//
//  Created by qin on 2017/10/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "RunLocationGaoDeManager.h"
#import <CoreLocation/CoreLocation.h>

@interface RunLocationGaoDeManager()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locManager;
@property (nonatomic,strong) locationBlock block;

@end

@implementation RunLocationGaoDeManager


+ (instancetype)sharedManager{
    
    static RunLocationGaoDeManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RunLocationGaoDeManager alloc]init];
    });
    
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _locManager = [[CLLocationManager alloc]init];
        //精确度
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //精确到几百米
        _locManager.distanceFilter = 1;
        _locManager.delegate = self;
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"开启服务");
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"手机未开启定位服务，请到【设置】- 【程序】-【位置】中打开" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locManager requestWhenInUseAuthorization];
            }
        }
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    CLLocation *location= [locations lastObject];
    
    NSString *lat = [NSString stringWithFormat:@"%@",@(location.coordinate.latitude)];
    NSString *lon = [NSString stringWithFormat:@"%@",@(location.coordinate.longitude)];
    
    [RunLocationGaoDeManager sharedManager].lat_gaode = lat;
    [RunLocationGaoDeManager sharedManager].lon_gaode = lon;
    
    // 保存 Device 的现语言 (英语 法语 ，，，)
    CLGeocoder *geoCoder=[CLGeocoder new];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark *placemark in placemarks) {
            
            self.current_city = placemark.addressDictionary[@"City"];
            self.showCityMsg = [NSString stringWithFormat:@"%@ %@",placemark.addressDictionary[@"SubLocality"],placemark.addressDictionary[@"Street"]];
        }
    }];
    
    self.block(lat,lon);
    [self.locManager stopUpdatingLocation];
}

-(void)getGps:(locationBlock)block{
    self.block = block;
    [self.locManager startUpdatingLocation];
}

@end
