//
//  UIImage+TZRenderImage.m
//  yxtd
//
//  Created by qin on 2017/9/13.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "UIImage+TZRenderImage.h"

@implementation UIImage (TZRenderImage)


//原始图片
+(instancetype)imageWithoriginName:(NSString *)imgeName{
    
    UIImage*image=[UIImage imageNamed:imgeName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

//拉伸图片

+(instancetype)imageWithStretchableName:(NSString *)imageName{
    
    UIImage*image=[UIImage imageNamed:imageName];
    
    
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}



@end
