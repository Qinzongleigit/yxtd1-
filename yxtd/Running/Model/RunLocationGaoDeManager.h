//
//  RunLocationGaoDeManager.h
//  yxtd
//
//  Created by qin on 2017/10/20.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^locationBlock)(NSString *lat,NSString *lon);

@interface RunLocationGaoDeManager : NSObject

+ (instancetype)sharedManager;

- (void)getGps:(locationBlock)block;

@property (nonatomic,copy) NSString *lat_gaode;
@property (nonatomic,copy) NSString *lon_gaode;
@property (nonatomic,strong) NSString *current_city;
@property (nonatomic,strong) NSString *showCityMsg;


@end
