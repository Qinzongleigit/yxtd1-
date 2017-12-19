//
//  UIView+XMGExtension.h
//  yxtd
//
//  Created by qin on 2017/12/19.
//  Copyright © 2017年 qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMGExtension)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

@end
