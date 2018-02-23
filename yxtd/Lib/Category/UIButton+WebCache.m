//
//  UIButton+WebCache.m
//  yxtd
//
//  Created by qin on 2018/2/23.
//  Copyright © 2018年 qin. All rights reserved.
//

#import "UIButton+WebCache.h"

@implementation UIButton (WebCache)

-(void)setButtonBgImageWithUrl:(NSString *)urlStr{
    
    
    NSURL * url = [NSURL URLWithString:urlStr];

    // 根据图片的url下载图片数据
 
    dispatch_queue_t btQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
  
    dispatch_async(btQueue, ^{
 
        // 异步下载图片

        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
  
        // 主线程刷新UI
        
        dispatch_async(dispatch_get_main_queue(), ^{
  
            [self setImage:img forState:UIControlStateNormal];
            
        });
        
        
        
    });
    
}

@end
