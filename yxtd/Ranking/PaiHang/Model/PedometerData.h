//
//  PedometerData.h
//  yxtd
//
//  Created by qin on 2018/1/17.
//  Copyright © 2018年 qin. All rights reserved.
//

/**
 *  计步器数据实体，iOS7及iOS7以下只有numberOfSteps
 */

#import <Foundation/Foundation.h>

@interface PedometerData : NSObject

/**
 *  步数
 */
@property(nonatomic, strong, nullable) NSNumber *numberOfSteps;

/**
 *  步行+跑步距离
 */
@property(nonatomic, strong, nullable) NSNumber *distance;

///*
// * 上楼
// */
//@property(nonatomic, strong, nullable) NSNumber *floorsAscended;
//
///*
// * 下楼
// */
//@property(nonatomic, strong, nullable) NSNumber *floorsDescended;

@end
