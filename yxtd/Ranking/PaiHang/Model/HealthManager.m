//
//  HealthManager.m
//  yxtd
//
//  Created by qin on 2017/9/30.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "HealthManager.h"

#import <UIKit/UIDevice.h>
#import "HKHealthStore+AAPLExtensions.h"

#define HKVersion [[[UIDevice currentDevice] systemVersion] doubleValue]
#define CustomHealthErrorDomain @"com.yxtd.paoquan"


@implementation HealthManager


#pragma mark -单例类
+(id)shareInstance
{
    static id manager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

/*!
 *  @brief  检查是否支持获取健康数据
 */
#pragma mark - 检查是否支持获取健康数据

- (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))compltion
{
    if(HKVersion >= 8.0)
    {
        if (![HKHealthStore isHealthDataAvailable]) {
            NSError *error = [NSError errorWithDomain: @"com.raywenderlich.tutorials.healthkit" code: 2 userInfo: [NSDictionary dictionaryWithObject:@"HealthKit is not available in th is Device"                                                                      forKey:NSLocalizedDescriptionKey]];
            if (compltion != nil) {
                compltion(false, error);
            }
            return;
        }
        if ([HKHealthStore isHealthDataAvailable]) {
            if(self.healthStore == nil)
                self.healthStore = [[HKHealthStore alloc] init];
            /*
             组装需要读写的数据类型
             */
            NSSet *writeDataTypes = [self dataTypesToWrite];
            NSSet *readDataTypes = [self dataTypesRead];
            
            /*
             注册需要读写的数据类型，也可以在“健康”APP中重新修改
             */
            [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
                
                if (compltion != nil) {
                   // NSLog(@"error->%@", error.localizedDescription);
                    compltion (success, error);
                }
            }];
        }
    }
    else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"iOS 系统低于8.0"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *aError = [NSError errorWithDomain:CustomHealthErrorDomain code:0 userInfo:userInfo];
        compltion(0,aError);
    }
}

/*!
 *  @brief  写权限
 *
 *  @return 集合
 */
- (NSSet *)dataTypesToWrite
{
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *temperatureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    HKQuantityType *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    
    return [NSSet setWithObjects:heightType, temperatureType, weightType,activeEnergyType,nil];
}

/*!
 *  @brief  读权限
 *
 *  @return 集合
 */
- (NSSet *)dataTypesRead
{
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *temperatureType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    HKCharacteristicType *sexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    
    HKQuantityType *distance = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    return [NSSet setWithObjects:heightType, temperatureType,birthdayType,sexType,weightType,stepCountType, activeEnergyType,distance, nil];
}

/*!
 *
 *  @brief  实时获取当天步数
 */
- (void)getRealTimeStepCountCompletionHandler:(void(^)(double value,double time, NSError *error))handler
{
    if(HKVersion < 8.0)
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"iOS 系统低于8.0"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *aError = [NSError errorWithDomain:CustomHealthErrorDomain code:0 userInfo:userInfo];
        handler(0,0,aError);
    }
    else
    {
 
        
        HKSampleType *sampleType =
        [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        
        
        HKObserverQuery *query =
        [[HKObserverQuery alloc]
         initWithSampleType:sampleType
         predicate:nil
         updateHandler:^(HKObserverQuery *query,
                         HKObserverQueryCompletionHandler completionHandler,
                         NSError *error) {
             if (error) {
                 
                                 abort();
             }
             [self getStepCount:[HealthManager predicateForSamplesToday] completionHandler:^(double value,double time, NSError *error) {
                 handler(value,time,error);
             }];
         }];
        [self.healthStore executeQuery:query];
    }
}

#pragma mark -获取步数
- (void)getStepCount:(NSPredicate *)predicate completionHandler:(void(^)(double value,double time, NSError *error))handler
{
    
    if(HKVersion < 8.0)
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"iOS 系统低于8.0"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *aError = [NSError errorWithDomain:CustomHealthErrorDomain code:0 userInfo:userInfo];
        handler(0,0,aError);
    }
    else
    {
        HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        
        [self.healthStore aapl_mostRecentQuantitySampleOfType:stepType predicate:predicate completion:^(NSArray *results, NSError *error) {
            if(error)
            {
                handler(0,0,error);
            }
            else
            {
                NSInteger totleSteps = 0;
                double  sumTime=0;
                for(HKQuantitySample *quantitySample in results)
                {
                    HKQuantity *quantity = quantitySample.quantity;
                    HKUnit *heightUnit = [HKUnit countUnit];
                    double usersHeight = [quantity doubleValueForUnit:heightUnit];
                    totleSteps += usersHeight;
                    
                    //运动时间
                    NSDateFormatter *fm=[[NSDateFormatter alloc]init];
                    fm.dateFormat=@"yyyy-MM-dd HH:mm:ss";
                    NSString *strNeedStart = [fm stringFromDate:quantitySample.startDate];
                    NSLog(@"startDate %@",strNeedStart);
                    NSString *strNeedEnd = [fm stringFromDate:quantitySample.endDate];
                    NSLog(@"endDate %@",strNeedEnd);
                    sumTime += [quantitySample.endDate timeIntervalSinceDate:quantitySample.startDate];
                }
                //DebugLog(@"当天行走步数 = %ld",totleSteps);
                handler(totleSteps,sumTime,error);
            }
        }];
    }
}




#pragma mark -获取卡路里
- (void)getKilocalorieUnit:(NSPredicate *)predicate quantityType:(HKQuantityType*)quantityType completionHandler:(void(^)(double value, NSError *error))handler
{
    
    if(HKVersion < 8.0)
    {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"iOS 系统低于8.0"                                                                      forKey:NSLocalizedDescriptionKey];
        NSError *aError = [NSError errorWithDomain:CustomHealthErrorDomain code:0 userInfo:userInfo];
        handler(0,aError);
    }
    else
    {
        HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
            HKQuantity *sum = [result sumQuantity];
            
            double value = [sum doubleValueForUnit:[HKUnit kilocalorieUnit]];
            //NSLog(@"%@卡路里 ---> %.2lf",quantityType.identifier,value);
            if(handler)
            {
                handler(value,error);
            }
        }];
        [self.healthStore executeQuery:query];
    }
}

#pragma mark  获取公里数

- (void)getDistance:(void(^)(double value, NSError *error))completion
{
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:distanceType predicate:[HealthManager predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        if(error)
        {
            completion(0,error);
        }
        else
        {
            double totleSteps = 0;
            for(HKQuantitySample *quantitySample in results)
            {
                HKQuantity *quantity = quantitySample.quantity;
                HKUnit *distanceUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixKilo];
                double usersHeight = [quantity doubleValueForUnit:distanceUnit];
                totleSteps += usersHeight;
            }
            //NSLog(@"当天行走距离 = %.2f",totleSteps);
            completion(totleSteps,error);
        }
    }];
    [self.healthStore executeQuery:query];
}


+ (NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}




@end
