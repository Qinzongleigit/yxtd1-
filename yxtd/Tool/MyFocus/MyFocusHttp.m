//
//  MyFocusHttp.m
//  yxtd
//
//  Created by qin on 2018/2/6.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "MyFocusHttp.h"

@implementation MyFocusHttp

+(void)httpMyFocus:(MyFocusParam *)httpParam success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [CDHttpTool GET:MyFocus parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
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
