//
//  CDMyButton.m
//  yxtd
//
//  Created by qin on 2017/9/28.
//  Copyright © 2017年 qin. All rights reserved.
//

#import "CDMyButton.h"
#import <UIImageView+WebCache.h>

@implementation CDMyButton



- (instancetype)addOneDuobaoBtn
{
    CDMyButton *btn = [CDMyButton buttonWithType:UIButtonTypeCustom];
    
    return btn;
}


// --------------根据图片和标题设置按钮---------
- (void)setUpBtnImage:(UIImage *)img Title:(NSString *)title
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.image = img;
    
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = BlackHexColor;
    
    label.text = title;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:label];
}

// -----------设置布局---------------
- (void)layoutSubviews
{
    CGFloat margin = 5;
    
    CGFloat x = 0;
    
    CGFloat y = 0;
    
    CGFloat width = self.width;
    
    CGFloat height = self.height;
    
    for (UIView *subView in self.subviews)
    {
        if ([subView isKindOfClass:[UIImageView class]])
        {
            CGFloat imageWidth = _imageWidth;
            
            CGFloat imageHeight = imageWidth;
            
            CGFloat imageX = (width - imageWidth) / 2;
            
            subView.frame = CGRectMake(imageX, margin, imageWidth, imageHeight);
            
        }else if ([subView isKindOfClass:[UILabel class]])
        {
            y = _imageWidth + 2 * margin;
            
            subView.frame = CGRectMake(x, y, width, height - _imageWidth);
        }
    }
}




@end
