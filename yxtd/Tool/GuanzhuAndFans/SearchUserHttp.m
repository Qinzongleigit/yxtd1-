//
//  SearchUserHttp.m
//  yxtd
//
//  Created by qin on 2018/2/4.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "SearchUserHttp.h"

@implementation SearchUserHttp

+(void)httpSearchUser:(MineUserMessageParam *)httpParam success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    
    [CDHttpTool GET:SearchuUser parameters:httpParam.mj_keyValues success:^(id responseObject) {
        
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
