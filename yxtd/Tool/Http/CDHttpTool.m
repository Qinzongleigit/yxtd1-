//
//  CDHttpTool.m
//  yydb
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CDHttpTool.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "MBProgressHUD+MJ.h"


#define CustomErrorDomain @"com.yyzl.reachabilityTest"
typedef enum {
    
    XDefultFailed = -1000,
    
    XRegisterFailed,
    
    XConnectFailed,
    
    XNotBindedFailed
    
    
    
}CustomErrorFailed;

@implementation CDHttpTool

static Reachability *reach;

+ (void)GET:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure
{
    BOOL reachabilityFlag = [self reachabilityChanged];
    
    if (!reachabilityFlag) {
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请检查网络连接状况" forKey:NSLocalizedDescriptionKey];
        
        NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XConnectFailed userInfo:userInfo];
        
        failure(aError);
        
        return;
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer.timeoutInterval = 20.f;
    
    //超时连接
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

   //设置允许接收返回数据类型：
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
    
    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(responseObject);
            
//            NSLog(@"接口请求成功返回的数据信息：--------------------------:%@",responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请求失败" forKey:NSLocalizedDescriptionKey];
            
            NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
            
            failure(aError);
            
        }
        
    }];

    
//    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (success) {
//
//            success(responseObject);
//
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//
//            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请求失败" forKey:NSLocalizedDescriptionKey];
//
//            NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
//
//            failure(aError);
//
//        }
//    }];
}

+ (void)POST:(NSString *)urlStr parameters:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure
{
    BOOL reachabilityFlag = [self reachabilityChanged];
    
    if (!reachabilityFlag) {

        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请检查网络连接状况" forKey:NSLocalizedDescriptionKey];
        
        NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XConnectFailed userInfo:userInfo];
        
        failure(aError);
        
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //设置允许接收返回数据类型：
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
    
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
                if (failure) {
        
                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请求失败" forKey:NSLocalizedDescriptionKey];
        
                    NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
        
                    failure(aError);
        
                }
        
    }];
    
    
//    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (success) {
//
//            success(responseObject);
//
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//
//            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"请求失败" forKey:NSLocalizedDescriptionKey];
//
//            NSError *aError = [NSError errorWithDomain:CustomErrorDomain code:XDefultFailed userInfo:userInfo];
//
//            failure(aError);
//
//        }
//    }];
}

+ (void)load
{
    // 判断能否连接到某一个主机
    // http://www.baidu.com
    reach = [Reachability reachabilityWithHostName:@"baidu.com"];

}

+ (BOOL)reachabilityChanged
{
    // 状态
    if (reach.currentReachabilityStatus == NotReachable) return 0;
    
    return 1;
 
}



@end
