//
//  PedometerManager.h
//  yxtd
//
//  Created by qin on 2018/1/17.
//  Copyright © 2018年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PedometerData.h"

typedef void (^PedometerHandler)(PedometerData *pedometerData, NSError *error);

@interface PedometerManager : NSObject

+ (PedometerManager *)shared;
/**
 *  计步器是否可以使用
 *
 *  @return YES or NO
 */
+ (BOOL)isStepCountingAvailable;
/**
 *  查询某时间段的行走数据
 *
 *  @param start   开始时间
 *  @param end     结束时间
 *  @param handler 查询结果
 */
- (void)queryPedometerDataFromDate:(NSDate *)start
                            toDate:(NSDate *)end
                       withHandler:(PedometerHandler)handler;
/**
 *  监听今天（从零点开始）的行走数据
 *
 *  @param handler 查询结果、变化就更新
 */
- (void)startPedometerUpdatesTodayWithHandler:(PedometerHandler)handler;
/**
 *  停止监听运动数据
 */
- (void)stopPedometerUpdates;


@end
