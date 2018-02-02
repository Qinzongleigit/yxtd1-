//
//  GuanZhuHttp.m
//  yxtd
//
//  Created by qin on 2018/2/2.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "GuanZhuHttp.h"

@implementation GuanZhuHttp

+(void)httpGuanzhu:(MineUserMessageParam *)httpParam success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    
    [CDHttpTool GET:Guanzhu parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
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
