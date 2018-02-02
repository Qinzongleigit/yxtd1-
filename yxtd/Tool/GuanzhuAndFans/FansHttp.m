//
//  FansHttp.m
//  yxtd
//
//  Created by qin on 2018/2/2.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "FansHttp.h"

@implementation FansHttp

+(void)httpFans:(MineUserMessageParam *)httpParam success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    
    [CDHttpTool GET:Fans parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
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
