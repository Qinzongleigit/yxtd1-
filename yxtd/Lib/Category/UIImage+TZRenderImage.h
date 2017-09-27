//
//  UIImage+TZRenderImage.h
//  yxtd
//
//  Created by qin on 2017/9/13.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TZRenderImage)

//加载原始图片，没有渲染
+(instancetype)imageWithoriginName:(NSString*)imgeName;
//加载拉伸图片
+(instancetype)imageWithStretchableName:(NSString*)imageName;

@end
