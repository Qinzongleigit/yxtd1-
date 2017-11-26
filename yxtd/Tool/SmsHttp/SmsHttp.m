//
//  SmsHttp.m
//  yxtd
//
//  Created by qin on 2017/11/14.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "SmsHttp.h"
#import "CDHttpTool.h"
#import <MJExtension.h>

@implementation SmsHttp

+(void)httpSms:(SmsParam *)httpParam success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [CDHttpTool GET:RegiserGetSms parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
       
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSError *error) {
       
        if (failure) {
            
            failure(error);
        }
        
    }];
    
}

@end
