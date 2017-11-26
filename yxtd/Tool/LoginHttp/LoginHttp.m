//
//  LoginHttp.m
//  yxtd
//
//  Created by qin on 2017/11/15.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "LoginHttp.h"
#import "CDHttpTool.h"
#import  <MJExtension.h>


@implementation LoginHttp


+(void)httpLogin:(LoginParam *)httpParam success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [CDHttpTool GET:LoginMemberLogin parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
        
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
