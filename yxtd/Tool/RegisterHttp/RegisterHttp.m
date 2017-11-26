//
//  RegisterHttp.m
//  yxtd
//
//  Created by qin on 2017/11/14.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "RegisterHttp.h"
#import <MJExtension.h>
#import "CDHttpTool.h"


@implementation RegisterHttp


+ (void)httpForRegister:(RegisterParam *)httpParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error)) failure

{
    [CDHttpTool GET:RegiserMobileNumber parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(NSError *error) {
        
        if (failure)
        {
            failure(error);
        }
        
    }];
}

@end
