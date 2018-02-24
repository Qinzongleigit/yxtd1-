//
//  DianZanHttp.m
//  yxtd
//
//  Created by qin on 2018/2/24.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "DianZanHttp.h"

@implementation DianZanHttp

+(void)httpDianZan:(DianZanParam *)httpParam success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [CDHttpTool GET:DianZan parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
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
