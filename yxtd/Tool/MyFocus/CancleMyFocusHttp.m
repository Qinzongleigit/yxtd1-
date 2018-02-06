//
//  CancleMyFocusHttp.m
//  yxtd
//
//  Created by qin on 2018/2/6.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "CancleMyFocusHttp.h"

@implementation CancleMyFocusHttp

+(void)httpCancleMyFocus:(MyFocusParam *)httpParam success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [CDHttpTool GET:CancleMyFocus parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
        
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
