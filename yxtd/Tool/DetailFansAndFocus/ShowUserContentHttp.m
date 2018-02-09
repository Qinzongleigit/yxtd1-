//
//  ShowUserContentHttp.m
//  yxtd
//
//  Created by qin on 2018/2/9.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "ShowUserContentHttp.h"

@implementation ShowUserContentHttp


+(void)httpShowUserContent:(MyFocusParam *)httpParam success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    [CDHttpTool GET:ShowUserContent parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
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
