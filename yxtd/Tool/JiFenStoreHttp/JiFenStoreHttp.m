//
//  JiFenStoreHttp.m
//  yxtd
//
//  Created by qin on 2018/1/30.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "JiFenStoreHttp.h"

@implementation JiFenStoreHttp

+(void)httpJiFenStore:(MineUserMessageParam *)httpParam success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [CDHttpTool GET:JiFenStoreCanDuiHuan parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
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
