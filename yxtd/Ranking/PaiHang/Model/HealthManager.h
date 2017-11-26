//
//  HealthManager.h
//  yxtd
//
//  Created by qin on 2017/9/30.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface HealthManager : NSObject

@property (nonatomic,strong) HKHealthStore*healthStore;

+(id)shareInstance;

/*!
 *  @brief  获取当天实时步数
 *
 *  @param handler 回调
 */

- (void)getRealTimeStepCountCompletionHandler:(void(^)(double value,double time, NSError *error))handler;

/*!
 *  @brief  获取卡路里
 *
 *  @param predicate    时间段
 *  @param quantityType 样本类型
 *  @param handler      回调
 */

- (void)getKilocalorieUnit:(NSPredicate *)predicate quantityType:(HKQuantityType*)quantityType completionHandler:(void(^)(double value, NSError *error))handler;

/*!
 *  @brief  当天时间段
 *
 *  @return ,,,
 */
+ (NSPredicate *)predicateForSamplesToday;

/*!
 *  @brief  获取行走距离（公里）
 *
 *
 */
- (void)getDistance:(void(^)(double value, NSError *error))completion;

/*
 *  @brief  检查是否支持获取健康数据
 */
- (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))compltion;

@end
